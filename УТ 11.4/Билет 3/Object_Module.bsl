

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	Перем СкладПоступления;
	Перем РеквизитыШапки;
	
	ТипДанныхЗаполнения = ТипЗнч(ДанныеЗаполнения);

	Если ТипДанныхЗаполнения = Тип("Структура") Тогда
		
		Если ДанныеЗаполнения.Свойство("ДокументОснование")
			И (ТипЗнч(ДанныеЗаполнения.ДокументОснование) = Тип("ДокументСсылка.ЗаказПоставщику")
			Или ТипЗнч(ДанныеЗаполнения.ДокументОснование) = Тип("Массив")) Тогда
			
			ДанныеЗаполнения.Свойство("СкладПоступления", СкладПоступления);
			ДанныеЗаполнения.Свойство("РеквизитыШапки", РеквизитыШапки);
			ЗаполнитьДокументНаОснованииЗаказаПоставщику(ДанныеЗаполнения.ДокументОснование, СкладПоступления, РеквизитыШапки);
			
		ИначеЕсли ДанныеЗаполнения.Свойство("АктОРасхождениях") 
			И ДанныеЗаполнения.Свойство("ОснованиеАкта") Тогда
			
			Если ТипЗнч(ДанныеЗаполнения.ОснованиеАкта) = Тип("ДокументСсылка.ВозвратТоваровПоставщику") Тогда
				ЗаполнитьДокументНаОснованииАктаПриемкиПослеОтгрузки(ДанныеЗаполнения);
			ИначеЕсли ТипЗнч(ДанныеЗаполнения.ОснованиеАкта) = Тип("ДокументСсылка.ПриобретениеТоваровУслуг") Тогда
				ЗаполнитьДокументНаОснованииАктаПриемкиПослеПоступления(ДанныеЗаполнения);
			КонецЕсли;
		ИначеЕсли ДанныеЗаполнения.Свойство("ДокументОснование")
			И ТипЗнч(ДанныеЗаполнения.ДокументОснование) = Тип("СправочникСсылка.СоглашенияСПоставщиками") Тогда
			
			ДанныеЗаполнения.Свойство("СкладПоступления", СкладПоступления);
			ЗаполнитьДокументНаОснованииСоглашенияСПоставщиком(ДанныеЗаполнения.ДокументОснование, СкладПоступления);
		ИначеЕсли ДанныеЗаполнения.Свойство("ДокументОснование")
			И ТипЗнч(ДанныеЗаполнения.ДокументОснование) = Тип("СправочникСсылка.ДоговорыКонтрагентов") Тогда
			
			ДанныеЗаполнения.Свойство("СкладПоступления", СкладПоступления);
			ЗаполнитьДокументНаОснованииДоговораСКонтрагентом(ДанныеЗаполнения.ДокументОснование, СкладПоступления);
		Иначе
			ЗаполнитьДокументПоОтбору(ДанныеЗаполнения);
		КонецЕсли;
		
	ИначеЕсли ТипДанныхЗаполнения = Тип("ДокументСсылка.ЗаказПоставщику") Тогда
		ЗаполнитьДокументНаОснованииЗаказаПоставщику(ДанныеЗаполнения, СкладПоступления);
	ИначеЕсли ТипДанныхЗаполнения = Тип("ДокументСсылка.ВозвратТоваровПоставщику") Тогда
		ЗаполнитьДокументНаОснованииВозвратаТоваровПоставщику(ДанныеЗаполнения);
	ИначеЕсли ТипДанныхЗаполнения = Тип("СправочникСсылка.СоглашенияСПоставщиками") Тогда
		ЗаполнитьДокументНаОснованииСоглашенияСПоставщиком(ДанныеЗаполнения);
	ИначеЕсли ТипДанныхЗаполнения = Тип("ДокументСсылка.ТТНВходящаяЕГАИС") Тогда
		ИнтеграцияЕГАИСУТ.ЗаполнитьПоступлениеТоваровУслугНаОснованииТТНВходящаяЕГАИС(ЭтотОбъект, ДанныеЗаполнения, Неопределено, СтандартнаяОбработка);
	ИначеЕсли ТипДанныхЗаполнения = Тип("ДокументСсылка.ВходящаяТранспортнаяОперацияВЕТИС") Тогда

		ИнтеграцияВЕТИСУТ.ЗаполнитьПриобретениеТоваровУслугНаОснованииВходящейТранспортнойОперацииВЕТИС(ЭтотОбъект, ДанныеЗаполнения);

	КонецЕсли;
	
	ДополнительныеСвойства.Вставить("НеобходимостьЗаполненияСчетаПриФОИспользоватьНесколькоСчетовЛожь", Ложь);
	ЗаполнениеСвойствПоСтатистикеСервер.ЗаполнитьСвойстваОбъекта(ЭтотОбъект, ДанныеЗаполнения);

		// +++ экз
		Если ТипДанныхЗаполнения = Тип("ДокументСсылка.ПриходныйОрдерНаТовары") Тогда 
		
			ЗаполнитьДокументНаОснованииДоговораСКонтрагентом(
				ДанныеЗаполнения.Распоряжение.Договор, 
				ДанныеЗаполнения.Склад);
			экз_ПринятьПоФакту = ДанныеЗаполнения.Распоряжение;
			экз_ПриходныйОрдер = ДанныеЗаполнения;
				
			КонецЕсли; 
		// --- экз

	ИнициализироватьДокумент(ДанныеЗаполнения);
	
	ЗаполнитьЭтапыГрафикаОплаты();
	
	Если Не ЗначениеЗаполнено(ПорядокОплаты) Тогда
		ВалютаОплаты  = ДенежныеСредстваСервер.ПолучитьВалютуОплаты(ФормаОплаты, БанковскийСчетОрганизации);
		ПорядокОплаты = Перечисления.ПорядокОплатыПоСоглашениям.ПолучитьПорядокОплатыПоУмолчанию(ВалютаВзаиморасчетов,НалогообложениеНДС,ВалютаОплаты);
	КонецЕсли;
	
	СкладГруппа = Справочники.Склады.ЭтоГруппаИСкладыИспользуютсяВТЧДокументовЗакупки(Склад);
	СкладыСервер.ЗаполнитьСкладыВТабличнойЧасти(Склад, СкладГруппа, Товары, Ложь);
	
	ПриобретениеТоваровУслугЛокализация.ОбработкаЗаполнения(ЭтотОбъект, ДанныеЗаполнения, СтандартнаяОбработка);

КонецПроцедуры



#КонецОбласти
