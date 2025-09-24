Pod::Spec.new do |s|
  s.name             = 'UXTrackerSDK'
  s.version          = '0.0.1'
  s.summary          = 'UXTracker SDK for iOS.'
  s.description      = 'A Swift SDK for tracking UX metrics in iOS applications.'
  s.homepage         = 'https://github.com/JorgeLuisZB/uxtracker-ios-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jorge Zaragoza' => 'jorgezb.contact@gmail.com' }

  s.source           = {
    :git => 'https://github.com/JorgeLuisZB/uxtracker-ios-sdk.git',
    :tag => s.version.to_s
  }

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.9'

  s.source_files = 'Sources/**/*.{swift,h,m}'
  s.exclude_files = 'Tests/**/*'

  # If you have any resources like xibs, assets, etc., expose them like this:
  # s.resources = ['Sources/**/*.xcassets', 'Sources/**/*.xib']

end
