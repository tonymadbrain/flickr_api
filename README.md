#Work with flickr API

Trying work with Flickr API for downloading and uploading photos, for my blog - http://doam.ru

###NOTES:

* https://github.com/hanklords/flickraw
* tags = info.tags.map {|t| t.raw}
* https://github.com/jondot/sneakers/wiki/How-To%3A-Do-Log-Processing

###TODO:

* ~~Menu in generated file~~
* ~~Generate only data and show through slim template~~
* ~~Delete one file~~
* ~~Updating in background~~
* Pretty wiews and some js
* Upload many files in one time
* ~~Selecting from DB~~
* ~~Updating DB~~
* ~~Deleting with DB~~
* Rescue errors

###For start:

* bundle install
* add flickr credentials into `config/flickr.yml`
* configure sinatra in `config/sinatra.rb`

sample flickr.yml:
~~~yaml
:api_key: g9lCzIAdjvvvPaxU6L8CVf1um
:shared_secret: g9lCzIAdjvvvPax
:access_token: g9lCzIAdjvvv-PaxU6L8CVf1um
:access_secret: g9lCzIAdjvvvPa
:user: 12313131@P01
~~~

sample sinatra.rb:
~~~ruby
#configuration
configure do
  set :bind, '0.0.0.0'
  set :port, '8080'
  set :environment, :development
end
~~~



