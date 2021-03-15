//
//  UITextFieldExtension.swift
//  ClientVK
//
//  Created by Denis Molkov on 14.03.2021.
//

import UIKit

extension UITextField {
    func addBottomBorder(insetBottom: CGFloat = 5){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height + insetBottom, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.white.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
