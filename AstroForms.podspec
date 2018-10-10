#
# Be sure to run `pod lib lint AstroForms.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AstroForms'
  s.version          = '0.1.1'
  s.summary          = 'An approachable iOS forms framework for building beautiful, reusable and easy to maintain forms.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Astro Forms is a framework that provides the structure to build your own highly custom and reusable forms for a project. 
In this way it's different to other frameworks - it's specifically not a drop in set of subclassable elements or abstraction around UIKit. 
Instead, it's a set of protocols and a minimum of abstract classes you compose to build your forms. 
This is an opinionated way of doing things, however you'll have far less code (less 🐛s) and far more flexibility for anything but trivial stock-standard looking forms.
                       DESC

  s.homepage         = 'https://github.com/plummer/astro-forms'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'plummer' => 'andrewplummer@me.com' }
  s.source           = { :git => 'https://github.com/plummer/astro-forms.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.4'

  s.source_files = 'AstroForms/**/*'
  
  # s.resource_bundles = {
  #   'AstroForms' => ['AstroForms/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
