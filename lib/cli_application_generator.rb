require 'rubygems'
require 'mini_logger'
require 'cli_application_generator/options_parser'
require 'cli_application_generator/skell'
require 'cli_application_generator/cli_application'


module CLIAppGenerator
  
  VERSION_INFO = {
    :major =>0,
    :minor =>9,
    :patch =>3
  }

  NAME    = 'cli-application-generator'
  VERSION = [ VERSION_INFO[:major], VERSION_INFO[:minor], VERSION_INFO[:patch] ].join( '.' )
end

