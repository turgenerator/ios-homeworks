//
//  FeedViewController.swift
//  Navigation
//
//  Created by Nikita Turgenev on 19.02.2022.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        buttonPost()
    }
    
    
    struct Post {
        var title: String
    }
    
    let post = Post(title: "Переданный пост")
    
    
    func buttonPost() {
        let button = UIButton(frame: CGRect(x: 100, y: 50, width: 190, height: 50))
        
        view.addSubview(button)
        
        button.setTitle("Перейти на пост", for: .normal)
        button.backgroundColor = .purple
        button.center = view.center
        
        button.addTarget(self, action: #selector(self.clickStart(_:)), for: .touchUpInside)
        
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        
        
        
        
    }
    @objc func clickStart(_ sender: UIButton) {
      //  present(PostViewController(), animated: true, completion: nil)
        let newVC = PostViewController()
        self.navigationController?.pushViewController(newVC, animated: true)
        newVC.titlePost = "Олежа"
    }

}

