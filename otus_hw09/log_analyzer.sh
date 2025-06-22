#!/bin/bash

# Файл блокировки для предотвращения множественного запуска
LOCKFILE="/tmp/log_analyzer.lock"

# Основной лог-файл для анализа (изменить на свой путь!!!!!!!!)
LOG_FILE="/var/log/access123.log"

# Email для отправки отчетов (изменить на свой email!!!!!!!!)
REPORT_EMAIL="hw09@otus.ru"

# Временные файлы
TMP_FILE="/tmp/log_analysis.tmp"
LAST_RUN_FILE="/tmp/log_analyzer.lastrun"

### Функции ###

# Инициализация и проверка окружения
init_environment() {
    # Проверка существования лог-файла
    if [ ! -f "${LOG_FILE}" ]; then
        echo "Ошибка: Лог-файл не найден: ${LOG_FILE}" >&2
        exit 1
    fi

    # Создание файла последнего запуска, если не существует
    touch "${LAST_RUN_FILE}" 2>/dev/null || {
        echo "Ошибка: Невозможно создать файл ${LAST_RUN_FILE}" >&2
        exit 1
    }
}

# Проверка блокировки
check_lock() {
    if [ -e "${LOCKFILE}" ] && kill -0 "$(cat "${LOCKFILE}")" 2>/dev/null; then
        echo "Скрипт уже выполняется (PID: $(cat "${LOCKFILE}"))" >&2
        exit 1
    fi
}

# Установка блокировки
set_lock() {
    echo $$ > "${LOCKFILE}" || {
        echo "Ошибка: Невозможно создать lock-файл" >&2
        exit 1
    }
}

# Определение временного диапазона
set_time_range() {
    if [ -s "${LAST_RUN_FILE}" ]; then
        LAST_RUN_TIME=$(cat "${LAST_RUN_FILE}")
        # Преобразуем в формат лога: [14/Aug/2019:04:12:10 +0300]
        START_TIME=$(date -d "${LAST_RUN_TIME}" "+%d/%b/%Y:%H:%M:%S" 2>/dev/null) || {
            echo "Используется дата по умолчанию" >&2
            START_TIME="01/Jan/1990:00:00:00"
        }
    else
        START_TIME="01/Jan/1990:00:00:00" # Если скрипт запускается впервые
    fi

    END_TIME=$(date "+%d/%b/%Y:%H:%M:%S")
    date "+%Y-%m-%d %H:%M:%S" > "${LAST_RUN_FILE}" 2>/dev/null || {
        echo "Предупреждение: Невозможно обновить файл последнего запуска" >&2
    }
}

# Извлечение логов за указанный период
extract_logs() {
    echo "[$(date)] Извлечение логов за период: ${START_TIME} - ${END_TIME}" >&2

    awk -v start="[${START_TIME}" -v end="[${END_TIME}" '
        $0 ~ /\[/ {
            if ($4 >= start && $4 <= end) {
                print $0
            }
        }
    ' "${LOG_FILE}" > "${TMP_FILE}"
}

# Генерация отчета
generate_report() {
    local report="Лог-анализатор веб-сервера\n"
    report+="Временной диапазон: ${START_TIME} - ${END_TIME}\n"
    report+="Общее количество запросов: $(wc -l < "${TMP_FILE}")\n"
    report+="\n========================================\n"

    # 1. Топ IP по количеству запросов
    report+="\nТоп 10 IP-адресов:\n"
    report+="$(awk '{print $1}' "${TMP_FILE}" | sort | uniq -c | sort -nr | head -10)\n"

    # 2. Топ URL по количеству запросов
    report+="\nТоп 10 запрашиваемых URL:\n"
    report+="$(awk '{print $7}' "${TMP_FILE}" | sort | uniq -c | sort -nr | head -10)\n"

    # 3. Ошибки сервера/приложения
    report+="\nОшибки сервера (4xx и 5xx):\n"
    report+="$(awk '$9 >= 400 {print $9, $7}' "${TMP_FILE}" | sort | uniq -c | sort -nr)\n"

    # 4. Все коды HTTP ответа
    report+="\nСтатистика кодов HTTP ответа:\n"
    report+="$(awk '{print $9}' "${TMP_FILE}" | sort | uniq -c | sort -nr)\n"

    echo -e "${report}"
}

# Очистка временных файлов
cleanup() {
    rm -f "${TMP_FILE}"
    rm -f "${LOCKFILE}"
}

### Основной поток выполнения ###

# Инициализация
init_environment

# Проверка блокировки
check_lock

# Установка блокировки
set_lock

# Установка обработчиков для корректного завершения
trap 'cleanup; exit' INT TERM EXIT

# Определение временного диапазона
set_time_range

# Извлечение логов
extract_logs

# Генерация и отправка отчета
REPORT=$(generate_report)
echo -e "${REPORT}" | mail -s "Отчет анализа логов за $(date '+%Y-%m-%d %H:%M')" "${REPORT_EMAIL}"

# Очистка
cleanup

exit 0
