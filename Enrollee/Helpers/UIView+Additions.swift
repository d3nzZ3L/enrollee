//
//  UIView+Additions.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 19.03.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import UIKit

enum GradientType {
    case VerticalGradient
    case HorizontalGradient
}

extension UIView {
    
    func circularCorners() {
        roundCorners(radius: bounds.height * 0.5)
    }
    
    func roundCorners(radius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
    
    func setGradientForBackground(firstColor: UIColor, secondColor: UIColor, type: GradientType) {
        switch type {
        case .VerticalGradient:
            if (self.layer.sublayers?.count) == nil {
                self.alpha = 0.5
                let gradientLayer = CAGradientLayer()
                gradientLayer.frame = self.bounds
                gradientLayer.locations = [-0.8, 1.0]
                gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
                self.layer.addSublayer(gradientLayer)
            }
            break
        case .HorizontalGradient:
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.bounds
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
            self.layer.addSublayer(gradientLayer)
        }
    }
}

extension UITableView {
    func reloadWith(block completion: ()-> Void) {
        reloadData()
        completion()
    }
}
