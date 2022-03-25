//
//  LogInViewController.swift
//  Navigation
//
//  Created by Nikita Turgenev on 25.03.2022.
//
import UIKit

class LogInViewController: UIViewController {
    
    
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false

        return contentView
    }()

    private lazy var logoView: UIImageView = {
        let logoView = UIImageView(image: UIImage(named: "logo.jpg"))
        logoView.translatesAutoresizingMaskIntoConstraints = false

        return logoView
    }()

    private lazy var initStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 16

        return stackView
    }()

    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = -0.5
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.cornerRadius = 10.0
        stackView.clipsToBounds = true
        

        return stackView
    }()

    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.clipsToBounds = true
        textField.placeholder = "E-mail of phone"
        textField.clearButtonMode = .whileEditing
        

        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.clipsToBounds = true
        textField.placeholder = "Password"
        textField.clearButtonMode = .whileEditing

        return textField
    }()

    private lazy var initButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Log in", for: .normal)
        let image = UIImage(named: "Color_Set")
        button.setBackgroundImage(image, for: .normal)
        button.backgroundColor = UIColor(red: 89, green: 125, blue: 163, alpha: 0.5)
        button.backgroundColor = UIColor.systemBlue
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

    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = false
        setupView()
        setupConstraints()
        registerForKeyboardNotifications()
        

        
    }
    deinit {
        removeKeyboardNotofication()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func removeKeyboardNotofication() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func kbWillShow (_ notification: Notification) {
        
       
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        
    }
    
   @objc  func kbWillHide() {
       scrollView.contentOffset = CGPoint(x: 0, y: -70)
    }
    

    func setupView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.contentView.addSubview(self.logoView)
        self.contentView.addSubview(self.initStackView)
        self.initStackView.addArrangedSubview(textStackView)
        self.textStackView.addArrangedSubview(loginTextField)
        self.textStackView.addArrangedSubview(passwordTextField)
        self.initStackView.addArrangedSubview(initButton)
        
    }

    func setupConstraints() {
        let scrollViewTopConstraint = self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let scrollViewRightConstraint = self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        let scrollViewBottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let scrollViewLeftConstraint = self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        let contentViewCenterXConstraint = self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let contentViewWidth = self.contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        let contentViewTopConstraint = self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor)
        let contentViewBottomAnchor = self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        let logoViewCenterX = self.logoView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        let logoViewTopConstraint = self.logoView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 120)
        let logoViewWidthAnchor = self.logoView.widthAnchor.constraint(equalToConstant: 100)
        let logoViewHeightAnchor = self.logoView.heightAnchor.constraint(equalToConstant: 100)
        let initStackViewTopConstraint = self.initStackView.topAnchor.constraint(equalTo: self.logoView.bottomAnchor, constant: 120)
        let initStackViewLeadingConstraint = self.initStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let initStackViewTrailingConstraint = self.initStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        let initStackViewBottomAnchor = self.initStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)

        let loginTextFieldHeightAnchor = self.loginTextField.heightAnchor.constraint(equalToConstant: 50)
        let passwordTextFieldHeightAnchor = self.passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        let initButtonHeightAnchor = self.initButton.heightAnchor.constraint(equalToConstant: 50)

        NSLayoutConstraint.activate([scrollViewTopConstraint, scrollViewRightConstraint,
                                     scrollViewBottomConstraint, scrollViewLeftConstraint,
                                     contentViewTopConstraint,
                                     contentViewBottomAnchor, contentViewWidth,
                                     contentViewCenterXConstraint,
                                     logoViewCenterX, logoViewTopConstraint,
                                     logoViewWidthAnchor, logoViewHeightAnchor,
                                     initStackViewTopConstraint, initStackViewLeadingConstraint,
                                     initStackViewTrailingConstraint, loginTextFieldHeightAnchor,
                                     passwordTextFieldHeightAnchor, initButtonHeightAnchor,
                                     initStackViewBottomAnchor
                                    ])
    }

    
    @objc private func didTapLogInButton(_ sender: UIButton){
        
        let profileViewController = ProfileViewController()
        if passwordTextField.text != "" && loginTextField.text != ""{
        self.navigationController?.pushViewController(profileViewController, animated: true)
        } else {
            loginTextField.placeholder = "Введите логин для входа"
            passwordTextField.placeholder = "Введите пароль для входа"
        }
        
    
    }

}

