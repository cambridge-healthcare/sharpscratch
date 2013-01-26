#!/usr/bin/env rake

require 'bundler/setup'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'test/**/*_test.rb'
end

task :default => [:test]

require 'yard'
YARD::Rake::YardocTask.new
task :docs => :yard
