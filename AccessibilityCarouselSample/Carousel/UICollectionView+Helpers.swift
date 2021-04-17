//
//  UICollectionView+Helpers.swift
//  AccessibilityCarouselSample
//
//  Created by Mikhail Rubanov on 17.04.2021.
//

import UIKit

extension UICollectionView {
    
    func centerPath() -> IndexPath? {
        indexPathForItem(at: bounds.center)
    }
    
    func centerCell() -> UICollectionViewCell? {
        guard let path = centerPath() else { return nil }
        
        return cellForItem(at: path)
    }
    
    @discardableResult
    func accessibilityScrollForward() -> Bool {
        guard let cell = centerCell(),
              let path = indexPath(for: cell),
              let nextPath = nextPath(for: path) else { return false }
        
        scrollAndFocus(path: nextPath)
        return true
    }
    
    @discardableResult
    func accessibilityScrollBackward() -> Bool {
        guard let cell = centerCell(),
              let path = indexPath(for: cell),
              let previousPath = previousPath(for: path) else { return false }
        
        scrollAndFocus(path: previousPath)
        return true
    }
    
    func scrollAndFocus(path: IndexPath) {
        scrollToItem(at: path, at: .centeredHorizontally, animated: true)
        
        if selectionFollowsFocus {
            selectAsUser(path: path)
        }
    }
    
    func nextPath(for path: IndexPath) -> IndexPath? {
        let numberOfItemsInCurrentSection = numberOfItems(inSection: path.section)
        
        if path.row + 1 < numberOfItemsInCurrentSection {
            // Same section
            return IndexPath(row: path.row + 1, section: path.section)
        }
        
        if path.section + 1 < numberOfSections {
            // Next section, first item
            return IndexPath(row: 0, section: path.section + 1)
        }
        
        // Can‘t move forward
        return nil
    }
    
    func previousPath(for path: IndexPath) -> IndexPath? {
        if path.row > 0 {
            // Same section
            return IndexPath(row: path.row - 1, section: path.section)
        }
        
        if path.section > 0 {
            // Next section, first item
            let prevSection = path.section - 1
            let lastRowInPrevSection = numberOfItems(inSection: prevSection) - 1
            return IndexPath(row: lastRowInPrevSection,
                             section: prevSection)
        }
        
        // Can‘t move backward
        return nil
    }
    
    func selectAsUser(path: IndexPath) {
        selectItem(at: path, animated: true, scrollPosition: .centeredHorizontally)
        delegate?.collectionView?(self, didSelectItemAt: path)
    }
    
    func pathDescription(for cell: UICollectionViewCell) -> String?  {
        guard let path = indexPath(for: cell) else { return nil }
        let number = path.row + 1
        let totalCount = numberOfItems(inSection: path.section)
        return "\(number) из \(totalCount)"
    }
}
