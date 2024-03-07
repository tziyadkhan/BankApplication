//
//  ReusableButton.swift
//  BankApp
//
//  Created by Ziyadkhan on 06.03.24.
//

import UIKit

class ReusableButton {
    static func reusableButton(title: String,
                               titleColour: UIColor,
                               fontName: String,
                               size: CGFloat,
                               backgroundColour: UIColor,
                               target: Any?,
                               action: Selector,
                               controlEvent: UIControl.Event,
                               cornerRadius: CGFloat) -> UIButton {
        
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColour, for: .normal)
        button.titleLabel?.font = UIFont(name: fontName, size: size)
        button.backgroundColor = backgroundColour
        button.addTarget(target, action: action, for: controlEvent)
        button.layer.cornerRadius = cornerRadius
        
        return button
    }
}
