
##### Задача 2.18  по Сборнику УТ 11.4

- [вычисляем Поле `Вес`](https://github.com/alex-dev-2020/Spec_UT/commit/f50bb6ee7c11131d889c5e6a7048a0c113ea0708) 
 
    `РеализацияТоваровУслугТовары.Номенклатура.ВесЧислитель / РеализацияТоваровУслугТовары.Номенклатура.ВесЗнаменатель`
    - c учетом :
        - Проверка `ЕСТЬNULL`  
        - Поле `Вес` может быть в Справочнике `Упаковки` 

-  [добавлены Еденицы Измерения с учетом :](https://github.com/alex-dev-2020/Spec_UT/commit/f7103a81876f2964cbd19a8b720bdf3d03f50de0)

    - если Упаковки не используются = > берем Единицы измерения из Номенклатуры


###### Закладка СКД  `Ресурсы` 

- [Выражение для Поля `Класс`](https://github.com/alex-dev-2020/Spec_UT/commit/bbff95c553a92454dcea8d6966cfbc6410540d4f) символы `ABC` **должны быть в английской**  раскладке

###### Закладка СКД  `Макеты`

- [Выражение для Поля `Класс`](https://github.com/alex-dev-2020/Spec_UT/commit/bf709c381ed3c486188952c1aff6cb12ed22e3f9)

###### Модуль Объекта

- [Добавлены сведения о Внешней Обработке](https://github.com/alex-dev-2020/Spec_UT/commit/765923744b9f81a2933d7405f0fc01a3ebb757a7) 

- [Добавлена Функция `ПолучитьТаблицуКоманд`](https://github.com/alex-dev-2020/Spec_UT/commit/f8ba5a4ecdaceb4bfc33aeb3671bc9fff564b231)

- [Добавлена Процедура `ДобавитьКоманду`](https://github.com/alex-dev-2020/Spec_UT/commit/f5b7b88f009493c3a532f5ba4d92889b7f6488b5)

- [Добавлена Процедура `Печать`](https://github.com/alex-dev-2020/Spec_UT/commit/daf35151c5df8c09889954d944cf7e7dea2a5228) **обязательно** `Экспорт`

- [Добавлена Процедура `СформироватьПечатнуюФормуЧерезСКД`](https://github.com/alex-dev-2020/Spec_UT/commit/f946804de9349063c428a534a1bbbc455205a471)