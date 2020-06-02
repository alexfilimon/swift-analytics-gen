Pod::Spec.new do |s|
  s.name           = 'AnalyticsGen'
  s.version        = '0.1.0'
  s.summary        = 'Command line tool for generating analytics layer'
  s.homepage       = 'https://github.com/alexfilimon/swift-analytics-gen'
  s.source         = { :git => 'https://github.com/alexfilimon/swift-analytics-gen', :tag => s.version.to_s }
  s.author         = { "Alexander Filimonov" => "as_filimon@mail.ru" }
  s.source_files   = 'bin/**/*' 
  s.license        = { :type => "MIT", :file => "LICENSE" }
end