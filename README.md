# RideShare - iOS

[![Build Status](https://travis-ci.com/wakumo/Rideshare_iOS.svg?token=xAfxZdTxXLSX4H5MsXPg&branch=master)](https://travis-ci.com/wakumo/Rideshare_iOS)

## Setup Development Environment

- [SwiftLint](https://github.com/realm/SwiftLint) 0.16.0+
- [Swimat](https://github.com/Jintin/Swimat)
- `./scripts/install` - this script will install
    - [Homebrew](https://github.com/Homebrew/brew) & necessary formulas
    - [rbenv](https://github.com/rbenv/rbenv) & necessary gems
    - [CocoaPods](https://cocoapods.org/) & project's dependences
    > Please use command `bundle exec pod install` instead of `pod install` to update `Pods`.

## Distribution

- [Gym](https://github.com/fastlane/fastlane/tree/master/gym)

- Export IPA

    ```bash
    $ ./scripts/dist/export <build_config>
    ```

- Upload to Fabric

    ```bash
    $ ./scripts/dist/fabric
    ```

    This command will upload IPA found in `./build` folder.

## Coding Convension

Based on [The Official raywenderlich.com Swift Style Guide](https://github.com/raywenderlich/swift-style-guide).
