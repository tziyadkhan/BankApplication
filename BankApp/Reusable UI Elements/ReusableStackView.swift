//
//  ReusableStackView.swift
//  BankApp
//
//  Created by Ziyadkhan on 06.03.24.
//

import UIKit

class ReusableStackView {
    static func reusableStackButton(axis: NSLayoutConstraint.Axis,
                       distribution: UIStackView.Distribution,
                       spacing: CGFloat,
                       input: [UIButton] ) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        stack.distribution = distribution
        stack.spacing = spacing
        
        for view in input {
            stack.addArrangedSubview(view)
        }
        
        return stack
    }
    
    static func reusableStackLabel(axis: NSLayoutConstraint.Axis,
                       distribution: UIStackView.Distribution,
                       spacing: CGFloat,
                       input: [UILabel] ) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        stack.distribution = distribution
        stack.spacing = spacing
        
        for view in input {
            stack.addArrangedSubview(view)
        }
        
        return stack
    }
}
