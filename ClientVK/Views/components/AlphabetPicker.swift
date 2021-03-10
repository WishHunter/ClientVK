//
//  AlphabetPicker.swift
//  ClientVK
//
//  Created by d.molkov on 10.03.2021.
//

import UIKit

@IBDesignable
class AlphabetPicker: UIControl {

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
        print(letters)
        for letter in letters {
            let button = UIButton(type: .system)
            button.setTitle(String(letter), for: .normal)
            button.setTitleColor(.lightGray, for: .selected)
            button.addTarget(self, action: #selector(selectLetter), for: .touchUpInside)
            self.buttons.append(button)

        }
        
        stackView = UIStackView(arrangedSubviews: self.buttons)

        self.addSubview(stackView)

        stackView.spacing = 20
        stackView.axis = .vertical
//        stackView.alignment = .center
//        stackView.distribution = .fillEqually

    }
    
    private func updateSelectedLetter() {
        for (index, button) in self.buttons.enumerated() {
            guard let letter = Optional(letters[index]) else { continue }
            button.isSelected = letter == self.selectedLetter
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    @objc private func selectLetter(_ sender: UIButton) {
        print(#function)
        guard let index = self.buttons.firstIndex(of: sender) else { return }
        guard let letter = Optional(letters[index]) else { return }
        self.selectedLetter = letter
    }
}
