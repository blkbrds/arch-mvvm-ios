Pod::Spec.new do |s|
  # Metadata
  s.name         = "MVVM"
  s.version      = "1.0.0"
  s.summary      = "MVVM Architect for iOS application."
  s.description  = <<-DESC
    MVVM Architect for iOS application.
    The benifits:
        - Better separation of concerns.
        - UI independence: easier migration to other UIs.
        - Better testability because of the separation of concerns and the decoupled nature of the code.
                   DESC

  s.homepage     = "https://github.com/asiantechinc/at-mvvm-ios"
  s.screenshots  = "https://github.com/asiantechinc/at-mvvm-ios/raw/master/images/interactor.png"

  # License
  s.license      = { "type" => "MIT", "file" => "LICENSE" }

  # Author Metadata
  s.author       = { "Dao Nguyen V." => "dao.nguyen@asiantech.vn" }

  # Platform Specifics
  s.platform     = :ios, "9.0"

  # Source Location
  s.source       = { :git => "https://github.com/asiantechinc/at-mvvm-ios.git", :tag => "#{s.version}" }

  # Source Code
  s.source_files = "MVVM/*.swift"

  # Project Settings
  s.requires_arc = true
end
