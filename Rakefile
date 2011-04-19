$:.unshift( File.join( File.dirname( __FILE__ ), 'lib' ) )

begin
  require 'version'
rescue LoadError => le
  fail( le.message )
end


desc "Clean all temporary artifacts"
task :clean do
  begin
    require 'fileutils'
    
    FileUtils.remove_dir( './pkg', true )
  rescue LoadError=>e
    fail( e.message )
  end
end


desc "Build the gem for the project"
task :build =>[:clean] do
  begin
    require 'jeweler'
  rescue LoadError => e
    fail( "Jeweler not available. Install it with: gem install jeweler" )
  end

  Jeweler::Tasks.new do |gemspec|

    gemspec.name              = Version::NAME
    gemspec.version           = Version::VERSION
    gemspec.rubyforge_project = "http://github.com/jjuarez/#{Version::NAME}"
    gemspec.license           = 'MIT License'
    gemspec.summary           = 'A CLI Application generator based on a configurable structure (skell)'
    gemspec.description       = 'A CLI Application generator'
    gemspec.email             = 'javier.juarez@gmail.com'
    gemspec.homepage          = "http://github.com/jjuarez/#{Version::NAME}"
    gemspec.authors           = ['Javier Juarez']
    gemspec.files             = Dir[ 'lib/**/*.rb' ] + Dir[ 'test/**/*rb' ] + Dir[ 'skells/*.skell' ]
    gemspec.executables       = ['cli_application_generator']

    gemspec.add_dependency( 'choice' ) 
    gemspec.add_dependency( 'zip' )
    gemspec.add_dependency( 'erubis' )
    gemspec.add_dependency( 'mini_logger', '>=0.3.1' )
  end

  Jeweler::GemcutterTasks.new
end


desc "Testing..."
task :test =>[:build] do
  require 'rake/runtest'
  Rake.run_tests 'test/unit/tc_*.rb'
end


desc "Default task"
task :default=>[:build]
