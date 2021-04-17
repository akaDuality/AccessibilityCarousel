//
//  AccessibleCarousel.swift
//  AccessibilityCarouselSample
//
//  Created by Mikhail Rubanov on 17.04.2021.
//

import UIKit

class AccessibilityCarousel: UIAccessibilityElement {
    
    init(accessibilityContainer: UICollectionView, title: String) {
        self.collectionView = accessibilityContainer
        
        super.init(accessibilityContainer: accessibilityContainer)
        
        accessibilityTraits = .adjustable
        accessibilityLabel = title
        accessibilityFrameInContainerSpace = collectionView.frame
    }
    
    var collectionView: UICollectionView
    
    override var accessibilityValue: String? {
        get {
            guard let cell = collectionView.centerCell() else { return nil }
            
            let value = [cell.accessibilityCompactDescription,
                         collectionView.pathDescription(for: cell)]
                .joinedWithComma
            
            return value
        }
        
        set {}
    }
    
    // MARK: Accessibility
    /*
     Overriding the following two methods allows the user to perform increment and decrement actions
     (done by swiping up or down).
     */
    /// - Tag: accessibility_increment_decrement
    override func accessibilityIncrement() {
        // This causes the picker to move forward one if the user swipes up.
        collectionView.accessibilityScrollForward()
    }
    
    override func accessibilityDecrement() {
        // This causes the picker to move back one if the user swipes down.
        collectionView.accessibilityScrollBackward()
    }
    
    /*
     This will cause the picker to move forward or backwards on when the user does a 3-finger swipe,
     depending on the direction of the swipe. The return value indicates whether or not the scroll was successful,
     so that VoiceOver can alert the user if it was not.
     */
    override func accessibilityScroll(_ direction: UIAccessibilityScrollDirection) -> Bool {
        if direction == .left {
            return collectionView.accessibilityScrollForward()
        } else if direction == .right {
            return collectionView.accessibilityScrollBackward()
        }
        return false
    }
    
    override func accessibilityActivate() -> Bool {
        guard let path = collectionView.centerPath() else { return false }
        collectionView.selectAsUser(path: path)
        return true
    }
}

extension CGRect {
    var center: CGPoint {
        CGPoint(x: minX + width / 2,
                y: minY + height / 2)
    }
}

extension UIView {
    var accessibilityCompactDescription: String {
        [accessibilityLabel,
         accessibilityValue].joinedWithComma
    }
}

extension Array where Element == Optional<String> {
    var joinedWithComma: String {
        compactMap { $0 }
            .joined(separator: ", ")
    }
}
