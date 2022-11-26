


Функция ТекстЗапросаТаблицаТоварыКПоступлению(Запрос, ТекстыЗапроса, Регистры)
		
	ИмяРегистра = "ТоварыКПоступлению";
	
	Если НЕ ПроведениеСерверУТ.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли; 
	
	УстановитьПараметрыЗапросаСведенийПоПоступлениям(Запрос);
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) КАК ВидДвижения,
	|	&Период                                КАК Период,
	|	ТаблицаТовары.ЗаказПоставщику          КАК ДокументПоступления,
	|	ТаблицаТовары.Склад                    КАК Склад,
	|	&Отправитель                           КАК Отправитель,
	|	ТаблицаТовары.Номенклатура             КАК Номенклатура,
	|	ТаблицаТовары.Характеристика           КАК Характеристика,
	|	ВЫБОР
	|		КОГДА ЕСТЬNULL(ТаблицаТовары.Назначение.ДвиженияПоСкладскимРегистрам, ЛОЖЬ)
	|			ТОГДА ТаблицаТовары.Назначение
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка)
	|	КОНЕЦ                                  КАК Назначение,
	|	&ХозяйственнаяОперация                 КАК ХозяйственнаяОперация,
	|	ЗНАЧЕНИЕ(Справочник.СерииНоменклатуры.ПустаяСсылка) КАК Серия,
	|	ТаблицаТовары.Количество               КАК КОформлениюНакладныхПоРаспоряжению,
	|	0                                      КАК КОформлениюПоступленийПоРаспоряжению,
	|	0                                      КАК КОформлениюПоступленийПоОрдерам,
	|	0                                      КАК КОформлениюОрдеров,
	|	0                                      КАК КОформлениюПоступленийПоНакладным
	|ИЗ
	|	Документ.ПриобретениеТоваровУслуг.Товары КАК ТаблицаТовары
	|ГДЕ
	|	ТаблицаТовары.Ссылка = &Ссылка
	|	И НЕ &ИспользуетсяДокументПоступлениеТоваров
	|	И &ПоступлениеПоЗаказам
	|	И ТаблицаТовары.Номенклатура.ТипНоменклатуры В (ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.Товар),
	|		ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.МногооборотнаяТара))
	|	И ТаблицаТовары.КодСтроки <> 0
	|	И &ХозяйственнаяОперация <> ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаУПоставщикаРеглУчет)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) КАК ВидДвижения,
	|	&Период                                КАК Период,
	|	ВЫБОР
	|		КОГДА (&ДоговорЯвляетсяРаспоряжением
	|				ИЛИ &НакладнаяЯвляетсяРаспоряжением
	|				ИЛИ НЕ &ПоступлениеПоЗаказам)
	|			ТОГДА &ДокументПоступления
	|		ИНАЧЕ ТаблицаТовары.ЗаказПоставщику
	|	КОНЕЦ                                  КАК ДокументПоступления,
	|	ТаблицаТовары.Склад                    КАК Склад,
	|	&Отправитель                           КАК Отправитель,
	|	ТаблицаТовары.Номенклатура             КАК Номенклатура,
	|	ТаблицаТовары.Характеристика           КАК Характеристика,
	|	ВЫБОР
	|		КОГДА ЕСТЬNULL(ТаблицаТовары.Назначение.ДвиженияПоСкладскимРегистрам, ЛОЖЬ)
	|			ТОГДА ТаблицаТовары.Назначение
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка)
	|	КОНЕЦ                                  КАК Назначение,
	|	&ХозяйственнаяОперация                 КАК ХозяйственнаяОперация,
	|	ТаблицаТовары.Серия                    КАК Серия,
	|	0                                      КАК КОформлениюНакладныхПоРаспоряжению,
	|	0                                      КАК КОформлениюПоступленийПоРаспоряжению,
	|	ТаблицаТовары.Количество               КАК КОформлениюПоступленийПоОрдерам,
	|	0                                      КАК КОформлениюОрдеров,
	|	0                                      КАК КОформлениюПоступленийПоНакладным
	|ИЗ
	|	Документ.ПриобретениеТоваровУслуг.Товары КАК ТаблицаТовары
	|ГДЕ
	|	ТаблицаТовары.Ссылка = &Ссылка
	|	И НЕ &ИспользуетсяДокументПоступлениеТоваров
	|	И ТаблицаТовары.Склад.ИспользоватьОрдернуюСхемуПриПоступлении
	|	И ТаблицаТовары.Ссылка.Дата >= ТаблицаТовары.Склад.ДатаНачалаОрдернойСхемыПриПоступлении
	|	И ТаблицаТовары.Номенклатура.ТипНоменклатуры В (ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.Товар),
	|		ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.МногооборотнаяТара))
	|	И &ХозяйственнаяОперация <> ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаУПоставщикаРеглУчет)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) КАК ВидДвижения,
	|	&Период                                КАК Период,
	|	ВЫБОР
	|		КОГДА (&ДоговорЯвляетсяРаспоряжением
	|				ИЛИ &НакладнаяЯвляетсяРаспоряжением
	|				ИЛИ НЕ &ПоступлениеПоЗаказам
	|				ИЛИ &ПоДоговорамПослеНакладных)
	|			ТОГДА &ДокументПоступления
	|		ИНАЧЕ ТаблицаТовары.ЗаказПоставщику
	|	КОНЕЦ                                  КАК ДокументПоступления,
	|	ТаблицаТовары.Склад                    КАК Склад,
	|	&Отправитель                           КАК Отправитель,
	|	ТаблицаТовары.Номенклатура             КАК Номенклатура,
	|	ТаблицаТовары.Характеристика           КАК Характеристика,
	|	ВЫБОР
	|		КОГДА ЕСТЬNULL(ТаблицаТовары.Назначение.ДвиженияПоСкладскимРегистрам, ЛОЖЬ)
	|			ТОГДА ТаблицаТовары.Назначение
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка)
	|	КОНЕЦ                                  КАК Назначение,
	|	&ХозяйственнаяОперация                 КАК ХозяйственнаяОперация,
	|	ЗНАЧЕНИЕ(Справочник.СерииНоменклатуры.ПустаяСсылка) КАК Серия,
	|	0                                      КАК КОформлениюНакладныхПоРаспоряжению,
	|	0                                      КАК КОформлениюПоступленийПоРаспоряжению,
	|	0                                      КАК КОформлениюПоступленийПоОрдерам,
	|	ТаблицаТовары.Количество               КАК КОформлениюОрдеров,
	|	0                                      КАК КОформлениюПоступленийПоНакладным
	|ИЗ
	|	Документ.ПриобретениеТоваровУслуг.Товары КАК ТаблицаТовары
	|ГДЕ
	|	ТаблицаТовары.Ссылка = &Ссылка
	|	И НЕ &ИспользуетсяДокументПоступлениеТоваров
	|	И (&НакладнаяЯвляетсяРаспоряжением
	|		ИЛИ ТаблицаТовары.КодСтроки = 0
	|		ИЛИ &ПоДоговорамПослеНакладных)
	|	И ТаблицаТовары.Склад.ИспользоватьОрдернуюСхемуПриПоступлении
	|	И ТаблицаТовары.Ссылка.Дата >= ТаблицаТовары.Склад.ДатаНачалаОрдернойСхемыПриПоступлении
	|	И ТаблицаТовары.Номенклатура.ТипНоменклатуры В (ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.Товар),
	|		ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.МногооборотнаяТара))
	|	И &ХозяйственнаяОперация <> ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаУПоставщикаРеглУчет)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) КАК ВидДвижения,
	|	&Период                                КАК Период,
	|	ТаблицаТовары.ЗаказПоставщику          КАК ДокументПоступления,
	|	ТаблицаТовары.Склад                    КАК Склад,
	|	&Отправитель                           КАК Отправитель,
	|	ТаблицаТовары.Номенклатура             КАК Номенклатура,
	|	ТаблицаТовары.Характеристика           КАК Характеристика,
	|	ВЫБОР
	|		КОГДА ЕСТЬNULL(ТаблицаТовары.Назначение.ДвиженияПоСкладскимРегистрам, ЛОЖЬ)
	|			ТОГДА ТаблицаТовары.Назначение
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка)
	|	КОНЕЦ                                  КАК Назначение,
	|	&ХозяйственнаяОперация                 КАК ХозяйственнаяОперация,
	|	ЗНАЧЕНИЕ(Справочник.СерииНоменклатуры.ПустаяСсылка) КАК Серия,
	|	ТаблицаТовары.Количество               КАК КОформлениюНакладныхПоРаспоряжению,
	|	0                                      КАК КОформлениюПоступленийПоРаспоряжению,
	|	0                                      КАК КОформлениюПоступленийПоОрдерам,
	|	0                                      КАК КОформлениюОрдеров,
	|	0                                      КАК КОформлениюПоступленийПоНакладным
	|ИЗ
	|	Документ.ПриобретениеТоваровУслуг.Товары КАК ТаблицаТовары
	|ГДЕ
	|	ТаблицаТовары.Ссылка = &Ссылка
	|	И &ИспользуетсяДокументПоступлениеТоваров
	|	И &ПоступлениеПоЗаказам
	|	И ТаблицаТовары.Номенклатура.ТипНоменклатуры В (ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.Товар),
	|		ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.МногооборотнаяТара))
	|	И ТаблицаТовары.КодСтроки <> 0
	|	И &ХозяйственнаяОперация <> ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаУПоставщикаРеглУчет)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) КАК ВидДвижения,
	|	&Период                                КАК Период,
	|	ВЫБОР
	|		КОГДА (&НакладнаяЯвляетсяРаспоряжением
	|				ИЛИ НЕ &ПоступлениеПоЗаказам
	|				ИЛИ &ПоДоговорамПослеНакладных
	|				ИЛИ &ДоговорЯвляетсяРаспоряжением
	|				)
	|			ТОГДА &ДокументПоступления
	|		ИНАЧЕ ТаблицаТовары.ЗаказПоставщику
	|	КОНЕЦ                                  КАК ДокументПоступления,
	|	ТаблицаТовары.Склад                    КАК Склад,
	|	&Отправитель                           КАК Отправитель,
	|	ТаблицаТовары.Номенклатура             КАК Номенклатура,
	|	ТаблицаТовары.Характеристика           КАК Характеристика,
	|	ВЫБОР
	|		КОГДА ЕСТЬNULL(ТаблицаТовары.Назначение.ДвиженияПоСкладскимРегистрам, ЛОЖЬ)
	|			ТОГДА ТаблицаТовары.Назначение
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка)
	|	КОНЕЦ                                  КАК Назначение,
	|	&ХозяйственнаяОперация                 КАК ХозяйственнаяОперация,
	|	ВЫБОР
	|		КОГДА ТаблицаТовары.СтатусУказанияСерий = 18
	|			ТОГДА ТаблицаТовары.Серия
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.СерииНоменклатуры.ПустаяСсылка)
	|	КОНЕЦ                                  КАК Серия,
	|	0                                      КАК КОформлениюНакладныхПоРаспоряжению,
	|	0                                      КАК КОформлениюПоступленийПоРаспоряжению,
	|	0                                      КАК КОформлениюПоступленийПоОрдерам,
	|	0                                      КАК КОформлениюОрдеров,
	|	ТаблицаТовары.Количество               КАК КОформлениюПоступленийПоНакладным
	|ИЗ
	|	Документ.ПриобретениеТоваровУслуг.Товары КАК ТаблицаТовары
	|ГДЕ
	|	ТаблицаТовары.Ссылка = &Ссылка
	|	И &ИспользуетсяДокументПоступлениеТоваров
	|	И ТаблицаТовары.Номенклатура.ТипНоменклатуры В (ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.Товар),
	|		ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.МногооборотнаяТара))
	|	И &ХозяйственнаяОперация <> ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаУПоставщикаРеглУчет)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) КАК ВидДвижения,
	|	&Период                                КАК Период,
	|	ВЫБОР
	|		КОГДА (&НакладнаяЯвляетсяРаспоряжением
	|				ИЛИ НЕ &ПоступлениеПоЗаказам
	|				ИЛИ &ПоДоговорамПослеНакладных)
	|			ТОГДА &ДокументПоступления
	|		ИНАЧЕ ТаблицаТовары.ЗаказПоставщику
	|	КОНЕЦ                                  КАК ДокументПоступления,
	|	ТаблицаТовары.Склад                    КАК Склад,
	|	&Отправитель                           КАК Отправитель,
	|	ТаблицаТовары.Номенклатура             КАК Номенклатура,
	|	ТаблицаТовары.Характеристика           КАК Характеристика,
	|	ВЫБОР
	|		КОГДА ЕСТЬNULL(ТаблицаТовары.Назначение.ДвиженияПоСкладскимРегистрам, ЛОЖЬ)
	|			ТОГДА ТаблицаТовары.Назначение
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка)
	|	КОНЕЦ                                  КАК Назначение,
	|	&ХозяйственнаяОперация                 КАК ХозяйственнаяОперация,
	|	ЗНАЧЕНИЕ(Справочник.СерииНоменклатуры.ПустаяСсылка) КАК Серия,
	|	0                                      КАК КОформлениюНакладныхПоРаспоряжению,
	|	ТаблицаТовары.Количество               КАК КОформлениюПоступленийПоРаспоряжению,
	|	0                                      КАК КОформлениюПоступленийПоОрдерам,
	|	0                                      КАК КОформлениюОрдеров,
	|	0                                      КАК КОформлениюПоступленийПоНакладным
	|ИЗ
	|	Документ.ПриобретениеТоваровУслуг.Товары КАК ТаблицаТовары
	|ГДЕ
	|	ТаблицаТовары.Ссылка = &Ссылка
	|	И &ИспользуетсяДокументПоступлениеТоваров
	|	И (&НакладнаяЯвляетсяРаспоряжением
	|		ИЛИ ТаблицаТовары.КодСтроки = 0
	|		ИЛИ &ПоДоговорамПослеНакладных)
	|	И ТаблицаТовары.Номенклатура.ТипНоменклатуры В (ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.Товар),
	|		ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.МногооборотнаяТара))
	|	И &ХозяйственнаяОперация <> ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаУПоставщикаРеглУчет)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) КАК ВидДвижения,
	|	&Период                                КАК Период,
	|	ВЫБОР
	|		КОГДА (&ДоговорЯвляетсяРаспоряжением
	|				ИЛИ НЕ &ПоступлениеПоЗаказам)
	|				И НЕ &ПоДоговорамПослеНакладных
	|			ТОГДА &ДокументПоступления
	|		ИНАЧЕ ТаблицаТовары.ЗаказПоставщику
	|	КОНЕЦ                                  КАК ДокументПоступления,
	|	ТаблицаТовары.Склад                    КАК Склад,
	|	&Отправитель                           КАК Отправитель,
	|	ТаблицаТовары.Номенклатура             КАК Номенклатура,
	|	ТаблицаТовары.Характеристика           КАК Характеристика,
	|	ВЫБОР
	|		КОГДА ЕСТЬNULL(ТаблицаТовары.Назначение.ДвиженияПоСкладскимРегистрам, ЛОЖЬ)
	|			ТОГДА ТаблицаТовары.Назначение
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка)
	|	КОНЕЦ                                  КАК Назначение,
	|	&ХозяйственнаяОперация                 КАК ХозяйственнаяОперация,
	|	ЗНАЧЕНИЕ(Справочник.СерииНоменклатуры.ПустаяСсылка) КАК Серия,
	|	0                                      КАК КОформлениюНакладныхПоРаспоряжению,
	|	ТаблицаТовары.Количество               КАК КОформлениюПоступленийПоРаспоряжению,
	|	0                                      КАК КОформлениюПоступленийПоОрдерам,
	|	0                                      КАК КОформлениюОрдеров,
	|	0                                      КАК КОформлениюПоступленийПоНакладным
	|ИЗ
	|	Документ.ПриобретениеТоваровУслуг.Товары КАК ТаблицаТовары
	|ГДЕ
	|	ТаблицаТовары.Ссылка = &Ссылка
	|	И НЕ &ИспользуетсяДокументПоступлениеТоваров
	|	И ТаблицаТовары.КодСтроки <> 0
	|	И ТаблицаТовары.Номенклатура.ТипНоменклатуры В (ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.Товар),
	|		ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.МногооборотнаяТара))
	|	И &ХозяйственнаяОперация <> ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаУПоставщикаРеглУчет)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) КАК ВидДвижения,
	|	&Период                                КАК Период,
	|	ВЫБОР
	|		КОГДА (&ДоговорЯвляетсяРаспоряжением
	|				ИЛИ &НакладнаяЯвляетсяРаспоряжением
	|				ИЛИ НЕ &ПоступлениеПоЗаказам
	|				ИЛИ &ПоДоговорамПослеНакладных)
	|			ТОГДА &ДокументПоступления
	|		ИНАЧЕ ТаблицаТовары.ЗаказПоставщику
	|	КОНЕЦ                                  КАК ДокументПоступления,
	|	ТаблицаТовары.Склад                    КАК Склад,
	|	&Отправитель                           КАК Отправитель,
	|	ТаблицаТовары.Номенклатура             КАК Номенклатура,
	|	ТаблицаТовары.Характеристика           КАК Характеристика,
	|	ВЫБОР
	|		КОГДА ЕСТЬNULL(ТаблицаТовары.Назначение.ДвиженияПоСкладскимРегистрам, ЛОЖЬ)
	|			ТОГДА ТаблицаТовары.Назначение
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка)
	|	КОНЕЦ                                  КАК Назначение,
	|	&ХозяйственнаяОперация                 КАК ХозяйственнаяОперация,
	|	ЗНАЧЕНИЕ(Справочник.СерииНоменклатуры.ПустаяСсылка) КАК Серия,
	|	0                                      КАК КОформлениюНакладныхПоРаспоряжению,
	|	0                                      КАК КОформлениюПоступленийПоРаспоряжению,
	|	0                                      КАК КОформлениюПоступленийПоОрдерам,
	|	ТаблицаТовары.Количество               КАК КОформлениюОрдеров,
	|	0                                      КАК КОформлениюПоступленийПоНакладным
	|ИЗ
	|	Документ.ПриобретениеТоваровУслуг.Товары КАК ТаблицаТовары
	|ГДЕ
	|	ТаблицаТовары.Ссылка = &Ссылка
	|	И &ИспользуетсяДокументПоступлениеТоваров
	|	И (&НакладнаяЯвляетсяРаспоряжением
	|		ИЛИ ТаблицаТовары.КодСтроки = 0
	|		ИЛИ &ПоДоговорамПослеНакладных)
	|	И ТаблицаТовары.Склад.ИспользоватьОрдернуюСхемуПриПоступлении
	|	И ТаблицаТовары.Ссылка.Дата >= ТаблицаТовары.Склад.ДатаНачалаОрдернойСхемыПриПоступлении
	|	И ТаблицаТовары.Номенклатура.ТипНоменклатуры В (ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.Товар),
	|		ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.МногооборотнаяТара))
	|	И &ХозяйственнаяОперация <> ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ЗакупкаУПоставщикаРеглУчет)";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	Возврат ТекстЗапроса;
	
КонецФункции
