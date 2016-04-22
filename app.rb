require 'sinatra'
require 'sinatra/reloader' if development?
require 'json'
require 'net/http'

# not sure if I need all of these
require 'cloudinary'
require 'cloudinary/uploader'
require 'cloudinary/utils'

configure do
  Cloudinary.config do |config|
    config.cloud_name = "thermospas"
    config.api_key = "292598792272471"
    config.api_secret = "_30wu4Lzil091pBTlW59684Kbko"
  end
end

WEB_URL = if production?
            ENV['WEB_URL']
          elsif development?
            'http://localhost:4200'
          end
STORE_URL = 'http://thermospas.com/store.php'

get "/" do
  puts Time.now.to_s
  Time.now.to_s
end

get "/pub/:id" do
  @image_url = 'https://res.cloudinary.com/thermospas/image/upload/' + params[:id] + '.png'
  @image_url.gsub!(/-/, '/')

  erb :cloudinary
end

post "/api/store" do
  headers 'Access-Control-Allow-Origin' => WEB_URL

  store_url = STORE_URL
  uri = URI.parse(store_url)
  params = Rack::Utils.parse_nested_query(request.body.read)
  Net::HTTP.post_form(uri, params)
end

post "/api/upload-image" do
  headers 'Access-Control-Allow-Origin' => WEB_URL

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
