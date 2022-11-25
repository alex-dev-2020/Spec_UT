

Функция СведенияОВнешнейОбработке() Экспорт 
	
	ПараметрыРегистрации = Новый Структура;
	
	МассивНазначений = Новый Массив;
	
	МассивНазначений.Добавить("Документ.РеализацияТоваровУслуг");
	
	ПараметрыРегистрации.Вставить("Вид", "ПечатнаяФорма");
	ПараметрыРегистрации.Вставить("Назначение", МассивНазначений);
	ПараметрыРегистрации.Вставить("Наименование", "ABC Классификация по Весу");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь); 
	ПараметрыРегистрации.Вставить("Версия", "1.3");
	ПараметрыРегистрации.Вставить("Информация", "Используется для отобаржения отчета ABC Классификации");
	
	
	ТаблицаКоманд = ПолучитьТаблицуКоманд();
	
	ДобавитьКоманду(ТаблицаКоманд,"ABC Классификация по Весу", "ABCКлассификацияПоВесу",
	"ВызовСерверногоМетода", Истина, "ПечатьXML");
	
	ПараметрыРегистрации.Вставить("Команды", ТаблицаКоманд);
	
	Возврат ПараметрыРегистрации;
	
КонецФункции 

Функция ПолучитьТаблицуКоманд() 
	
	Команды = Новый ТаблицаЗначений;
	
	Команды.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));    	
	Команды.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Строка"));	
	Команды.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("ПоказыватьОповещение", Новый ОписаниеТипов("Булево")); 	
	Команды.Колонки.Добавить("Модификатор", Новый ОписаниеТипов("Строка"));	 	
	
	Возврат Команды;
	
КонецФункции

Процедура ДобавитьКоманду(ТаблицаКоманд, Представление,	Идентификатор,Использование,
	ПоказыватьОповещение = Ложь, Модификатор = " ")
	
	НоваяКоманда = ТаблицаКоманд.Добавить();
	
	НоваяКоманда.Представление = Представление;
	НоваяКоманда.Идентификатор =  Идентификатор;
	НоваяКоманда.Использование = Использование;
	НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение;
	НоваяКоманда.Модификатор = Модификатор;
	
КонецПроцедуры 

Процедура Печать(МассивОбъектов, КоллекцияПечатныхФорм,	ОбъектПечати,ПараметрыВывода) Экспорт 
	
	УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(КоллекцияПечатныхФорм,
	"ABCКлассификацияПоВесу", "ABC Классификация по Весу",
	СформироватьПечатнуюФормуЧерезСКД(МассивОбъектов,ОбъектПечати)); 
	
КонецПроцедуры  