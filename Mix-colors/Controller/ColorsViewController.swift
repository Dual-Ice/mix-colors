//
//  ViewController.swift
//  Mix-colors
//
//  Created by  Maksim Stogniy on 24.05.2024.
//

import UIKit

final class ColorsViewController: UIViewController {
    private let colorsView = ColorsView()
    private var selectedColorView: ColorView?

    override func loadView() {
        view = colorsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorsView.setDelegates(self)
        mixColors()
    }
    
    private func mixColors() {
        let colors = colorsView.getColors()
        
        let firstComponents = colors[0].cgColor.components ?? [0.0, 0.0, 0.0]
        let secondComponents = colors[1].cgColor.components ?? [0.0, 0.0, 0.0]
        
        let mixedRed = (firstComponents[0] + secondComponents[0]) / 2
        let mixedGreen = (firstComponents[1] + secondComponents[1]) / 2
        let mixedBlue = (firstComponents[2] + secondComponents[2]) / 2
        
        let mixedColor = UIColor(red: mixedRed, green: mixedGreen, blue: mixedBlue, alpha: 1.0)
        colorsView.setResultColor(mixedColor)
    }
}


extension ColorsViewController: ColorViewDelegate {
    func colorButtonTapped(_ colorView: ColorView) {
        selectedColorView = colorView
        showColorPicker(for: colorView)
    }
}

extension ColorsViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
            if let selectedColorView = selectedColorView {
                selectedColorView.selectColor(viewController.selectedColor)
                mixColors()
            }
        }
        
        func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
            if let selectedColorView = selectedColorView {
                selectedColorView.selectColor(viewController.selectedColor)
                mixColors()
            }
        }
    
    func showColorPicker(for colorView: ColorView) {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.selectedColor = colorView.color
        present(colorPicker, animated: true, completion: nil)
    }
}

