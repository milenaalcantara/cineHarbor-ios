//
//  Color+.swift
//  CineHarbor
//
//  Created by Milena on 28/04/2025.
//

import UIKit

extension UIColor {
    static var theme: Theme.Type {
        return Theme.self
    }
}

struct Theme {
    static let backgroundColor = UIColor(named: "BackgroundColor")
    static let barColor = UIColor(named: "BarColor")
}
