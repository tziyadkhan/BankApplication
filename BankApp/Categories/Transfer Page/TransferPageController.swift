//
//  TransferPageController.swift
//  BankApp
//
//  Created by Ziyadkhan on 06.03.24.
//

import UIKit
import SnapKit

class TransferPageController: UIViewController {
    
    lazy var transferLogo: UIImageView = {
        return ReusableImageView.reusableImage(imageName: "transfer", contentMode: .scaleAspectFill)
    }()
    
    lazy var cardnumberTextField: UITextField = {
        return ReusableTextField.reusableTextField(placeholder: "Card number",
                                                   keyboardType: .numberPad,
                                                   isSecureTextEntry: false,
                                                   borderStyle: .none)
    }()
    
    lazy var cardnumberView: UIView = {
        return ReusableView.reusableView(color: .clear,
                                         borderWith: 0.4,
                                         borderColor: UIColor.black.cgColor,
                                         cornerRadius: 16,
                                         height: 40, width: 300)
        
    }()
    
    lazy var amountTextField: UITextField = {
        return ReusableTextField.reusableTextField(placeholder: "Amount",
                                                   keyboardType: .numberPad,
                                                   isSecureTextEntry: false,
                                                   borderStyle: .none)
    }()
    
    lazy var amountView: UIView = {
        return ReusableView.reusableView(color: .clear,
                                         borderWith: 0.4,
                                         borderColor: UIColor.black.cgColor,
                                         cornerRadius: 16,
                                         height: 40, width: 300)
        
    }()
    
    lazy var transferButton: UIButton = {
        return ReusableButton.reusableButton(title: "Transfer",
                                             titleColour: .white,
                                             fontName: "Helvetica Neue Bold",
                                             size: 20,
                                             backgroundColour: UIColor(red: 115/255, green: 212/255, blue: 108/255, alpha: 1),
                                             target: self,
                                             action: #selector(transferButtonTapped),
                                             controlEvent: .touchUpInside,
                                             cornerRadius: 16)
    }()
    
    var coordinator: MainCoordinator?
    var userCard = [UserModel]()
    let emailSaved = UserDefaults().string(forKey: "email")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configConstraints()
        
    }
}

extension TransferPageController {
    
    func configUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(transferLogo)
        view.addSubview(cardnumberView)
        view.addSubview(cardnumberTextField)
        view.addSubview(amountView)
        view.addSubview(amountTextField)
        view.addSubview(transferButton)
    }
    
    func configConstraints() {
        transferLogo.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(200)
        }
        
        cardnumberView.snp.makeConstraints { make in
            make.top.equalTo(transferLogo.snp.bottom).inset(-10)
            make.centerX.equalTo(transferLogo)
        }
        
        cardnumberTextField.snp.makeConstraints { make in
            make.center.equalTo(cardnumberView)
            make.left.equalTo(cardnumberView.snp.left).inset(12)
        }
        
        amountView.snp.makeConstraints { make in
            make.top.equalTo(cardnumberView.snp.bottom).inset(-16)
            make.centerX.equalTo(cardnumberView)
        }
        
        amountTextField.snp.makeConstraints { make in
            make.center.equalTo(amountView)
            make.left.equalTo(amountView.snp.left).inset(12)
        }
        
        transferButton.snp.makeConstraints { make in
            make.top.equalTo(amountView.snp.bottom).inset(-20)
            make.centerX.equalTo(amountView)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
    @objc func transferButtonTapped() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .long
        let dateTimeString = dateFormatter.string(from: date)
        
        if let userInfo = userCard.first,
           let cardInfo = userInfo.cardList?.first {
            let currentBalance: Double = cardInfo.cardBalance ?? 0
            let transferAmount: Double? = Double(amountTextField.text ?? "0")
            if (currentBalance >= transferAmount!) && (cardnumberTextField.text?.count == 16) {
                let calculatedAmount: Double = currentBalance - transferAmount!
                successAlert(title: "Uğurlu Ödəniş", message: """
                        Məbləq: \(transferAmount ?? 0) AZN
                        Kartın nömrəsi: \(cardnumberTextField.text ?? "")
                        Transfer olunan tarix: \(dateTimeString)
                        Balans: \(calculatedAmount) AZN
                        """)
                navigationController?.popViewController(animated: true)
            } else {
                AlertView.showAlert(view: self, title: "Uğursuz ödəniş",
                                    message: """
                                  Balansınızda kifayət qədər pul yoxdur və ya Kart nömrəsini düzgün yazmamısnız.
                                  Balans: \(currentBalance) AZN
                                  """)
            }
        }
    }
    
    func successAlert (title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let okayButton = UIAlertAction(title: "Okay",
                                       style: .default) { (_) in
            self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(okayButton)
        self.present(alertController, animated: true)
    }
}
