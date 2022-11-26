
#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
		
	Перем ИмяПоля;
	Перем ДокументОснование;
	Перем ДатаПоступления;
	ТекстСообщенияОНекорректномСоздании = НСтр("ru = 'Приходный ордер на товары нужно вводить из формы ""Приемка"".'");
	
	Если ДанныеЗаполнения = "АвтоТест" Тогда
		Возврат;
	КонецЕсли;	
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		
		ДанныеЗаполнения.Свойство("Склад",                      Склад);
		ДанныеЗаполнения.Свойство("Помещение",                  Помещение);
		ДанныеЗаполнения.Свойство("Распоряжение",               Распоряжение);
		ДанныеЗаполнения.Свойство("ДатаПоступления",            ДатаПоступления);
		ДанныеЗаполнения.Свойство("ЗонаПриемки",                ЗонаПриемки);
		ДанныеЗаполнения.Свойство("СкладскаяОперация",          СкладскаяОперация);
		ДанныеЗаполнения.Свойство("Отправитель",                Отправитель);
		ДанныеЗаполнения.Свойство("ЗакрыватьГрафикПоступления", ЗакрыватьГрафикПоступления);
		ДанныеЗаполнения.Свойство("ДатаВходящегоДокумента",     ДатаВходящегоДокумента);
		ДанныеЗаполнения.Свойство("НомерВходящегоДокумента",    НомерВходящегоДокумента);
		ДанныеЗаполнения.Свойство("ХозяйственнаяОперация",      ХозяйственнаяОперация);
		
		Если СкладскаяОперация <> Перечисления.СкладскиеОперации.ВозвратНепринятыхТоваров
			И ЗначениеЗаполнено(Распоряжение) Тогда
			СкладскаяОперация = СкладыКлиентСервер.СкладскаяОперацияПриемкиПоХозяйственнойОперации(ХозяйственнаяОперация);
			УстановитьПривилегированныйРежим(Истина);
			Если СкладскаяОперация = Перечисления.СкладскиеОперации.ПриемкаПоПеремещению
				Или СкладскаяОперация = Перечисления.СкладскиеОперации.ПриемкаПродукцииИзПроизводства Тогда
				ЗаполнитьТоварыПоТоварамКПоступлению("НоменклатураКоличество", ДатаПоступления);
			Иначе
				ЗаполнитьТоварыПоТоварамКПоступлению("Номенклатура", ДатаПоступления);
			КонецЕсли;
			
			Документы.ПриходныйОрдерНаТовары.ЗаполнитьСерииПоРаспоряжению(ЭтотОбъект, Ложь);
			УстановитьПривилегированныйРежим(Ложь);
		ИначеЕсли СкладскаяОперация <> Перечисления.СкладскиеОперации.ВозвратНепринятыхТоваров Тогда
			ВызватьИсключение ТекстСообщенияОНекорректномСоздании;
		КонецЕсли;
		
	КонецЕсли;
	
	// +++ экз          
	Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.экз_ПриятьПоФакту") Тогда			
		экз_ЗаполнитьПоПринятьПоФакту(ДанныеЗаполнения);			
	КонецЕсли;
	
	// --- экз
	ИнициализироватьДокумент(ДанныеЗаполнения);
	
КонецПроцедуры


#КонецОбласти
