Pod::Spec.new do |s|
  s.name                = "Guile"
  s.version             = "0.1.5"
  s.summary             = "The Gilt User Interface Librarye for iOS."
  s.homepage            = "https://github.com/adamkaplan/guile"
  s.license             = "Apache License, Version 2.0"
  s.authors             = { "Adam Kaplan" => "adkap@adkap.com" }
  s.source = {
    :git => 'https://github.com/adamkaplan/guile.git',
    :tag => s.version.to_s
  }
  s.platform            = :ios, "7.0"
  s.source_files        = "Guile"
  s.frameworks          = "QuartzCore ", "Foundation", "UIKit"
  s.requires_arc        = true
end
