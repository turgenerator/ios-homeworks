//
//  InfoViewController.swift
//  Navigation
//
//  Created by Nikita Turgenev on 25.03.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .darkGray
        buttonPost()
    }
    
    func buttonPost() {
        let button = UIButton(frame: CGRect(x: 100, y: 50, width: 190, height: 50))
        
        view.addSubview(button)
        
        button.setTitle("Alert", for: .normal)
        button.backgroundColor = .purple
        button.center = view.center
        
        button.addTarget(self, action: #selector(self.clickStart(_:)), for: .touchUpInside)
        
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        
    }
    @objc func clickStart(_ sender: UIButton) {
      //  present(PostViewController(), animated: true, completion: nil)
        let alertController = UIAlertController(title: "Сообщение", message: "Нажмите OK или Cancel", preferredStyle: .alert)

            // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK Pressed")
            }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
           alertController.addAction(okAction)
           alertController.addAction(cancelAction)

           // Present the controller
           self.present(alertController, animated: true, completion: nil)
    }


}

