


import UIKit

class LogInViewController: UIViewController {
    
    
    let login = "1234@gmail.com"
    let password = "12345678"
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var logoView: UIImageView = { // ЛОГОТИП
        let logoView = UIImageView(image: UIImage(named: "logo.jpg"))
        logoView.translatesAutoresizingMaskIntoConstraints = false
        
        return logoView
    }()
    
    private lazy var loginTextField: UITextField = { // ЛОГИН
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(20, 0, 0)
        textField.placeholder = "E-mail"
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = { // ПАРОЛЬ
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(20, 0, 0)
        textField.placeholder = "Password"
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        return textField
    }()

    private lazy var initButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Log in", for: .normal)
        let image = UIImage(named: "blue_pixel")
        button.setBackgroundImage(image, for: .normal)
        if button.isSelected {
            button.alpha = 0.8
        } else if button.isHighlighted {
            button.alpha = 0.8
        } else {
            button.alpha = 1.0
        }
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(self.didTapLogInButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true

        return button
    }()
    
    private lazy var errorLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        
        return label
    }()

    override func viewDidLoad() {
        
            super.viewDidLoad()
            view.backgroundColor = .white
            setupView()
            setupConstraints()
            tapGesturt()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
   
    

    func setupView() {
        view.backgroundColor = .white
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.logoView)
        self.scrollView.addSubview(loginTextField)
        self.scrollView.addSubview(passwordTextField)
        self.scrollView.addSubview(initButton)
        self.view.addSubview(self.errorLabel)
        
        
    }

    func setupConstraints() {
        let scrollViewTopConstraint = self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let scrollViewRightConstraint = self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16)
        let scrollViewBottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        let scrollViewLeftConstraint = self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16)
        
        let logoViewCenterX = self.logoView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let logoViewTopConstraint = self.logoView.topAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -193) // topAnchor, constant: 120)
        let logoViewHeightAnchor = self.logoView.heightAnchor.constraint(equalToConstant: 100)
        let logoViewWidthAnchor = self.logoView.widthAnchor.constraint(equalToConstant: 100)
        //constraint(equalTo: self.logoView.heightAnchor, multiplier: 1.0)
        
        let loginTextFieldTopConstraint = self.loginTextField.bottomAnchor.constraint(equalTo: self.logoView.bottomAnchor, constant: 120)
        let loginTextFieldWidthAnchor = self.loginTextField.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        let loginTextFieldHeightAnchor = self.loginTextField.heightAnchor.constraint(equalToConstant: 50)
        
        let passwordTextFieldTopConstraint = self.passwordTextField.topAnchor.constraint(equalTo: self.loginTextField.bottomAnchor, constant: -1)
        let passwordTextFieldWidthAnchor = self.passwordTextField.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        let passwordTextFieldHeightAnchor = self.passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        
        let initButtonTopConstraint = self.initButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 16)
        let initButtonWidthAnchor = self.initButton.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        let initButtonHeightAnchor = self.initButton.heightAnchor.constraint(equalToConstant: 50)
        
       
        let errorLabelTopConstraint = self.errorLabel.topAnchor.constraint(equalTo: self.initButton.bottomAnchor, constant: 16)
        let errorLabelRightConstraint = self.errorLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16)
        let errorLabelLeftConstraint = self.errorLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16)
        
        NSLayoutConstraint.activate([
            scrollViewTopConstraint, scrollViewRightConstraint,
            scrollViewBottomConstraint,scrollViewLeftConstraint,
            logoViewCenterX, logoViewTopConstraint,
            logoViewWidthAnchor, logoViewHeightAnchor,
            loginTextFieldTopConstraint, loginTextFieldWidthAnchor,
            loginTextFieldHeightAnchor,
            passwordTextFieldTopConstraint, passwordTextFieldWidthAnchor,
            passwordTextFieldHeightAnchor,
            initButtonTopConstraint, initButtonWidthAnchor,
            initButtonHeightAnchor, errorLabelTopConstraint, errorLabelLeftConstraint, errorLabelRightConstraint, errorLabelTopConstraint
        ])
    }
    
    

    
    @objc private func didTapLogInButton(_ sender: UIButton){
        
        let profileViewController = ProfileViewController()
        if passwordTextField.text == password && loginTextField.text == login && loginTextField.text?.isValidEmail == true {
        self.navigationController?.pushViewController(profileViewController, animated: true)
        } else if   loginTextField.text != login && loginTextField.text?.isValidEmail == false {
            
            loginTextField.placeholder = "Введите логин для входа"
            loginTextField.backgroundColor = UIColor.white
            
            openAlertEmailError()
            
        }
        if passwordTextField.text != password {
            
        
        
        passwordTextField.placeholder = "Введите пароль для входа"
        passwordTextField.backgroundColor = UIColor.white
        
        openAlert()
        }
        
        if loginTextField.text == "" {
            loginTextField.shake()
            loginTextField.backgroundColor = UIColor.red
        }
        
        if passwordTextField.text == "" {
            passwordTextField.shake()
            passwordTextField.backgroundColor = UIColor.red
        }
        checkCount(inputString: loginTextField)
        checkCount(inputString: passwordTextField)
    }
    
    private func checkCount(inputString: UITextField) {
        let a = 5
        if inputString.text!.count < a {
            errorLabel.textColor = UIColor.purple
            errorLabel.text = "Колличество символов не соответствует,  login = torch2120@gmail.com,password = 12345678"
             
        } else {
            errorLabel.text = ""
        }
        
    }

}



extension LogInViewController { // KEYBOARD
    
    func tapGesturt() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) { // ПОДЪЕМ
        
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let ketboardHeight = keyboardRectangle.height
            let initButtonBottomY = self.initButton.frame.origin.y + initButton.frame.height
            let keyboardOriginY = self.view.frame.height - ketboardHeight
            
            
           var contentOffset = 0
            if keyboardOriginY > initButtonBottomY {
                contentOffset = 125
            }
            self.scrollView.contentOffset = CGPoint(x: 0, y: contentOffset)
        }
    
       
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) { // ОПУСК
        self.view.endEditing(true)
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}
