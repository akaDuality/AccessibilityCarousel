//
//  VisibleCollectionViewController.swift
//  AccessibilityCarouselSample
//
//  Created by Mikhail Rubanov on 17.04.2021.
//

import UIKit

class VisibleCollectionViewController: UICollectionViewController {
    
    let colors: [Color] = Color.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.accessibilityElements = [AccessibilityCarousel(accessibilityContainer: collectionView, title: "Цвета")]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath)
        
        let model = colors[indexPath.row]
        cell.backgroundColor = model.color
        cell.isAccessibilityElement = true
        cell.accessibilityLabel = model.description
        
        return cell
    }
}

extension VisibleCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width - collectionView.contentInset.horizontals
        
        return CGSize.init(width: width,
                           height: 200)
    }
}

extension UIEdgeInsets {
    var horizontals: CGFloat {
        left + right
    }
}
