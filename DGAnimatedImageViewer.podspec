#
# Be sure to run `pod lib lint DGAnimatedImageViewer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'DGAnimatedImageViewer'
s.version          = '0.1.0'
s.summary          = 'Animated image viewer'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
It is animated image gallery. You can display all your images here.
DESC

s.homepage         = 'https://github.com/RahulDG15963/DGAnimatedImageViewer'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Rahul Dasgupta' => 'rahul.dasgupta@innofied.com' }
s.source           = { :git => 'https://github.com/RahulDG15963/DGAnimatedImageViewer.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '10.0'

s.source_files = 'DGAnimatedImageViewer/Classes/**/*'

# s.resource_bundles = {
#   'DGAnimatedImageViewer' => ['DGAnimatedImageViewer/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'
s.frameworks = 'UIKit'
s.dependency 'SDWebImage', '~> 4.0.0'
end

