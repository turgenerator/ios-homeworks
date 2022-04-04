//
//  LoginErrorAlert.swift
//  Navigation
//
//  Created by Nikita Turgenev on 04.04.2022.
//


import UIKit

extension UIViewController {
    func openAlert() {
        let alertController = UIAlertController(title: "Ошибка", message: "Некорректные введенные данные", preferredStyle:  .alert)
    
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
    
        alertController.addAction(okAction)
        present(alertController, animated: true)

    }
}
