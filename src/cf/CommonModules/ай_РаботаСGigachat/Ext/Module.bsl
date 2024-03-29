﻿ 
 Функция СпроситьGigachat(ТекстЗапроса) Экспорт
	 
	 // Получаем токен авторизации 
	 ClientSecret = Константы.ай_ClientSecretGC.Получить();
	 
	 Заголовки = Новый Соответствие();
	 Заголовки.Вставить("Authorization", "Bearer " + ClientSecret);
	 Заголовки.Вставить("RqUID", Строка(Новый УникальныйИдентификатор));
	 Заголовки.Вставить("Content-Type", "application/x-www-form-urlencoded");
	 
	 ПараметрыСоединение = Новый Структура();
	 ПараметрыСоединение.Вставить("Адрес", "ngw.devices.sberbank.ru:9443");
	 ПараметрыСоединение.Вставить("Заголовки", Заголовки);
	 
	 BODY_PARAMETERS = "scope=GIGACHAT_API_PERS";
	 АдресРесурса = "/api/v2/oauth";
	 
	 Результат = ай_РаботаСHTTP.ОтправитьЗапросНаСервер(АдресРесурса, "POST", ПараметрыСоединение, BODY_PARAMETERS); 
	 Если Результат.КодСостояния <> 200 Тогда
		 
		 ИнформацияОбОшибке = СтрШаблон("Не удалось получить токен доступа по причине: %1", ай_РаботаСHTTP.СтрокаJSON(Результат));
		 ай_РаботаСHTTP.ВывестиСообщениеОбОшибке(ИнформацияОбОшибке, "Работа с Gigachat");

		 Возврат "";
	 КонецЕсли;
	 
	 Токен = Результат.access_token;
	 СтруктураСообщения = СтруктураСообщения(ТекстЗапроса);
	 // спрашиваем гигачат
	 Заголовки = Новый Соответствие();
	 Заголовки.Вставить("Authorization", "Bearer " + Токен);
	 Заголовки.Вставить("Content-Type", "application/json");
	 
	 ПараметрыСоединение = Новый Структура();
	 ПараметрыСоединение.Вставить("Адрес", "gigachat.devices.sberbank.ru");
	 ПараметрыСоединение.Вставить("Заголовки", Заголовки);
	 
	 BODY_PARAMETERS = Новый Структура;
	 BODY_PARAMETERS.Вставить("model", "GigaChat:latest"); // идентификатор модели, можно указать конкретную или :latest  для выбора наиболее актуальной
	 BODY_PARAMETERS.Вставить("temperature", 0.87); // от 0 до 2, чем выше, тем вывод более случайный, не рекомендуетсы использовать совместно c top_p
	 // BODY_PARAMETERS.Вставить("top_p", 0.47); // от 0 до 1, альтернатива параметру temperature, не рекомендуетсы использовать совместно c temperature
	 BODY_PARAMETERS.Вставить("n", 1); // от 1 до 4, число вариантов ответов модели
	 BODY_PARAMETERS.Вставить("max_tokens", 512); // максимальное число токенов для генерации ответов
	 BODY_PARAMETERS.Вставить("repetition_penalty", 1.07); // количество повторений слов, 1.0 - ни чего не менять, от 0 до 1 повторять уже сказанные слова, от 1 и далее не использовать сказанные слова
	 BODY_PARAMETERS.Вставить("stream", Ложь); // если true, будут отправляться частичные ответы сообщений
	 BODY_PARAMETERS.Вставить("update_interval", 0); // интервал в секундах, не чаще которого будут присылаться токены в stream режиме  
	 
	 ЗначениеВМассиве = Новый Массив();
	 ЗначениеВМассиве.Добавить(СтруктураСообщения);
	 BODY_PARAMETERS.Вставить("messages", ЗначениеВМассиве);
	 //BODY_PARAMETERS.Вставить("messages", ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(СтруктураСообщения)); 
	 
	 АдресРесурса = "/api/v1/chat/completions";
	 Результат = ай_РаботаСHTTP.ОтправитьЗапросНаСервер(АдресРесурса, "POST", ПараметрыСоединение, BODY_PARAMETERS); 
	 
	 Если Результат.КодСостояния <> 200 Тогда
		 ИнформацияОбОшибке = СтрШаблон("Не удалось получить ответ на сообщения по причине: %1", ай_РаботаСHTTP.СтрокаJSON(Результат));
		 ай_РаботаСHTTP.ВывестиСообщениеОбОшибке(ИнформацияОбОшибке, "Работа с Gigachat");
		 Возврат "";
	 КонецЕсли;
	 
	 Возврат Результат.choices[0].message.content; 
	 
 КонецФункции

 Функция СтруктураСообщения(ТекстСообщения)
	 
	 Сообщение = Новый Структура();
	 Сообщение.Вставить("role", "user");
	 Сообщение.Вставить("content", ТекстСообщения); 
	 Возврат Сообщение;
	 
 КонецФункции	
 