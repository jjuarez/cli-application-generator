require 'rubygems'
require 'erubis'
require 'config_context'
require 'mini_logger'


module CLIAppGenerator
  
  class CLIAppGeneratorError < StandardError; end
  
  class CliApplication
    
    DEFAULT_PERMISSIONS = 0764
    
    def generate( artifact )
      
      file_name     = @skell.file( artifact )
      template_name = @skell.template( artifact )
  
      raise CLIAppGeneratorError.new ( "Artifact: #{artifact} file not found" ) unless file_name
      raise CLIAppGeneratorError.new ( "Artifact: #{artifact} template not found" ) unless template_name
      
      MiniLogger.debug( "Artifact file: #{file_name}..." )
      File.open( file_name, 'w' ) { |f| f << Erubis::Eruby.new( template_name ).result( binding( ) ) }
    end


    def run( )
      
      MiniLogger.info( "Building directory structure..." )

      Dir.mkdir( @output_directory ) unless Dir.exist?( @output_directory )
      
      application_base = File.join( @output_directory, @application_name )
      
      raise CLIAppGeneratorError.new( "Application directory: '#{application_base}' exist" ) if Dir.exist?( application_base )
      Dir.mkdir( application_base, DEFAULT_PERMISSIONS )
      
      @skell.directories.each do |directory|
  
        application_directory = File.join( application_base, directory )
        
        MiniLogger.debug( "creating: #{application_directory}" )
        Dir.mkdir( application_directory, DEFAULT_PERMISSIONS ) 
      end

      MiniLogger.info( "Generating artifacts..." )      
      @skell.elements.each { |artifact| generate( artifact ) }
    rescue Exception => e
      MiniLogger.error( e.message )
    end

    
    def initialize( application_name, output_directory, skell )
      
      @application_name = application_name
      @output_directory = output_directory
      @skell            = Skell.new( File.expand_path( @output_directory ), @application_name, skell ) 
    rescue Exception => e
      MiniLogger.fatal( e.message )
      exit 1
    end
  end
end