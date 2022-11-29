
// Модуль Объекта 
Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	// Если План НЕ Утвержден  НЕ Пишем в РС
	
	Если  НЕ Утвержден Тогда
		Возврат;		
	КонецЕсли;
	
	//  Формирование Движений
	Движения.экз_ДанныеПланЗакупок.Записывать = Истина;
	
	Движение = Движения.экз_ДанныеПланЗакупок.Добавить();
	Движение.ГоловнаяОрганизация = ГоловнаяОрганизация;
	Движение.ДочерняяОрганизация = ДочерняяОрганизация;
	Движение.ПериодДействия = ПериодДействия;
	Движение.Период = Дата;
	Движение.Сумма = Сумма;
	
	
КонецПроцедуры


