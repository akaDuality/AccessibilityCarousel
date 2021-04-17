//
//  Color.swift
//  AccessibilityCarouselSample
//
//  Created by Mikhail Rubanov on 17.04.2021.
//

import UIKit

struct Color: CustomStringConvertible {
    let color: UIColor
    let description: String
    
    // MARK: - Constants
    static let orange   = Color(color: .orange, description: "Оранжевый")
    static let green    = Color(color: .green,  description: "Зеленый")
    static let blue     = Color(color: .blue,   description: "Синий")
    
    static var allCases: [Color] {
        [.orange, .green, .blue]
    }
}
