//
//  View.swift
//  Mix-colors
//
//  Created by  Maksim Stogniy on 24.05.2024.
//

import UIKit

enum Language: Int {
    case english = 0
    case russian = 1
    
    var stringValue: String {
        switch self {
        case .english:
            return "ENG"
        case .russian:
            return "RU"
        }
    }
}

final class ColorsView: UIView {
    private let title: UILabel = {
        let label = UILabel()
        label.text = "Mix Colors"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let plusLabel: UILabel = {
        let label = UILabel()
        label.text = "+"
        label.font = UIFont.systemFont(ofSize: 48)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let equalLabel: UILabel = {
        let label = UILabel()
        label.text = "="
        label.font = UIFont.systemFont(ofSize: 48)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: [Language.english.stringValue, Language.russian.stringValue])
       control.selectedSegmentIndex = Language.english.rawValue
       control.translatesAutoresizingMaskIntoConstraints = false
       return control
    }()
    
    private var firstColorView = ColorView(isInteractive: true)
    private var secondColorView = ColorView(isInteractive: true)
    private var resultColorView = ColorView(isInteractive: false)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
        setActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegates(_ value: ColorsViewController) {
        firstColorView.delegate = value
        secondColorView.delegate = value
    }
    
    func getColors() -> [UIColor] {
        return [firstColorView.color, secondColorView.color]
    }
    
    func setResultColor(_ value: UIColor) {
        resultColorView.selectColor(value)
    }
}

extension ColorsView {
    
    private func setViews() {
        self.backgroundColor = UIColor.systemGray6
        [
            title,
            segmentedControl,
            firstColorView,
            plusLabel,
            secondColorView,
            equalLabel,
            resultColorView
            
        ].forEach{ addSubview($0) }
    }
    
    private func layoutViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 28),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 28),
            segmentedControl.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10),
            
            firstColorView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 40),
            firstColorView.widthAnchor.constraint(equalToConstant: 100),
            firstColorView.heightAnchor.constraint(equalToConstant: 120),
            firstColorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            plusLabel.topAnchor.constraint(equalTo: firstColorView.bottomAnchor, constant: 20),
            plusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            secondColorView.topAnchor.constraint(equalTo: plusLabel.bottomAnchor, constant: 15),
            secondColorView.widthAnchor.constraint(equalToConstant: 100),
            secondColorView.heightAnchor.constraint(equalToConstant: 120),
            secondColorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            equalLabel.topAnchor.constraint(equalTo: secondColorView.bottomAnchor, constant: 20),
            equalLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            resultColorView.topAnchor.constraint(equalTo: equalLabel.bottomAnchor, constant: 15),
            resultColorView.widthAnchor.constraint(equalToConstant: 100),
            resultColorView.heightAnchor.constraint(equalToConstant: 120),
            resultColorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    func setActions() {
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        guard let selectedLanguage = Language(rawValue: sender.selectedSegmentIndex) else {
            return
        }
        
        [
            firstColorView,
            secondColorView,
            resultColorView
        ].forEach{
            $0.language = selectedLanguage
        }
    }
}
