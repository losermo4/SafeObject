#
# Be sure to run `pod lib lint SafeObject.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SafeObject'
  s.version          = '1.0.0'
  s.summary          = 'A short description of SafeObject.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/gaomin/SafeObject'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gaomin' => 'gaomin@zhuanzhuan.com' }
  s.source           = { :git => 'git@github.com:losermo4/SafeObject.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.default_subspec = 'Signature'

  s.subspec 'Signature' do |ss|
    ss.source_files = 'SafeObject/Classes/Signature/**/*'
  end
  
  s.subspec 'Forwarding' do |ss|
    ss.source_files = 'SafeObject/Classes/Forwarding/**/*'
  end
  
  
  s.dependency 'MSwizzle'
end
