//
//  CategoryTableCell.swift
//  BankApp
//
//  Created by Ziyadkhan on 06.03.24.
//

import UIKit

class CategoryTableCell: UITableViewCell {
    
    lazy var categoryLabel: UILabel = {
       return ReusableLabel.reusableLabel(fontName: "Helvetica Neue", fontSize: 24, numOfLines: 0)
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureElements() {
        addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.center.equalToSuperview()
        }
    }
    
    func configData(category: String) {
        categoryLabel.text = category
    }
}
