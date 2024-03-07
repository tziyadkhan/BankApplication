//
//  ProfilePageController.swift
//  BankApp
//
//  Created by Ziyadkhan on 06.03.24.
//

import UIKit
import SnapKit

class ProfilePageController: UIViewController {
    
    lazy var profileImage: UIImageView = {
        return ReusableImageView.reusableImage(imageName: "personalInfo", contentMode: .scaleAspectFill)
    }()
    
    lazy var fullnameLabel: UILabel = {
        return ReusableLabel.reusableLabel(fontName: "Helvetica Neue Medium",
                                           fontSize: 20,
                                           numOfLines: 0)
    }()
    
    lazy var emailLabel: UILabel = {
        return ReusableLabel.reusableLabel(fontName: "Helvetica Neue Medium",
                                           fontSize: 20,
                                           numOfLines: 0)
    }()
    
    lazy var phoneLabel: UILabel = {
        return ReusableLabel.reusableLabel(fontName: "Helvetica Neue Medium",
                                           fontSize: 20,
                                           numOfLines: 0)
    }()
    
    lazy var birthdateLabel: UILabel = {
        return ReusableLabel.reusableLabel(fontName: "Helvetica Neue Medium",
                                           fontSize: 20,
                                           numOfLines: 0)
    }()
    
    lazy var stackLabel: UIStackView = {
        return ReusableStackView.reusableStackLabel(axis: .vertical,
                                                    distribution: .fillEqually,
                                                    spacing: 12,
                                                    input: [fullnameLabel, emailLabel, birthdateLabel ,phoneLabel])
    }()
    
    lazy var logoutButton: UIButton = {
        return ReusableButton.reusableButton(title: "Logout",
                                             titleColour: .white,
                                             fontName: "Helvetica Neue Medium",
                                             size: 20,
                                             backgroundColour: .red,
                                             target: self,
                                             action: #selector(logoutButtonTapped),
                                             controlEvent: .touchUpInside,
                                             cornerRadius: 20)
    }()
    
    var coordinator: MainCoordinator?
    let emailSaved = UserDefaults.standard.string(forKey: "email")
    let helper = UserLoginFileManager()
    var userProfile = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configConstraint()
        fillData()
    }
}

extension ProfilePageController {
    func configUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(profileImage)
        view.addSubview(stackLabel)
        view.addSubview(logoutButton)
    }
    
    func configConstraint() {
        profileImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(120)
            make.centerX.equalToSuperview()
            make.height.equalTo(120)
            make.width.equalTo(120)
        }
        
        stackLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).inset(-60)
            make.left.right.equalToSuperview().inset(12)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(stackLabel.snp.bottom).inset(-300)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
    func fillData() {
        helper.readUserData { userItems in
            self.userProfile = userItems
            
            if let index = userProfile.firstIndex(where: { $0.email == emailSaved }) {
                let user = userProfile[index]
                self.fullnameLabel.text = "Fullname: \(user.fullname ?? "")"
                self.emailLabel.text = "Email: \(user.email ?? "")"
                self.birthdateLabel.text = "Birthdate: \(user.birthdate ?? "")"
                self.phoneLabel.text = "Phone number: \(user.phonenumber ?? "")"
            }
        }
    }
    
    func setRoot() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            UserDefaults.standard.setValue(false, forKey: "loggedIn") // setting the flag
            sceneDelegate.logoutClicked(windowScene: scene)
        }
    }
    
    @objc func logoutButtonTapped() {
        setRoot()
    }
}
