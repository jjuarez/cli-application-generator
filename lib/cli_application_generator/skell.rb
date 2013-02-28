require 'rubygems'
require 'zip'
require 'yaml'
require 'erubis'


module CLIApplicationGenerator
  
  class Skell

    SKELL_SPEC_FILE      = "skell.spec"
    SKELL_TEMPLATES_PATH = "templates"
    
    attr_reader :directories, :elements, :application

    private
    def load_skell_file!

      skell  = { }
      mapper = { }
      
      Zip::ZipFile.open(@skell_file) do |zipfile| 
        
        spec     = zipfile.read(SKELL_SPEC_FILE)
        template = Erubis::Eruby.new(spec).result(binding())
        skell    = YAML::load(template)
        
        skell[:elements].each do |element|

          mapper[element] = {
            :file     =>File.join(@output, @application, skell[element][:file]),
            :template =>zipfile.read(File.join(SKELL_TEMPLATES_PATH, skell[element][:template]))
          } if skell[element]
        end
      end
      
      @directories = skell[:directories]
      @elements    = skell[:elements]
      @mapper      = mapper
    end
    
    public
    def template(element)    
      
      @mapper[element][:template] if @elements.include?(element)
    end
   
    
    def file(element)
      
      @mapper[element][:file] if @elements.include?(element)
    end
   
    
    def initialize(output, application, skell_file)

      @output      = output
      @application = application
      @skell_file  = skell_file
      
      load_skell_file!
      
      self
    end
    
    def inspect
      "{ output: #{@output}, application: #{@application}, id: #{@id}, skell_file: #{@skell_file}, directories: #{@directories.inspect}, elements: #{@elements.inspect}, mapper: #{@mapper.inspect} }"
    end
    
    def to_s
      inspect
    end
  end
end