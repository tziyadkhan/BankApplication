//
//  RegistrationPageController.swift
//  BankApp
//
//  Created by Ziyadkhan on 06.03.24.
//

import UIKit

class RegistrationPageController: UIViewController {
    
    lazy var bankLogo: UIImageView = {
        return ReusableImageView.reusableImage(imageName: "logo", contentMode: .scaleAspectFill)
    }()
    
    lazy var fullnameTextField: UITextField = {
        return ReusableTextField.reusableTextField(placeholder: "Fullname",
                                                   keyboardType: .default,
                                                   isSecureTextEntry: false,
                                                   borderStyle: .none)
    }()
    
    lazy var fullnameView: UIView = {
        return ReusableView.reusableView(color: .clear,
                                         borderWith: 0.4,
                                         borderColor: UIColor.black.cgColor,
                                         cornerRadius: 16,
                                         height: 40, width: 300)
        
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
    
    lazy var birthdateTextField: UITextField = {
        return ReusableTextField.reusableTextField(placeholder: "Birthdate dd/mm/yyyy",
                                                   keyboardType: .default,
                                                   isSecureTextEntry: false,
                                                   borderStyle: .none)
    }()
    
    lazy var birthdateView: UIView = {
        return ReusableView.reusableView(color: .clear,
                                         borderWith: 0.4,
                                         borderColor: UIColor.black.cgColor,
                                         cornerRadius: 16,
                                         height: 40, width: 300)
        
    }()
    
    lazy var phoneTextField: UITextField = {
        return ReusableTextField.reusableTextField(placeholder: "Phone number",
                                                   keyboardType: .numberPad,
                                                   isSecureTextEntry: false,
                                                   borderStyle: .none)
    }()
    
    lazy var phoneView: UIView = {
        return ReusableView.reusableView(color: .clear,
                                         borderWith: 0.4,
                                         borderColor: UIColor.black.cgColor,
                                         cornerRadius: 16,
                                         height: 40, width: 300)
        
    }()
    
    lazy var passwordTextField: UITextField = {
        return ReusableTextField.reusableTextField(placeholder: "Password",
                                                   keyboardType: .default,
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
    
    lazy var registerbutton: UIButton = {
        return ReusableButton.reusableButton(title: "Register",
                                             titleColour: .white,
                                             fontName: "Helvetica Neue Bold",
                                             size: 20,
                                             backgroundColour: UIColor(red: 115/255, green: 212/255, blue: 108/255, alpha: 1),
                                             target: self,
                                             action: #selector(registerButtonTapped),
                                             controlEvent: .touchUpInside,
                                             cornerRadius: 16)
    }()
    
    let helper = UserLoginFileManager()
    var users = [UserModel]()
    var onLogin: ((String, String) -> Void)?
    var onUserReg: ((UserModel) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configConstraints()
        
        helper.readUserData { userItems in
            self.users = userItems
        }
    }
}

extension RegistrationPageController {
    private func configUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(bankLogo)
        view.addSubview(fullnameView)
        view.addSubview(fullnameTextField)
        view.addSubview(emailView)
        view.addSubview(emailTextField)
        view.addSubview(birthdateView)
        view.addSubview(birthdateTextField)
        view.addSubview(phoneView)
        view.addSubview(phoneTextField)
        view.addSubview(passwordView)
        view.addSubview(passwordTextField)
        view.addSubview(registerbutton)
    }
    
    private func configConstraints() {
        
        bankLogo.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(200)
        }
        
        fullnameView.snp.makeConstraints { make in
            make.top.equalTo(bankLogo.snp.bottom).inset(-32)
            make.centerX.equalTo(bankLogo)
        }
        
        fullnameTextField.snp.makeConstraints { make in
            make.center.equalTo(fullnameView)
            make.left.equalTo(fullnameView.snp.left).inset(12)
        }
        
        emailView.snp.makeConstraints { make in
            make.top.equalTo(fullnameView.snp.bottom).inset(-16)
            make.centerX.equalTo(fullnameView)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.center.equalTo(emailView)
            make.left.equalTo(emailView.snp.left).inset(12)
        }
        birthdateView.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).inset(-16)
            make.centerX.equalTo(emailView)
        }
        
        birthdateTextField.snp.makeConstraints { make in
            make.center.equalTo(birthdateView)
            make.left.equalTo(birthdateView.snp.left).inset(12)
        }
        
        phoneView.snp.makeConstraints { make in
            make.top.equalTo(birthdateView.snp.bottom).inset(-16)
            make.centerX.equalTo(birthdateView)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.center.equalTo(phoneView)
            make.left.equalTo(phoneView.snp.left).inset(12)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(phoneView.snp.bottom).inset(-16)
            make.centerX.equalTo(phoneView)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.center.equalTo(passwordView)
            make.left.equalTo(passwordView.snp.left).inset(12)
        }
        
        registerbutton.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).inset(-16)
            make.centerX.equalTo(passwordView)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
    }
    
    @objc private func registerButtonTapped() {
        onLogin?(emailTextField.text ?? "bosh", passwordTextField.text ?? "bosh")
        let user = UserModel(fullname: fullnameTextField.text ?? "",
                             email: emailTextField.text ?? "",
                             birthdate: birthdateTextField.text ?? "",
                             phonenumber: phoneTextField.text ?? "",
                             password: passwordTextField.text ?? "")
        onUserReg?(user)
        users.append(user)
        helper.writeUserData(users: users)
        navigationController?.popViewController(animated: true)
    }
}
