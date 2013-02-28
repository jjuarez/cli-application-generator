require 'rubygems'
require 'erubis'
require 'logging'


module CLIApplicationGenerator
  
  class CLIApplication
    
    DEFAULT_PERMISSIONS = 0764
    
    attr_reader :application
    
    
    def generate(artifact)
      
      file_name     = @skell.file(artifact)
      template_name = @skell.template(artifact)
  
      raise StandardError.new("Artifact: #{artifact} file not found") unless file_name
      raise StandardError.new("Artifact: #{artifact} template not found") unless template_name
      
      @logger.info "Artifact file: #{file_name}..." 
      File.open(file_name, 'w') { |file| file << Erubis::Eruby.new(template_name).result(binding()) }
    end

    def run(options={ })
      
      @logger.info "Building directory structure..."

      Dir.mkdir(@output_directory) unless File.exist?(@output)
      
      application_base = File.join(@output, @application)
      
      raise StandardError.new("Application directory: '#{application_base}' exist") if File.exist?(application_base)
      Dir.mkdir(application_base, DEFAULT_PERMISSIONS)
      
      @skell.directories.each do |directory|
  
        application_directory = File.join(application_base, directory)
        
        @logger.info "creating: #{application_directory}"
        Dir.mkdir(application_directory, DEFAULT_PERMISSIONS) 
      end

      @logger.info "Generating artifacts..."
      @skell.elements.each { |artifact| generate(artifact) }
    rescue => exception
      
      @logger.error exception.message
    end

    def initialize(options)
      
      @logger           = ::Logging.logger(STDERR)
      @logger.level     = :debug
      
      @application = options[:application]
      @output      = options[:output]
      @skell       = Skell.new(File.expand_path(@output), @application, options[:skell]) 
    rescue => exception
      
      @logger.error exception.message
      exit 1
    end
  end
end