//
//  AlphabetPickerControl.swift
//  ClientVK
//
//  Created by d.molkov on 10.03.2021.
//

import UIKit

@IBDesignable
class AlphabetPickerControl: UIControl {

    var letters: [Character] = [] {
        didSet {
            self.setupView()
        }
    }
    var selectedLetter: Character? = nil {
        didSet {
                self.updateSelectedLetter()
                self.sendActions(for: .valueChanged)
            }
    }
    
    private var buttons: [UIButton] = []
    private var stackView: UIStackView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        for letter in letters {
            let button = UIButton(type: .system)
            button.setTitle(String(letter), for: .normal)
            button.setTitleColor(.lightGray, for: .selected)
            button.addTarget(self, action: #selector(selectLetter), for: .touchUpInside)
            self.buttons.append(button)

        }
        
        stackView = UIStackView(arrangedSubviews: self.buttons)

        self.addSubview(stackView)

        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        stackConst()

    }
    
    private func updateSelectedLetter() {
        for (index, button) in self.buttons.enumerated() {
            guard let letter = Optional(letters[index]) else { continue }
            button.isSelected = letter == self.selectedLetter
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @objc private func selectLetter(_ sender: UIButton) {
        guard let index = self.buttons.firstIndex(of: sender),
              let letter = Optional(letters[index])
        else { return }
        self.selectedLetter = letter
        sendActions(for: .valueChanged)
    }
}

extension AlphabetPickerControl {
    private func stackConst() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let widthConst = NSLayoutConstraint(item: stackView!, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
        let verticalCenteringConst = NSLayoutConstraint(item: stackView!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        self.addConstraints([widthConst, verticalCenteringConst])
    }
}
