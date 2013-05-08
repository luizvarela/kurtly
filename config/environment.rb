require 'rubygems'
require 'bundler'
require 'uri'
require 'redis'
require 'hiredis'

Bundler.require :default
Dir.glob(File.expand_path(File.dirname(__FILE__)+'/../app/models/**/*.rb')).each{|f| require f}

DOMAIN = "http://short.ly/"

env = ENV["REDIS_URL"] || "redis://127.0.0.1:6379/"
uri = URI.parse(env)
$redis = Redis.new(host: uri.host, port: uri.port)

CLICK_COUNTER_NAMESPACE = "clicks:"
URL_TOKEN_NAMESPACE = "url:"

Slim::Engine.set_default_options pretty: true, sort_attrs: false
