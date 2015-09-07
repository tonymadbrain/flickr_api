#Flickr wrapper

##RU

Данное приложение написано чтобы использовать flickr в качестве хранилища
изображений для моего блога - http://doam.ru. Это простое приложение-обертка,
написанное на sinatra, работающее через flickr API.

![Main page](https://github.com/tonymadbrain/flickr_api/blob/master/screenshot.png "Main page")

###Возможности
* Выгрузка в sqlite базу списка фотографий загруженных в облако flickr
(выгружаются: ссылка на оригинал, заголовок, ссылка для показа превью)
* Удаление одной или нескольких фотографий из облакка
* Загрузка фотографий в облако (пока только по одной за раз)

###Используется
* `sinatra` - не рельсами едиными
* `slim` - пишем html шаблоны без %
* `flickraw` - собственно гем для работы с flickr API
* `yaml` - держим конфиги в yaml
* `data_mapper` - легкий ORM
* `puma` - мой выбор веб-сервера для ruby проектов

###Заметки:

* https://github.com/hanklords/flickraw - гем для flickr API

###TODO:

* ~~Menu in generated file~~
* ~~Generate only data and show through slim template~~
* ~~Delete one file~~
* ~~Updating in background~~
* ~~Some js for ajax~~
* ~~Selecting from DB~~
* ~~Updating DB~~
* ~~Deleting with DB~~
* Pretty wiews?
* Upload many files in one time
* Rescue errors

###Для запуска:

Склонировать репозиторий
~~~bash
$ git clone https://github.com/tonymadbrain/flickr_api.git
~~~
Перейти в папку с приложением
~~~bash
$ cd flickr_api
~~~
Создать каталог для конфигов
~~~bash
$ mkdir config
~~~
Создать файлы конфигов и отредактировать их
~~~bash
$ touch sinatra.rb flickr.yml puma.rb
~~~
Установить зависимости
~~~bash
$ bundle install
~~~
Запустить сервер
~~~Bash
$ puma -C config/puma.rb
~~~

###Примеры конфигов

flickr.yml:
~~~yaml
:api_key: g9lCzIAdjvvvPaxU6L8CVf1um
:shared_secret: g9lCzIAdjvvvPax
:access_token: g9lCzIAdjvvv-PaxU6L8CVf1um
:access_secret: g9lCzIAdjvvvPa
:user: 12313131@P01
~~~

sinatra.rb:
~~~ruby
#configuration
configure do
  set :server, :puma
end
~~~

puma.rb:
~~~ruby
root = "#{Dir.getwd}"

daemonize false
environment 'development'
bind "unix:///tmp/flickr_api.socket"
pidfile "/tmp/flickr_api.pid"
rackup "#{root}/config.ru"
stdout_redirect "/tmp/flickr_api.stdout.log", "/tmp/flickr_api.stderr.log"
threads 1, 1

#activate_control_app
#state_path "/tmp/flickr_state"
~~~

###Контакты

По любым вопросам можете писать на <a href="mailto:mail@doam.ru?Subject=Flickr_API_Wrapper" target="_top">почту</a>.

##EN

In progress!