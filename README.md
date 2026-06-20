# AXKit

AXKit is a lightweight Swift package that automatically generates structured accessibility identifiers for your UIKit views. It was written to simplify automated UI testing by giving every view a consistent, predictable identifier derived from the property that owns it.

## Features

- Automatically assigns accessibility identifiers to every `UIView` property of a type.
- Builds hierarchical identifiers from the owning type, property name, and optional `index`, `indexPath`, and `purpose` metadata.
- Uses reflection (`Mirror`), so there is no boilerplate per view.
- Active only in `DEBUG` builds, so it has zero impact on release/production apps.
- Distributed exclusively via Swift Package Manager.

## Requirements

- iOS 12.0+
- Swift 5.9+
- Xcode 15+

## Installation

AXKit is distributed via [Swift Package Manager](https://www.swift.org/package-manager/).

### Xcode

In Xcode, go to **File → Add Package Dependencies…**, enter the repository URL, and add the `AXKit` library to your target:

```
https://github.com/D-Integral/AXKit.git
```

### Package.swift

Add AXKit to the `dependencies` of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/D-Integral/AXKit.git", from: "0.1.4")
]
```

Then add `"AXKit"` to the dependencies of any target that needs it:

```swift
.target(
    name: "YourTarget",
    dependencies: ["AXKit"]
)
```

## Usage

### Step 1: Conform your type to `Accessible`

Any class can adopt the `Accessible` protocol. It has no requirements—conforming simply unlocks the `setupAccessibilityIdentifiersForViewProperties(withAccessibilityInfo:)` helper.

```swift
import UIKit
import AXKit

class MyViewController: UIViewController, Accessible {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccessibilityIdentifiersForViewProperties()
    }
}
```

### Step 2: (Optional) Provide additional metadata

Pass an `AccessibilityInfo` value to disambiguate views that appear in lists, collections, or repeated contexts. Every field is optional:

```swift
let info = AccessibilityInfo(indexPath: IndexPath(row: 0, section: 1),
                             purpose: "testing")
setupAccessibilityIdentifiersForViewProperties(withAccessibilityInfo: info)
```

`AccessibilityInfo` is defined as:

```swift
public struct AccessibilityInfo {
    public let index: Int?
    public var indexPath: IndexPath?
    public let purpose: String?

    public init(index: Int? = nil,
                indexPath: IndexPath? = nil,
                purpose: String? = nil)
}
```

## Identifier format

Each `UIView` property receives an identifier built from the owning type and property name, followed by the optional metadata in this order:

```
<TypeName>.<propertyName>[.s<section>-r<row>][.<index>][.<purpose>]
```

### Example

For a button property named `actionButton` on `MyViewController`, with `indexPath` (section `1`, row `0`) and purpose `"testing"`, the resulting identifier is:

```
MyViewController.actionButton.s1-r0.testing
```

With no `AccessibilityInfo`, the same button would simply be:

```
MyViewController.actionButton
```

## How it works

- The library reflects over `self` using `Mirror` and assigns an `accessibilityIdentifier` to every child whose value is a `UIView`.
- A trailing `.storage` suffix (added by some property wrappers) is stripped from the property name before it is used.
- All of this runs **only when the `DEBUG` flag is set**, so release builds are completely unaffected.

This makes AXKit especially handy for UI testing with `XCTest`, where stable, human-readable identifiers make queries far easier to write and maintain.

## License

AXKit is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Author

Dmytro Skorokhod
