//
//  CardRegistrationController.swift
//  BankApp
//
//  Created by Ziyadkhan on 06.03.24.
//

import UIKit

class CardRegistrationController: UIViewController {
    
    lazy var addCardLogo: UIImageView = {
        return ReusableImageView.reusableImage(imageName: "addingCard", contentMode: .scaleAspectFill)
    }()
    
    lazy var cardnameTextField: UITextField = {
        return ReusableTextField.reusableTextField(placeholder: "Card name",
                                                   keyboardType: .default,
                                                   isSecureTextEntry: false,
                                                   borderStyle: .none)
    }()
    
    lazy var cardnameView: UIView = {
        return ReusableView.reusableView(color: .clear,
                                         borderWith: 0.4,
                                         borderColor: UIColor.black.cgColor,
                                         cornerRadius: 16,
                                         height: 40, width: 300)
        
    }()
    
    lazy var cardNumberTextField: UITextField = {
        return ReusableTextField.reusableTextField(placeholder: "Card number",
                                                   keyboardType: .numberPad,
                                                   isSecureTextEntry: false,
                                                   borderStyle: .none)
    }()
    
    lazy var cardNumberView: UIView = {
        return ReusableView.reusableView(color: .clear,
                                         borderWith: 0.4,
                                         borderColor: UIColor.black.cgColor,
                                         cornerRadius: 16,
                                         height: 40, width: 300)
        
    }()
    
    lazy var expireDateTextField: UITextField = {
        return ReusableTextField.reusableTextField(placeholder: "Expiration date",
                                                   keyboardType: .numberPad,
                                                   isSecureTextEntry: false,
                                                   borderStyle: .none)
    }()
    
    lazy var expireDateView: UIView = {
        return ReusableView.reusableView(color: .clear,
                                         borderWith: 0.4,
                                         borderColor: UIColor.black.cgColor,
                                         cornerRadius: 16,
                                         height: 40, width: 300)
    }()
    
    lazy var cvc2TextField: UITextField = {
        return ReusableTextField.reusableTextField(placeholder: "CVC2",
                                                   keyboardType: .numberPad,
                                                   isSecureTextEntry: true,
                                                   borderStyle: .none)
    }()
    
    lazy var cvc2View: UIView = {
        return ReusableView.reusableView(color: .clear,
                                         borderWith: 0.4,
                                         borderColor: UIColor.black.cgColor,
                                         cornerRadius: 16,
                                         height: 40, width: 300)
    }()
    
    
    lazy var createCardButton: UIButton = {
        return ReusableButton.reusableButton(title: "Create",
                                             titleColour: .white,
                                             fontName: "Helvetica Neue Bold",
                                             size: 20,
                                             backgroundColour: UIColor(red: 115/255, green: 212/255, blue: 108/255, alpha: 1),
                                             target: self,
                                             action: #selector(createButtonTapped),
                                             controlEvent: .touchUpInside,
                                             cornerRadius: 16)
    }()
    
    var coordinator: MainCoordinator?
    var users = [UserModel]()
    let helper = UserLoginFileManager()
    let emailSaved = UserDefaults().string(forKey: "email")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configConstraint()
    }
}

extension CardRegistrationController {
    
    func configUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(addCardLogo)
        view.addSubview(cardnameView)
        view.addSubview(cardnameTextField)
        view.addSubview(cardNumberView)
        view.addSubview(cardNumberTextField)
        view.addSubview(expireDateView)
        view.addSubview(expireDateTextField)
        view.addSubview(cvc2View)
        view.addSubview(cvc2TextField)
        view.addSubview(createCardButton)
    }
    
    func configConstraint() {
        addCardLogo.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(200)
        }
        
        cardnameView.snp.makeConstraints { make in
            make.top.equalTo(addCardLogo.snp.bottom).inset(-10)
            make.centerX.equalTo(addCardLogo)
        }
        
        cardnameTextField.snp.makeConstraints { make in
            make.center.equalTo(cardnameView)
            make.left.equalTo(cardnameView.snp.left).inset(12)
        }
        
        cardNumberView.snp.makeConstraints { make in
            make.top.equalTo(cardnameView.snp.bottom).inset(-16)
            make.centerX.equalTo(cardnameView)
        }
        
        cardNumberTextField.snp.makeConstraints { make in
            make.center.equalTo(cardNumberView)
            make.left.equalTo(cardNumberView.snp.left).inset(12)
        }
        expireDateView.snp.makeConstraints { make in
            make.top.equalTo(cardNumberView.snp.bottom).inset(-16)
            make.centerX.equalTo(cardNumberView)
        }
        
        expireDateTextField.snp.makeConstraints { make in
            make.center.equalTo(expireDateView)
            make.left.equalTo(expireDateView.snp.left).inset(12)
        }
        
        cvc2View.snp.makeConstraints { make in
            make.top.equalTo(expireDateView.snp.bottom).inset(-16)
            make.centerX.equalTo(expireDateView)
        }
        
        cvc2TextField.snp.makeConstraints { make in
            make.center.equalTo(cvc2View)
            make.left.equalTo(cvc2View.snp.left).inset(12)
        }
        
        createCardButton.snp.makeConstraints { make in
            make.top.equalTo(cvc2View.snp.bottom).inset(-16)
            make.centerX.equalTo(cvc2View)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
    }
    
    @objc func createButtonTapped() {
        
        helper.readUserData { UserItem in
            self.users = UserItem
            
            if let index = users.firstIndex(where: {$0.email == emailSaved}),
               let cardName = cardnameTextField.text,
               let cardNumber = cardNumberTextField.text,
               let cardDate = expireDateTextField.text,
               let cardCvc2 = cvc2TextField.text,
               !cardName.isEmpty,
               !cardNumber.isEmpty,
               !cardDate.isEmpty,
               !cardCvc2.isEmpty {
                let card = Card(
                    cardName: cardName,
                    cardNumber: cardNumber,
                    cardDate: cardDate,
                    cardCVC2: cardCvc2,
                    cardBalance: 50.0)
                
                users[index].addCard(card)
                helper.writeUserData(users: users)
                navigationController?.popViewController(animated: true)
            } else {
                AlertView.showAlert(view: self, title: "Error", message: "Please fill all the text fields!")
            }
        }
    }
}
