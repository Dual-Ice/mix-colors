//
//  ColorView.swift
//  Mix-colors
//
//  Created by  Maksim Stogniy on 24.05.2024.
//

import UIKit

protocol ColorViewDelegate: AnyObject {
    func colorButtonTapped(_ colorView: ColorView)
}

final class ColorView: UIView {
    
    private let translator = ColorNameTranslator()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var color: UIColor = .clear {
        didSet {
            button.backgroundColor = color
            updateLabelText()
        }
    }
    
    var language: Language = Language.english {
        didSet {
            updateLabelText()
        }
    }
    
    weak var delegate: ColorViewDelegate?
    
    init(isInteractive: Bool) {
        super.init(frame: .zero)
        setViews()
        layoutViews()
        if isInteractive {
            setRandomColor()
            setActions()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectColor(_ value: UIColor) {
        color = value
    }
}

extension ColorView {
    
    private func setRandomColor() {
        color = [UIColor.red, UIColor.blue, UIColor.green].randomElement() ?? .clear
    }
    
    private func setViews() {
        self.backgroundColor = .clear
        [
            button,
            label
        ].forEach{ addSubview($0) }
    }
    
    private func layoutViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 100),
            button.widthAnchor.constraint(equalToConstant: 100),
            label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: button.centerXAnchor),
        ])
    }
    
    private func setActions() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func updateLabelText() {
        switch language {
            case .english:
                label.text = color.accessibilityName
            case .russian:
                label.text = translator.translateString(color.accessibilityName)
        }
    }
    
    @objc private func buttonTapped() {
        delegate?.colorButtonTapped(self)
    }
}
