require 'rubygems'
require 'zip'
require 'yaml'
require 'erubis'


module CLIAppGenerator
  
  class Skell

    SKELL_SPEC_FILE      = "skell.spec"
    SKELL_TEMPLATES_PATH = "templates"
    
    attr_reader :directories, :elements
    
    private
    def load_skell_file( skells_directory )

      skell  = {}
      mapper = {}

      Zip::ZipFile.open( File.join( skells_directory, @skell_file ) ) do |zipfile| 
        
        skell = YAML::load( Erubis::Eruby.new( zipfile.read( SKELL_SPEC_FILE ) ).result( binding( ) ) )
        
        skell[:elements].each do |element|

          mapper[element] = {
            :file     => File.join( @output_directory, @application_name, skell[element][:file] ),
            :template => zipfile.read( File.join( SKELL_TEMPLATES_PATH, skell[element][:template] ) )
          } if skell[element]
        end
      end
      
      [skell[:directories], skell[:elements], mapper]
    end
    
    public
    def template( element )    
      @mapper[element][:template] if @elements.include?( element )
    end
    
    def file( element )
      @mapper[element][:file] if @elements.include?( element )
    end
    
    def initialize( output_directory, application_name, id )

      @output_directory  = output_directory
      @application_name  = application_name
      @id                = id.to_sym
      @skell_file        = @id
      @directories, @elements, @mapper = load_skell_file( File.join( File.dirname( __FILE__ ), %w[.. .. skells] ) )
    end
  end
end