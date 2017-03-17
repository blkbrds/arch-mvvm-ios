source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
inhibit_all_warnings!
use_frameworks!
install! 'cocoapods', :deterministic_uuids => false

def shared_pods
    pod 'Alamofire', '~> 4.3.0'
    pod 'SwiftLint', '~> 0.16.1'
end

target 'MVVM' do
    shared_pods

    target 'MVVMTests' do
        inherit! :search_paths
        shared_pods
    end
end
