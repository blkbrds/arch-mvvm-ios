source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
inhibit_all_warnings!
use_frameworks!
install! 'cocoapods', :deterministic_uuids => false

target 'MVVM' do
    pod 'Alamofire', '~> 4.3.0'
    pod 'SwiftLint', '~> 0.16.1'
    pod 'RealmS', '~> 2.2.0'
    pod 'SwiftyJSON', '~> 3.1.4'

    target 'MVVMTests' do
        inherit! :search_paths
    end
end
