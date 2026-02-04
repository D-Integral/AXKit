# SnazzyAccessibility

SnazzyAccessibility is a lightweight Swift library that makes it easy to automatically generate accessibility identifiers for your UIKit views. It was written to simplify automated UI testing by providing consistent, structured identifiers for views.

## Features

- Automatically generates accessibility identifiers for any UIKit element.
- Supports hierarchical identifiers including index, indexPath, and purpose.
- Lightweight and simple to integrate.
- Only active in DEBUG builds, ensuring no impact on production apps.

## Installation

Simply add SnazzyAccessible.swift to your project. No external dependencies are required.

## Usage

### Step 1: Conform your class to Accessible

```swift
class MyViewController: UIViewController, Accessible {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccessibilityIdentifiers()
    }
}
```

### Step 2: Call setupAccessibilityIdentifiersForViewProperties

```swift
let info = AccessibilityInfo(indexPath: IndexPath(row: 0, section: 1),
                             purpose: "testing")
myViewController.setupAccessibilityIdentifiersForViewProperties(withAccessibilityInfo: info)
```

This will automatically assign accessibility identifiers to all UIView properties in your class based on their property name and optional metadata:

<B>\<MyViewController\>.\<propertyName\>[.s\<Section\>-r\<Row\>][.\<Index\>][.\<Purpose\>]</B>

## Example:

For a button property named actionButton in section 1, row 0 with purpose "testing", the resulting identifier will be:

<B>MyViewController.actionButton.s1-r0.testing</B>

## Notes

Identifiers are only generated in DEBUG builds.

The library uses reflection (Mirror) to automatically find all UIView properties in your class.

Useful for UI testing, especially with XCTest.

## Example

```swift
class MyView: UIView, Accessible {
    let titleLabel = UILabel()
    let submitButton = UIButton()
    
    func configureViews() {
        let info = AccessibilityInfo(index: 0, purpose: "submit")
        setupAccessibilityIdentifiersForViewProperties(withAccessibilityInfo: info)
    }
}
```

Generated accessibility identifiers:

MyView.titleLabel
MyView.submitButton.0.submit

## License

SnazzyAccessibility is available under the MIT license. See the LICENSE file for more info.

## Author

Dmytro Skorokhod


