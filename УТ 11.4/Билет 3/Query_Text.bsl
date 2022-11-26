


Функция экз_ТекстЗапросаТаблицаТоварыКПоступлению(Запрос, ТекстыЗапроса, Регистры)
		
	ИмяРегистра = "ТоварыКПоступлению";
	
	Если НЕ ПроведениеСерверУТ.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли; 
	
	УстановитьПараметрыЗапросаСведенийПоПоступлениям(Запрос);
	
	Запрос.УстановитьПараметр("ПринятьПоФакту",Запрос.Параметры.Ссылка.экз_ПринятьПоФакту); 
	
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) КАК ВидДвижения,
	|	&Период КАК Период,
	|	&ПринятьПоФакту КАК ДокументПоступления,
	|	ТаблицаТовары.Склад КАК Склад,
	|	&Отправитель КАК Отправитель,
	|	ТаблицаТовары.Номенклатура КАК Номенклатура,
	|	ТаблицаТовары.Характеристика КАК Характеристика,
	|	ВЫБОР
	|		КОГДА ЕСТЬNULL(ТаблицаТовары.Назначение.ДвиженияПоСкладскимРегистрам, ЛОЖЬ)
	|			ТОГДА ТаблицаТовары.Назначение
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка)
	|	КОНЕЦ КАК Назначение,
	|	&ХозяйственнаяОперация КАК ХозяйственнаяОперация,
	|	ЗНАЧЕНИЕ(Справочник.СерииНоменклатуры.ПустаяСсылка) КАК Серия,
	|	ТаблицаТовары.Количество КАК КОформлениюНакладныхПоРаспоряжению,
	|	0 КАК КОформлениюПоступленийПоРаспоряжению,
	|	0 КАК КОформлениюПоступленийПоОрдерам,
	|	0 КАК КОформлениюОрдеров,
	|	0 КАК КОформлениюПоступленийПоНакладным
	|ИЗ
	|	Документ.ПриобретениеТоваровУслуг.Товары КАК ТаблицаТовары
	|ГДЕ
	|	ТаблицаТовары.Ссылка = &Ссылка
	|	И &ПоступлениеПоЗаказам
	|	И ТаблицаТовары.Номенклатура.ТипНоменклатуры В (ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.Товар), ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.МногооборотнаяТара))
	|	И ТаблицаТовары.КодСтроки <> 0
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход),
	|	&Период,
	|	&ПринятьПоФакту,
	|	ТаблицаТовары.Склад,
	|	&Отправитель,
	|	ТаблицаТовары.Номенклатура,
	|	ТаблицаТовары.Характеристика,
	|	ВЫБОР
	|		КОГДА ЕСТЬNULL(ТаблицаТовары.Назначение.ДвиженияПоСкладскимРегистрам, ЛОЖЬ)
	|			ТОГДА ТаблицаТовары.Назначение
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.Назначения.ПустаяСсылка)
	|	КОНЕЦ,
	|	&ХозяйственнаяОперация,
	|	ТаблицаТовары.Серия,
	|	0,
	|	0,
	|	ТаблицаТовары.Количество,
	|	0,
	|	0
	|ИЗ
	|	Документ.ПриобретениеТоваровУслуг.Товары КАК ТаблицаТовары
	|ГДЕ
	|	ТаблицаТовары.Ссылка = &Ссылка
	|	И ТаблицаТовары.Склад.ИспользоватьОрдернуюСхемуПриПоступлении
	|	И ТаблицаТовары.Ссылка.Дата >= ТаблицаТовары.Склад.ДатаНачалаОрдернойСхемыПриПоступлении
	|	И ТаблицаТовары.Номенклатура.ТипНоменклатуры В (ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.Товар), ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.МногооборотнаяТара))";
	
	
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	Возврат ТекстЗапроса;   
	
КонецФункции
