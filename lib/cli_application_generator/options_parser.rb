require 'rubygems'
require 'choice'


Choice.options do
  header ''
  header 'Specific options:'

  option :application, :required=>true do
    short '-a'
    long  '--application=The application name'
  end

  option :skell, :required=>false do
    short   '-s'
    long    '--skell=The application layout, this identifies a skell file'
    default 'sample'
  end
  
  option :output, :required=>false do
    short   '-o'
    long    '--output=The output directory'
    default '.'
  end
  
  separator ''
  separator 'Common options: '

  option :help do
    long '--help'
    desc 'Show this message'
  end
end
