require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e

  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'test/unit'
require 'shoulda'

$:.unshift File.join(File.dirname(__FILE__), %w{.. lib})
$:.unshift File.dirname(__FILE__)

module CLIApplicationGenerator

  class TestCase < Test::Unit::TestCase
    #...
  end
end