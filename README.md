![FLTextView: UITextView + Placeholder in Swift](https://raw.githubusercontent.com/freeletics/FLTextView/assets/freeletics.png)

[![Version](https://img.shields.io/cocoapods/v/FLTextView.svg)](https://cocoapods.org/pods/FLTextView) [![License](https://img.shields.io/cocoapods/l/FLTextView.svg)](https://github.com/freeletics/FLTextView/blob/master/LICENSE)

FLTextView adds a placeholder to UITextView just like UITextField natively provides. Compared to other similar libraries we allow the ability to grow (in height or content size) the area of UITextView depending on the size of the placeholder.

## Requirements

- iOS 7.0+
- Xcode 6.1

## How To Get Started

[Download FLTextView](https://github.com/freeletics/FLTextView/archive/master.zip) and try out the iPhone example app.

## Communication

- If you **need help**, open an issue.
- If you **find a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Installation with CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Swift and Objective-C projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

Depending on your Deployment Target, specify the following in your Podfile:

### Deployment Target: iOS 7.0+

```ruby
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '7.0'

pod 'FLTextView/Legacy', '~> 1.0'
```

CocoaPods only supports Swift source files for iOS 8.0+ Deployment Targets. That is why after you have installed the pods you will have to manually include the folder ``Pods/FLTextView/FLTextView`` in your Xcode project as a group.

### Deployment Target: iOS 8.0+

```ruby
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'
use_frameworks!

pod 'FLTextView', '~> 1.0'
```

After editing your Podfile, run the following command:

```bash
$ pod install
```

## Usage

You can either configure FLTextView through Interface Builder (see examples) or use it like this:

```swift
let textView = FLTextView(frame: CGRectZero, textContainer: nil)
textView.placeholder = "ClapClap"
textView.placeholderTextColor = UIColor.lightGrayColor()
```

Attributed strings are also supported:

```swift
let placeholder = NSMutableAttributedString(string: "No excuses")
placeholder.addAttribute(NSForegroundColorAttributeName, value: UIColor(white: 0.7, alpha: 1.0), range: NSMakeRange(0, 10))
placeholder.addAttribute(NSStrikethroughStyleAttributeName, value: NSUnderlineStyle.StyleDouble.rawValue, range: NSMakeRange(3, 7))
placeholder.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange(0, 2))

textView.attributedPlaceholder = placeholder
```

## License

FLTextView is available under the MIT license. See the [LICENSE](https://github.com/freeletics/FLTextView/blob/master/LICENSE) file for more info.
