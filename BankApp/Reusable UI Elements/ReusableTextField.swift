//
//  ReusableTextField.swift
//  BankApp
//
//  Created by Ziyadkhan on 06.03.24.
//

import UIKit

class ReusableTextField {
    static func reusableTextField(placeholder: String, 
                                  keyboardType: UIKeyboardType,
                                  isSecureTextEntry: Bool,
                                  borderStyle: UITextField.BorderStyle) -> UITextField {
        
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = borderStyle
        textField.keyboardType = keyboardType
        textField.isSecureTextEntry = isSecureTextEntry
        textField.font = .systemFont(ofSize: 12)
        
        return textField
    }
}
