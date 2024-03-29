
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("Номенклатура") Тогда 
		НаименованиеТовара = Параметры.Номенклатура.Наименование;  
		Промт = Константы.ай_ШаблонЗапросаGC.Получить();//"напиши описание для  &НаименованиеТовара выделив особенности и подчеркнув жирным свойства"; 
		Промт = СтрЗаменить(Промт, "&НаименованиеТовара", НаименованиеТовара);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	ФорматированныйДокумент = ТекущийОбъект.Описание.Получить(); 
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	ТекущийОбъект.Описание = Новый ХранилищеЗначения(ФорматированныйДокумент); 
КонецПроцедуры

&НаКлиенте
Процедура ЭкспортВHTML(Команда)
	
	ВыборФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	ВыборФайла.МножественныйВыбор = Ложь;
	ВыборФайла.Заголовок =НСтр("ru = 'Укажите каталог для сохранения файла'");
	
	Если ВыборФайла.Выбрать() Тогда
		//ИмяТемпФайла = ПолучитьИмяВременногоФайла("html");
		ИмяТемпФайла = ВыборФайла.Каталог + "/" + Объект.Наименование + ".html";
		ФорматированныйДокумент.Записать(ИмяТемпФайла, ТипФайлаФорматированногоДокумента.HTML);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура GigaChat(Команда)
	 СпроситьGigachat();  
КонецПроцедуры

&НаСервере
Процедура СпроситьGigachat()
	
	ТекстHTML =  ай_РаботаСGigachat.СпроситьGigachat(Промт);	
	ФорматированныйДокумент.УстановитьHTML(ТекстHTML, Новый Структура());

КонецПроцедуры
