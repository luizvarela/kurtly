# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../lib/token_generator')
require File.expand_path(File.dirname(__FILE__) + '/../config/environment')

configure do
  enable :sessions
  set :app_file, __FILE__
  set :views, File.dirname(__FILE__) + '/views'
  set :public_folder, File.dirname(__FILE__) + '/../public'
end

helpers do
  
  get '/' do
    slim :index
  end
  
  post '/shorten' do
    unless params[:url].nil? and (params[:url] =~ URI::regexp).nil?
        token = TokenGenerator.new.generate_token(params[:url])
        $redis.set(URL_TOKEN_NAMESPACE + token, params[:url])
        $redis.sadd('urls', token + "*" + params[:url])
        @shorten = DOMAIN + token
        slim :shorten
    else
      halt 400, 'Invalid URL'
    end
  end
  
  not_found do  
    halt 404, 'page not found'  
  end
  
end