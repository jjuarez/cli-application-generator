require 'rubygems'
require 'mini_logger'


begin
  Dir.glob( File.join( File.dirname( __FILE__ ), "**", "*.rb" ) ).each { |library| require library }  
rescue LoadError => le
  MiniLogger.error( le.message )
end