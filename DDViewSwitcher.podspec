Pod::Spec.new do |s|
s.name         = "DDViewSwitcher"
s.version      = "1.0.0"
s.summary      = "With DDViewSwitcher, you can simply implement the effect of scrolling the view left and right with just two lines. like android TextSwitcher"
s.homepage     = "https://github.com/DingdingKim/DDViewSwitcher"
s.license      = { :type => "MIT" }
s.author       = { "Dingding Kim" => "twlovesh89@gmail.com" }
s.source       = { :git => "https://github.com/DingdingKim/DDViewSwitcher.git", :tag => s.version }
s.source_files  = "Classes", "Classes/**/*.{swift}"
s.ios.deployment_target = "8.0"
end
