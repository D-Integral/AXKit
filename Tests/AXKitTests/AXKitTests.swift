import XCTest
@testable import AXKit

final class AccessibilityInfoTests: XCTestCase {
    func testDefaultInitProducesNilValues() {
        let info = AccessibilityInfo()
        XCTAssertNil(info.index)
        XCTAssertNil(info.indexPath)
        XCTAssertNil(info.purpose)
    }

    func testInitStoresProvidedValues() {
        let info = AccessibilityInfo(index: 3,
                                     indexPath: IndexPath(item: 0, section: 1),
                                     purpose: "testing")
        XCTAssertEqual(info.index, 3)
        XCTAssertEqual(info.indexPath, IndexPath(item: 0, section: 1))
        XCTAssertEqual(info.purpose, "testing")
    }
}

#if canImport(UIKit)
import UIKit

final class AccessibleTests: XCTestCase {
    final class SampleView: UIView, Accessible {
        let titleLabel = UILabel()
        let actionButton = UIButton()
    }

    func testIdentifiersUseTypeAndPropertyName() {
        let sample = SampleView()
        sample.setupAccessibilityIdentifiersForViewProperties()

        #if DEBUG
        XCTAssertEqual(sample.titleLabel.accessibilityIdentifier, "SampleView.titleLabel")
        XCTAssertEqual(sample.actionButton.accessibilityIdentifier, "SampleView.actionButton")
        #endif
    }

    func testIdentifiersIncludeAccessibilityInfo() {
        let sample = SampleView()
        let info = AccessibilityInfo(indexPath: IndexPath(row: 0, section: 1),
                                     purpose: "testing")
        sample.setupAccessibilityIdentifiersForViewProperties(withAccessibilityInfo: info)

        #if DEBUG
        XCTAssertEqual(sample.actionButton.accessibilityIdentifier, "SampleView.actionButton.s1-r0.testing")
        #endif
    }
}
#endif
