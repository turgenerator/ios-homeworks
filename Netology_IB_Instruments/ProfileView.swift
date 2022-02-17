//
//  ProfileView.swift
//  Netology_IB_Instruments
//
//  Created by Nikita Turgenev on 17.02.2022.
//

import UIKit

class ProfileView: UIView {

    @IBOutlet weak var myName: UILabel!
    
    @IBOutlet weak var myCity: UILabel!
    
    @IBOutlet weak var myAge: UILabel!
    
    @IBOutlet weak var myImage: UIImageView!
    
    @IBOutlet weak var myText: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }

    private func setupView() {
        let view = self.loadViewFromXib()
        self.addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }

    private func loadViewFromXib() -> UIView {
        guard let view = Bundle.main.loadNibNamed("ProfileView", owner: self, options: nil)?.first as? UIView else { return UIView() }
        
        return view
        
    }
}
