source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
inhibit_all_warnings!
use_frameworks!
install! 'cocoapods', :deterministic_uuids => false

workspace 'MVVM.xcworkspace'

target 'Demo' do
    project 'Demo'
    pod 'SAMKeychain', '~> 1.5.1'
    pod 'Alamofire', '~> 4.7.3'
    pod 'SwiftLint', '~> 0.31.0'
    pod 'RealmS', '~> 2.3.1'
    pod 'ObjectMapper', '2.2.6' # please fix this version
    pod 'SwiftyJSON', '~> 3.1.4'
    pod 'SwiftDate', '~> 4.5.1'
    pod 'MVVM-Swift', :path => './'

    target 'DemoTests' do
        project 'Demo'
        inherit! :search_paths
    end
end
