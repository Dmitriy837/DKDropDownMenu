#
# Be sure to run `pod lib lint DKDropDownMenu.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DKDropDownMenu'
  s.version          = '0.1.0'
  s.summary          = 'Simple nice looking drop down menu'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
If your boss wants you to add a drop down menu to your iOS app and you are tired of empty talks about guidelines and absence of such a control like drop down menu in UIKit - just use DKDropDownMenu.

    More configuration options are added in future. Hopefully. For now you can use shadowView property of DKDropDownViewController to configure shadow's layer if you don't like the default one or subclass DKDropDownViewController to provide your own cell's configurations by overriding UITableViewDataSource protocol methods in case of emergency.
    DESC

  s.homepage         = 'https://github.com/<GITHUB_USERNAME>/DKDropDownMenu'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dmytro Kovryhin' => 'agnostic.88@yandex.ua' }
  s.source           = { :git => 'https://github.com/<GITHUB_USERNAME>/DKDropDownMenu.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'DKDropDownMenu/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DKDropDownMenu' => ['DKDropDownMenu/Assets/*.png']
  # }
  s.resources = ['Pod/Assets/*.{png,storyboard,lproj}']
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
