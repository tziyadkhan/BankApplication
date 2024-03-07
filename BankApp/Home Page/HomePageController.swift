//
//  HomePageController.swift
//  BankApp
//
//  Created by Ziyadkhan on 06.03.24.
//

import UIKit

class HomePageController: UIViewController {
    
    lazy var menuTable: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(CategoryTableCell.self, forCellReuseIdentifier: "\(CategoryTableCell.self)")
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    var coordinator: MainCoordinator?
    let menu = HomeMenu.allCases
    var userHome = [UserModel]()
    let helper = UserLoginFileManager()
    let emailSaved = UserDefaults.standard.string(forKey: "email")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configConstraints()
        readData()
    }
}

//MARK: Table Functions
extension HomePageController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CategoryTableCell.self)", for: indexPath) as! CategoryTableCell
        cell.configData(category: menu[indexPath.row].rawValue)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch menu[indexPath.row] {
        case .profile:
            profile()
        case .transfer:
            transfer()
        case .cards:
            cards()
        case .addCard:
            cardRegister()
        }
    }
}

//MARK: Functions
extension HomePageController {
    
    func configUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(menuTable)
    }
    
    func configConstraints() {
        menuTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func profile() {
        coordinator?.showProfile()
    }
    
    func transfer() {
        coordinator?.showTransfer(userCard: userHome)
    }
    
    func cards() {
        helper.readUserData { userItems in
            self.userHome = userItems
            if let index = userHome.firstIndex(where: { $0.email == emailSaved }) {
                let user = self.userHome[index]
                if let cardlist = user.cardList, !(user.cardList?.count == nil), !(user.cardList?.isEmpty ?? true) {
                    coordinator?.showCardsPage(userCard: cardlist, userInfo: userHome)
                } else {
                    coordinator?.showCardRegistration()
                }
            }
        }
    }
    
    func cardRegister() {
        coordinator?.showCardRegistration()
    }
    
    func readData() {
        helper.readUserData { userItems in
            self.userHome = userItems
        }
    }
}
