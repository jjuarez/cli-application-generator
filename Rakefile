# encoding: utf-8
require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e

  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"

  exit e.status_code
end
require 'rake'
require 'jeweler'
require 'rake/testtask'


Jeweler::Tasks.new do |gem|
  
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name        = "cli-application-generator"
  gem.homepage    = "http://github.com/jjuarez/cli-application-generator"
  gem.license     = "MIT"
  gem.summary     = %Q{CLI Application generator}
  gem.description = %Q{CLI Application generator based on an opinionated configurable structure called skell}
  gem.email       = "javier.juarez@gmail.com"
  gem.authors     = ["Javier Juarez"]
end
Jeweler::RubygemsDotOrgTasks.new


Rake::TestTask.new(:test) do |test|
  
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = false
end


task :default => :test
