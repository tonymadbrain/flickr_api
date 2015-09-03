require 'sinatra'
require 'slim'
require 'flickraw'
require 'uri'
require 'sinatra/reloader' if development?
require 'yaml'
require 'data_mapper'
require File.expand_path(File.dirname(__FILE__) + '/config/sinatra')


flickr_cred = YAML.load_file('./config/flickr.yml')
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/mydatabase.sqlite3")

#models
class Files
  include DataMapper::Resource

  property :id,         String, key: true
  property :filename,   String
  property :url,        String
  property :preview,    String
end

class BackgroundJob
  include DataMapper::Resource

  property :id,     Serial
  property :status, Boolean
end

DataMapper.auto_migrate! unless DataMapper.repository(:default).adapter.storage_exists?('files')
DataMapper.finalize

def timenow
  date_and_time = "%Y-%b-%d %H:%M:%S"
  time          = Time.now.strftime(date_and_time)
  return time
end

#auth
FlickRaw.api_key = flickr_cred[:api_key]
FlickRaw.shared_secret = flickr_cred[:shared_secret]
flickr.access_token = flickr_cred[:access_token]
flickr.access_secret = flickr_cred[:access_secret]
user = flickr_cred[:user]
login = flickr.test.login

#actions
get '/' do
  @files = Files.all
  if @files.nil?
    DataMapper.auto_migrate!
  end
  @files = Files.all
  slim :list_files, layout: :index
end

get '/update' do
  @files = Files.all
  BackgroundJob.create(status: false) unless BackgroundJob.get(1)
  @job = BackgroundJob.get(1)
  if @job.status
    slim :updating_in_progress, layout: :index
  else
    Thread.new do
      DataMapper.auto_migrate!
      photos = flickr.photos.search(user_id: user)

      photos.each do |photo|
        info = flickr.photos.getInfo(photo_id: photo.id)
        url = FlickRaw.url_o(info)
        url_small = FlickRaw.url_t(info)
        @file = Files.first_or_create(id: photo.id, filename: info["title"], url: url, preview: url_small)
        @file.save!
      end

      @job.update(status: false)
    end

    @job.update(status: true)
    slim :updating_started, layout: :index
  end
end

post '/delete' do
  @files = Files.all
  # debug params
  # content_type :json
  # {"params" => params}.to_json
  params['checkbox'].each do |i|
    flickr.photos.delete(:photo_id => i)
    Files.first(id: i).destroy
  end

  slim :file_deleted_ajax
end

post '/upload' do
  @files = Files.all
  filename = params['myfile'][:filename]
  file = params['myfile'][:tempfile].path
  time = timenow
  flickr.upload_photo "#{file}", title: "#{filename}", description: "#{filename} uploaded through API at #{time}!", tags: "#{filename}"
  slim :file_uploaded, layout: :index
end

not_found do
  slim :'404', layout: false
end
