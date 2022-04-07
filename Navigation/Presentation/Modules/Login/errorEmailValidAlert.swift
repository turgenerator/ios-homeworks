//
//  errorEmailValidAlert.swift
//  Navigation
//
//  Created by Nikita Turgenev on 04.04.2022.
//

import UIKit

extension UIViewController {
    func openAlertEmailError() {
        let alertController = UIAlertController(title: "Ошибка", message: "Некорректные введенный email", preferredStyle:  .alert)
    
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
    
        alertController.addAction(okAction)
        present(alertController, animated: true)

    }
}
