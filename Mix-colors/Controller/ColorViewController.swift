//
//  ColorViewController.swift
//  Mix-colors
//
//  Created by  Maksim Stogniy on 26.05.2024.
//

import UIKit

class ColorViewController: UIViewController {
    let colorView = ColorView(isInteractive: false)

    override func loadView() {
        view = colorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        colorView.delegate = self
        // Do any additional setup after loading the view.
    }
}

//extension ColorViewController: ColorViewDelegate {
//    func colorButtonTapped() {
//        showColorPicker()
//    }
//}

extension ColorViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorView.selectColor(viewController.selectedColor)
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorView.selectColor(viewController.selectedColor)
    }
    
    func showColorPicker() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.selectedColor = colorView.color
        present(colorPicker, animated: true, completion: nil)
    }
}
