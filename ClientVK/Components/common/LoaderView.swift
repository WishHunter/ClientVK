//
//  LoaderView.swift
//  ClientVK
//
//  Created by Denis Molkov on 21.03.2021.
//

import UIKit

class LoaderView: UIView {
    
    private var circles: [UIView] = []
    private var stack: UIStackView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        for _ in 1...3 {
            let circle = UIView()
            circle.backgroundColor = UIColor(red: 242/255, green: 97/255, blue: 54/255, alpha: 1)
            circle.layer.cornerRadius = self.frame.size.height / 2
            
            circles.append(circle)
        }
        
        stack = UIStackView(arrangedSubviews: circles)
        stack.axis = .horizontal
        stack.spacing = 10
        self.addSubview(stack)
        
        addConstrains()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for index in 0...circles.count - 1 {
            let delay: Double = Double(index) / 3
            let duration: Double = Double(circles.count - 1) / 3
            addAnimation(elem: circles[index], duration: duration, delay: delay)
        }
    }
    
    //MARK: - Constrains
    
    func addConstrains() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 0),
            stack.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0),
            stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
        ])
        
        for circle in circles {
            circle.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                circle.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 0),
                circle.widthAnchor.constraint(equalTo: self.heightAnchor, constant: 0),
            ])
        }
    }
    
    //MARK: - Animations
    
    func addAnimation(elem: UIView, duration: Double, delay: Double) {
        UIView.animate(withDuration: 0.5,
                       delay: delay,
                       options: [.curveEaseInOut, .repeat, .autoreverse],
                       animations: {
                        elem.layer.opacity = 0.1
                       },
                       completion: nil
        )
    }
}
