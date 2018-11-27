#
# Be sure to run `pod lib lint SwiftlyPro.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftlyPro'
  s.version          = '0.1.0'
  s.summary          = 'A collection of extensions that will help you out with your project.'
  s.swift_version    = '4.2'
  

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'A collection of extensions that will help you out with your project. There are extensions for Strings, Dates etc.'

  s.homepage         = 'https://github.com/leodabus/SwiftlyPro'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'leodabus' => 'leodabus@gmail.com' }
  s.source           = { :git => 'https://github.com/leodabus/SwiftlyPro.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'SwiftlyPro/Classes/*.swift'
  
  # s.resource_bundles = {
  #   'SwiftlyPro' => ['SwiftlyPro/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
