//
//  ReusableView.swift
//  BankApp
//
//  Created by Ziyadkhan on 06.03.24.
//

import UIKit

class ReusableView {
    static func reusableView(color: UIColor,
                      borderWith: CGFloat,
                      borderColor: CGColor,
                      cornerRadius: CGFloat,
                      height: Int, width: Int) -> UIView {
        
        let view = UIView()
        view.backgroundColor = color
        view.layer.borderWidth = borderWith
        view.layer.borderColor = borderColor
        view.layer.cornerRadius = cornerRadius
        view.snp.makeConstraints { make in
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        return view
    }
}

