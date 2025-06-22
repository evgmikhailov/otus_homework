#!/bin/bash

# Функция для нагрузки CPU
cpu_task() {
    local name=$1
    local nice_val=$2
    echo "[$name] Запуск с nice=$nice_val"
# Замеряем время выполнения и выводим только real time
    /usr/bin/time -f "[$name] Время выполнения: %E" bash -c "
        renice -n $nice_val -p \$\$ >/dev/null
        for i in {1..50000}; do
            awk 'BEGIN {print sin(\$i) + cos(\$i)}' >/dev/null
        done
    "
}

# Запускаем процессы в фоне
cpu_task "Процесс 1 (низкий приоритет)" 19 &
pid1=$!

cpu_task "Процесс 2 (высокий приоритет)" -20 &
pid2=$!

# Ждём завершения
wait $pid1 $pid2
echo "Тестирование завершено."
