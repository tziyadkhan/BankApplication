//
//  LoginPageController.swift
//  BankApp
//
//  Created by Ziyadkhan on 06.03.24.
//

import UIKit
import SnapKit

class LoginPageController: UIViewController {
    
    lazy var bankLogo: UIImageView = {
        return ReusableImageView.reusableImage(imageName: "logo", contentMode: .scaleAspectFill)
    }()
    
    lazy var emailTextField: UITextField = {
        return ReusableTextField.reusableTextField(placeholder: "Email",
                                                   keyboardType: .emailAddress,
                                                   isSecureTextEntry: false,
                                                   borderStyle: .none)
    }()
    
    lazy var emailView: UIView = {
        return ReusableView.reusableView(color: .clear,
                                         borderWith: 0.4,
                                         borderColor: UIColor.black.cgColor,
                                         cornerRadius: 16,
                                         height: 40, width: 300)
        
    }()
    
    lazy var passwordTextField: UITextField = {
        return ReusableTextField.reusableTextField(placeholder: "Password",
                                                   keyboardType: .emailAddress,
                                                   isSecureTextEntry: true,
                                                   borderStyle: .none)
    }()
    
    lazy var passwordView: UIView = {
        return ReusableView.reusableView(color: .clear,
                                         borderWith: 0.4,
                                         borderColor: UIColor.black.cgColor,
                                         cornerRadius: 16,
                                         height: 40, width: 300)
        
    }()
    
    lazy var loginButton: UIButton = {
        return ReusableButton.reusableButton(title: "Login",
                                             titleColour: .white,
                                             fontName: "Helvetica Neue Bold",
                                             size: 20,
                                             backgroundColour: UIColor(red: 115/255, green: 212/255, blue: 108/255, alpha: 1),
                                             target: self,
                                             action: #selector(loginButtonTapped),
                                             controlEvent: .touchUpInside,
                                             cornerRadius: 16)
    }()
    
    lazy var registerButton: UIButton = {
        return ReusableButton.reusableButton(title: "Register",
                                             titleColour: .black,
                                             fontName: "Helvetica Neue Bold",
                                             size: 20,
                                             backgroundColour: .clear,
                                             target: self,
                                             action: #selector(registerButtonTapped),
                                             controlEvent: .touchUpInside,
                                             cornerRadius: 16)
    }()
    
    
    lazy var stackView: UIStackView = {
        return ReusableStackView.reusableStackButton(axis: .vertical,
                                                     distribution: .fillEqually,
                                                     spacing: 12,
                                                     input: [loginButton, registerButton])
    }()
    
    var coordinator: MainCoordinator?
    var userLogin = UserModel()
    let helper = UserLoginFileManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraints()
    }
}

//MARK: Functions
extension LoginPageController {
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(bankLogo)
        view.addSubview(emailView)
        view.addSubview(passwordView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(stackView)
        
    }
    
    func configureConstraints() {
        bankLogo.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(200)
        }
        
        emailView.snp.makeConstraints { make in
            make.top.equalTo(bankLogo.snp.bottom).inset(-32)
            make.centerX.equalTo(bankLogo)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.center.equalTo(emailView)
            make.left.equalTo(emailView.snp.left).inset(12)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).inset(-16)
            make.centerX.equalTo(emailView)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.center.equalTo(passwordView)
            make.left.equalTo(passwordView.snp.left).inset(12)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).inset(-16)
            make.centerX.equalTo(passwordView)
            make.width.equalTo(300)
            make.height.equalTo(90)
        }
    }
    
    @objc private func loginButtonTapped() {
        
        if let loginEmail = emailTextField.text,
           let loginPassword = passwordTextField.text,
           !loginEmail.isEmpty,
           !loginPassword.isEmpty{
            helper.readUserData { users in
                if users.contains(where: {$0.email == loginEmail && $0.password == loginPassword }) {
                    UserDefaults.standard.set(loginEmail, forKey: "email")
                    setRoot()
                    coordinator?.showHome()
                } else {
                    AlertView.showAlert(view: self, title: "Xəta", message: "Email və ya şifrə düzgün qeyd edilməyib")
                }
            }
            
        } else {
            AlertView.showAlert(view: self, title: "Xəta", message: "Email və ya şifrə daxil edilməyib")
        }
        
        
    }
    
    @objc private func registerButtonTapped() {
        coordinator?.onLogin = { email, password in
            self.emailTextField.text = email
            self.passwordTextField.text = password
        }
        
        coordinator?.onUserReg = { user in
            self.userLogin = user
        }
        
        coordinator?.showRegistration()
    }
    
    func setRoot() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            UserDefaults.standard.set(true, forKey: "loggedIn") // setting the flag
            sceneDelegate.loginClicked(windowScene: scene)
        }
    }
}
