require 'rubygems'
require 'erubis'
require 'config_context'
require 'mini_logger'


module CLIAppGenerator
  
  class CLIAppGeneratorError < StandardError; end
  
  class CliApplication
    
    def generate( element )
      
      file     = @skell.file( element )
      template = @skell.template( element )
  
      raise CLIAppGeneratorError.new ( "Element: #{element} file not found" ) unless file
      raise CLIAppGeneratorError.new ( "Element: #{element} template not found" ) unless template
      
      MiniLogger.debug( "Element #{file}..." )
      File.open( file, 'w' ) { |f| f << Erubis::Eruby.new( template ).result( binding( ) ) }
    end

    def generate_elements
      
      MiniLogger.info( "Generating elements..." )
      
      @skell.elements.each do |element| 
        
        generate( element ) 
      end
    end
        
    def build_directory_structure

      MiniLogger.info( "Building directory structure..." )

      Dir.mkdir( @output_directory ) unless Dir.exist?( @output_directory )
      
      application_base = File.join( @output_directory, @application_name )
      
      raise CLIAppGeneratorError.new( "Application directory: '#{application_base}' exist" ) if Dir.exist?( application_base )
      Dir.mkdir( application_base, 0764 )
      
      @skell.directories.each do |directory|
  
        application_directory = File.join( application_base, directory )
        
        MiniLogger.debug( "creating: #{application_directory}" )
        Dir.mkdir( application_directory ) 
      end
    end

    def run( )
      
      build_directory_structure
      generate_elements
    rescue Exception => e
      MiniLogger.error( e.message )
    end
    
    def initialize( application_name, output_directory, skell )
      
      @application_name = application_name
      @output_directory = output_directory
      @skell            = Skell.new( @output_directory, @application_name, skell ) 
    rescue Exception => e
      MiniLogger.fatal( e.message )
      exit 1
    end
  end
end