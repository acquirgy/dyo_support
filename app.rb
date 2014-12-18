require 'sinatra'
require 'sinatra/reloader' if development?
require 'json'

# not sure if I need all of these
require 'cloudinary'
require 'cloudinary/uploader'
require 'cloudinary/utils'

configure do
  Cloudinary.config do |config|
    config.cloud_name = "di6knt3yo"
    config.api_key = "325765674544992"
    config.api_secret = "lf0nSTOWgFqj_FsprXIhXtszae4"
  end
end

get '/' do
  'steamy'
end

get '/pub/:id' do
  @image_url = 'https://res.cloudinary.com/di6knt3yo/image/upload/' + params[:id] + '.png'
  @image_url.gsub!(/-/, '/')

  erb :cloudinary
end

post '/upload-image' do
  content_type :json

  image_data = request['image_data']

  upload = Cloudinary::Uploader.upload(image_data)

  image_url = upload['url']
  split_url = image_url.split('/')
  split_len = split_url.length
  p1 = split_url[split_len - 2]
  p2 = split_url[split_len - 1].split('.')[0]
  share_url = "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}/pub/" + p1 + '-' + p2

  { imageURL: image_url, shareURL: share_url }.to_json
end
