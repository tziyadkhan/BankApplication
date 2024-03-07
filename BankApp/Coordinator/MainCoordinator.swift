//
//  MainCoordinator.swift
//  BankApp
//
//  Created by Ziyadkhan on 06.03.24.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var onLogin: ((String, String) -> Void)?
    var onUserReg: ((UserModel) -> Void)?
    
    init(navigationController: UINavigationController,
         onLogin: ( (String, String) -> Void)? = nil,
         onUserReg: ( (UserModel) -> Void)? = nil) {
        
        self.navigationController = navigationController
        self.onLogin = onLogin
        self.onUserReg = onUserReg
    }
    
    func start() {
        let controller = LoginPageController()
        controller.coordinator = self
        navigationController.show(controller, sender: nil)
    }
    
    func showHome() {
        let controller = HomePageController()
        controller.coordinator = self
        controller.title = "Home"
        navigationController.show(controller, sender: nil)
    }
    
    func showRegistration() {
        let controller = RegistrationPageController()
        controller.onLogin = onLogin
        controller.onUserReg = onUserReg
        controller.title = "Register"
        navigationController.show(controller, sender: nil)
    }
    
    func showProfile() {
        let controller = ProfilePageController()
        controller.coordinator = self
        controller.title = "Profile"
        navigationController.show(controller, sender: nil)
    }
    
    func showTransfer(userCard: [UserModel]) {
        let controller = TransferPageController()
        controller.coordinator = self
        controller.userCard = userCard
        controller.title = "Transfer"
        navigationController.show(controller, sender: nil)
    }
    
    func showCardsPage(userCard: [Card], userInfo: [UserModel]) {
        let controller = CardsPageController()
        controller.coordinator = self
        controller.userCard = userCard
        controller.userInfo = userInfo
        controller.title = "Cards"
        navigationController.show(controller, sender: nil)
    }
    
    func showCardRegistration() {
        let controller = CardRegistrationController()
        controller.coordinator = self
        controller.title = "Card Registration"
        navigationController.show(controller, sender: nil)
    }
}
