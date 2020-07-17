Pod::Spec.new do |s|
  s.name           = 'AnalyticsGen'
  s.version        = '0.1.4'
  s.summary        = 'Command line tool for generating analytics layer'
  s.homepage       = 'https://github.com/alexfilimon/swift-analytics-gen'
  s.source         = { http: "#{s.homepage}/releases/download/#{s.version}/AnalyticsGen-#{s.version}.zip" }
  s.preserve_paths = '*'
  s.exclude_files  = '**/file.zip'
  s.author         = { "Alexander Filimonov" => "as_filimon@mail.ru" }
  s.license        = { :type => "MIT", :file => "LICENSE" }
end