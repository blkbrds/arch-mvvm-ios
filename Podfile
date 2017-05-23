source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
inhibit_all_warnings!
use_frameworks!
install! 'cocoapods', :deterministic_uuids => false

workspace 'MVVM.xcworkspace'

target 'Demo' do
    project 'Demo'
    pod 'SAMKeychain', '~> 1.5.1'
    pod 'Alamofire', '~> 4.3.0'
    pod 'SwiftLint', '~> 0.16.1'
    pod 'RealmS', '~> 2.3.1'
    pod 'SwiftyJSON', '~> 3.1.4'
    pod 'MVVM', :path => './'

    target 'DemoTests' do
        project 'Demo'
        inherit! :search_paths
    end
end
