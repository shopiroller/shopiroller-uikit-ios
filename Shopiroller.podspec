#
# Be sure to run `pod lib lint Shopiroller.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Shopiroller'
  s.version          = '0.2.28'
  s.summary          = 'A short description of Shopiroller.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ealtaca/shopiroller_ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ealtaca' => 'ealtaca@gmail.com' }
  s.source           = { :git => 'https://github.com/ealtaca/shopiroller_ios.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  
  s.platform     = :ios, '13.0'

  s.source_files = "Shopiroller/**/*.{swift,xib,strings}", "Shopiroller/Fonts/*.{ttf}"
  
  s.resources = 'Shopiroller/Assets.xcassets', 'Shopiroller/Fonts/*.{ttf}' , 'Shopiroller/Animations/*.{json}'

  s.dependency 'SVProgressHUD'
  s.dependency 'MaterialComponents/Buttons'
  s.dependency 'FittedSheets'
  s.dependency 'Kingfisher' , '~> 7.1.2'
  s.dependency 'InputMask'
  s.dependency 'lottie-ios'
  s.dependency 'IQKeyboardManagerSwift'
  s.dependency 'Stripe'
  s.dependency 'Braintree'
  s.dependency 'Sentry'
end
