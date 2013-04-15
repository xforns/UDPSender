Pod::Spec.new do |s|
  s.name         = "UDPSender"
  s.version      = "0.2"
  s.summary      = "Really simple iOS app that permits to configure a list of UDP messages that can be sent to a single IP and port."
  s.homepage     = "http://twitter.com/xforns"
  s.license      = 'LICENSE'
  s.author       = { "Xavier Forns" => "xavier.forns@gmail.com" }
  s.source       = { :git => "https://github.com/xforns/UDPSender.git", :tag => "v0.2"}
  s.platform     = :ios, '5.0'
  s.source_files = 'UDPsender'
  s.requires_arc = true
end
