require 'bundler/setup'

require 'rack/static'
use Rack::Static,
  :urls => ["*.txt", "*.js", "*.css", "*.html"],
  :root => File.expand_path('public', __FILE__)

require File.expand_path('../lib/api', __FILE__)
run NHSHackDay::Root
