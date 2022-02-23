//
//  PostViewController.swift
//  Navigation
//
//  Created by Nikita Turgenev on 23.02.2022.
//


import UIKit

class PostViewController: UIViewController {
    var titlePost:  String?
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Пост"
        self.setupTimer()
        self.view.backgroundColor = UIColor.purple
        textPost()
        configureItem()
     
    }
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.cancelTimer()
    }
    
    private func setupTimer() {
        if self.timer == nil {
            let timer = Timer(timeInterval: 2.0,
                              target: self,
                              selector: #selector(self.updateTextlabel),
                              userInfo: nil,
                              repeats: false)
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.1
            self.timer = timer
        }
    }
    
    private func cancelTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    @objc private func updateTextlabel() {
        self.title = self.titlePost
    }
    
    func textPost() {
        let text = UITextView(frame: CGRect(x: 100, y: 50, width: 300, height: 300))
        view.addSubview(text)
        text.text = "Текст поста"
        text.backgroundColor = .brown
        text.center = view.center
    }
    
    private func configureItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info",
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(nextView))
       
        
    }
    
   @objc func nextView() {
        navigationController?.pushViewController(InfoViewController(), animated: true)
       
    }
    
}
