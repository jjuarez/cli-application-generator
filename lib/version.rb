module Version
  INFO = {
    :major =>0,
    :minor =>9,
    :patch =>2
  }

  NAME    = 'cli-application-generator'
  VERSION = [ INFO[:major], INFO[:minor], INFO[:patch] ].join( '.' )
end
