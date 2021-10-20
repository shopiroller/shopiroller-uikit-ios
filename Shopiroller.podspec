#
# Be sure to run `pod lib lint Shopiroller.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Shopiroller'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Shopiroller.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ealtaca/Shopiroller'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ealtaca' => 'ealtaca@gmail.com' }
  s.source           = { :git => 'https://github.com/ealtaca/Shopiroller.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'Shopiroller/**/*'
  
  s.resource_bundles = {
    'Shopiroller' => ['Shopiroller/Assets/**/*', 'Shopiroller/Classes/**/*.xib','Shopiroller/Assests/Fonts/*.{ttf}']
  }

  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Kingfisher'
  s.dependency 'SVProgressHUD'
  s.dependency 'ImageSlideshow'
  s.dependency 'ImageSlideshow/Kingfisher'
end
