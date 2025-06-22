#!/bin/bash

echo "PID TTY      STAT   TIME COMMAND"

for pid in $(ls -1 /proc | grep -E '^[0-9]+$' | sort -n); do
    if [ ! -d "/proc/$pid" ]; then
        continue
    fi

    # Читаем данные из /proc/<PID>/stat
    if [ ! -r "/proc/$pid/stat" ]; then
        continue
    fi
    stat=$(cat "/proc/$pid/stat")
    read -r -a stat_array <<< "$stat"

    # Парсим состояние и TTY из stat
    state="${stat_array[2]}"
    tty_nr="${stat_array[6]}"

    # Определяем TTY с поддержкой pts/N
    tty="?"
    if [ "$tty_nr" -ne 0 ]; then
        tty_dev=$(printf "%03x" "$tty_nr")
        tty_major=$((0x${tty_dev:0:2}))
        tty_minor=$((0x${tty_dev:2:1}${tty_dev:3:1}))

        if [ "$tty_major" -eq 4 ]; then
            tty="tty$tty_minor"
        elif [ "$tty_major" -eq 136 ]; then
            tty="pts/$tty_minor"
        fi
    fi

    # Время процесса (из stat)
    utime="${stat_array[13]}"
    stime="${stat_array[14]}"
    total_ticks=$((utime + stime))
    clock_ticks_per_sec=$(getconf CLK_TCK)
    total_sec=$((total_ticks / clock_ticks_per_sec))
    minutes=$((total_sec / 60))
    seconds=$((total_sec % 60))
    time=$(printf "%02d:%02d" "$minutes" "$seconds")

    # Имя процесса (из /proc/<PID>/status или cmdline)
    if [ -r "/proc/$pid/status" ]; then
        name=$(grep -E "^Name:" "/proc/$pid/status" | cut -f2)
    else
        name="${stat_array[1]//[()]/}"
    fi

    # Полный командный путь (из /proc/<PID>/cmdline)
    if [ -r "/proc/$pid/cmdline" ]; then
        cmdline=$(tr '\0' ' ' < "/proc/$pid/cmdline" | sed 's/ $//')
        if [ -n "$cmdline" ]; then
            name="$cmdline"
        fi
    fi

    # Вывод строки
    printf "%-5s %-8s %-6s %-8s %s\n" "$pid" "$tty" "$state" "$time" "$name"
done
