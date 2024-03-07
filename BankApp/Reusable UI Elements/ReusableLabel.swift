//
//  ReusableLabel.swift
//  BankApp
//
//  Created by Ziyadkhan on 06.03.24.
//

import UIKit

class ReusableLabel {
    static func reusableLabel(fontName: String, 
                              fontSize: CGFloat,
                              numOfLines: Int) -> UILabel {
        
        let label = UILabel()
        label.font = UIFont(name: fontName, size: fontSize)
        label.numberOfLines = numOfLines
        return label
    }
}
