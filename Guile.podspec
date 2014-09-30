Pod::Spec.new do |s|
  s.name                = "Guile"
  s.version             = "0.1.3"
  s.summary             = "The Gilt User Interface Library for iOS."
  s.homepage            = "https://github.com/gilt/guile"
  s.license             = "Apache License, Version 2.0"
  s.authors             = { "Adam Kaplan" => "akaplan@gilt.com", "Gilt Mobile" => "mobile@gilt.com" }
  s.source              = { :git => "https://github.com/gilt/guile.git", :tag => "0.1.3" }
  s.platform            = :ios, "7.0"
  s.source_files        = "Guile"
  s.frameworks          = "QuartzCore ", "Foundation", "UIKit"
  s.requires_arc        = true
end
