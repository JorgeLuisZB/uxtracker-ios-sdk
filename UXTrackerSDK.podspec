Pod::Spec.new do |s|
  s.name             = 'UXTrackerSDK'
  s.version          = '1.0.0' # Make sure this matches your Git tag
  s.summary          = 'UXTracker SDK for iOS.'
  s.description      = 'A Swift SDK for tracking UX metrics in iOS applications.'
  s.homepage         = 'https://JorgeZB@bitbucket.org/JorgeZB/uxtracker-ios-sdk.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jorge Zaragoza' => 'jorgezb.contact@gmail.com' }

  s.source           = {
    :git => 'git@bitbucket.org:JorgeZB/uxtracker-ios-sdk.git',
    :tag => s.version.to_s
  }

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.9' # Match your current Swift version, adjust if needed

  s.source_files = 'Sources/**/*.{swift,h,m}' # Adjust if your code is in a different path
  s.exclude_files = 'Tests/**/*'

  # If you have any resources like xibs, assets, etc., expose them like this:
  # s.resources = ['Sources/**/*.xcassets', 'Sources/**/*.xib']

end
