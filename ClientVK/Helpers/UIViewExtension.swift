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
    
    func addShadow(to edges: [UIRectEdge], offset: CGFloat = 20, radius: CGFloat = 3.0, opacity: Float = 0.6, color: UIColor = UIColor.black) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        view.layer.masksToBounds = true
        
//        let fromColor = color.cgColor
//        view.backgroundColor = UIColor.blue
        let fromColor = color.cgColor
        
        for edge in edges {
            let shadowLayer = UIView()
            
            shadowLayer.backgroundColor = color
            shadowLayer.layer.shadowColor = fromColor
            shadowLayer.layer.shadowOpacity = opacity
            shadowLayer.layer.shadowRadius = radius
            
            
            
            switch edge {
            case .top:
                shadowLayer.frame = CGRect(x: 0, y: -(self.frame.height), width: self.frame.width, height: self.frame.height)
                shadowLayer.layer.shadowOffset = CGSize(width: 0, height: offset)
            case .bottom:
                shadowLayer.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: self.frame.height)
                shadowLayer.layer.shadowOffset = CGSize(width: 0, height: -(offset))
            case .left:
                shadowLayer.frame = CGRect(x: -(self.frame.width), y: 0, width: self.frame.width, height: self.frame.height)
                shadowLayer.layer.shadowOffset = CGSize(width: offset, height: 0)
            case .right:
                shadowLayer.frame = CGRect(x: self.frame.width, y: 0, width: self.frame.width, height: self.frame.height)
                shadowLayer.layer.shadowOffset = CGSize(width: -(offset), height: 0)
            default:
                break
            }
            
            view.addSubview(shadowLayer)
        }
        self.addSubview(view)
    }

    func removeAllShadows() {
        if let sublayers = self.layer.sublayers, !sublayers.isEmpty {
            for sublayer in sublayers {
                sublayer.removeFromSuperlayer()
            }
        }
    }
}

