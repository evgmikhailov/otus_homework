#!/bin/bash
read -p "Введите путь к папке с временными файлами : " DIR_TMP
if [ -e $DIR_TMP ]
    then
        echo 'Указанная папка найдена'
       # Подсчёт общего количества файлов
	allfiles=`ls -l $DIR_TMP | wc -l`
	echo "В данной папке $allfiles файлов"
	echo "Из них файлов с расширением *.bak"
        find -type f -name "*.bak" | wc -w
	echo "с расширением *.backup"
        find -type f -name "*.backup" | wc -w
	echo "с расширением *.tmp"
        find -type f -name "*.tmp" | wc -w
	cd $DIR_TMP
        echo 'Запускаю удаление'
        rm -v *.bak *.tmp *.backup
        echo 'Удаление завершено успешно'
    else
        echo 'Указанная папка не найдена! Удаление невозможно'
        exit 2
fi
