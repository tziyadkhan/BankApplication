//
//  CardsPageController.swift
//  BankApp
//
//  Created by Ziyadkhan on 06.03.24.
//

import UIKit

class CardsPageController: UIViewController {
    
    lazy var cardsTable: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(CategoryTableCell.self, forCellReuseIdentifier: "\(CategoryTableCell.self)")
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    var coordinator: MainCoordinator?
    var userCard = [Card]()
    var userInfo = [UserModel]()
    let helper = UserLoginFileManager()
    let emailSaved = UserDefaults().string(forKey: "email")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configConstraints()
    }
    
}
//MARK: TableView Functions
extension CardsPageController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userCard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CategoryTableCell.self)", for: indexPath) as! CategoryTableCell
        cell.configData(category: userCard[indexPath.item].cardName ?? "bosh")
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showTransfer(userCard: userInfo)
    }
}

//MARK: Functions
extension CardsPageController {
    
    func configUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(cardsTable)
    }
    
    func configConstraints() {
        cardsTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
