//
//  UIViewExtension.swift
//  ClientVK
//
//  Created by Denis Molkov on 14.03.2021.
//

import UIKit

extension UIView {
    func addGradient(colorTop: UIColor = .black, colorBottom: UIColor = .white, type: CAGradientLayerType = .axial, startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 1, y: 1)) {
        let colorBottom =  colorBottom.cgColor
        let colorTop = colorTop.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = type
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = self.bounds
                
        self.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func addShadow(to edges: [UIRectEdge], radius: CGFloat = 3.0, opacity: Float = 0.6, color: UIColor = UIColor.black) {

        let fromColor = color.cgColor
        let toColor = UIColor.clear.cgColor
        let viewFrame = self.frame
        for edge in edges {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [fromColor, toColor]
            gradientLayer.opacity = opacity

            switch edge {
            case .top:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: viewFrame.width, height: radius)
            case .bottom:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.frame = CGRect(x: 0.0, y: viewFrame.height - radius, width: viewFrame.width, height: radius)
            case .left:
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: radius, height: viewFrame.height)
            case .right:
                gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.frame = CGRect(x: viewFrame.width - radius, y: 0.0, width: radius, height: viewFrame.height)
            default:
                break
            }
            self.layer.addSublayer(gradientLayer)
        }
    }

    func removeAllShadows() {
        if let sublayers = self.layer.sublayers, !sublayers.isEmpty {
            for sublayer in sublayers {
                sublayer.removeFromSuperlayer()
            }
        }
    }
}

