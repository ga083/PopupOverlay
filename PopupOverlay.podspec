Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '10.0'
  s.swift_version = "5.0"
  s.name = "PopupOverlay"
  s.version = "1.0.0"
  s.summary = "A popup message that dims the background and displays text and image."
  s.description = <<-DESC
A popup message that dims the background and displays text and image.
Can be customized to change font, color, background, etc...
                   DESC
  s.homepage = "https://github.com/ga083/PopupOverlay"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Alexander Solis" => "alexandersv@gmail.com" }
  s.source = { :git => "https://github.com/ga083/PopupOverlay.git", :tag => "#{s.version}" }
  s.source_files = "PopupOverlay", "PopupOverlay/**/*.{h,m}"
  s.framework = "Foundation"
end
