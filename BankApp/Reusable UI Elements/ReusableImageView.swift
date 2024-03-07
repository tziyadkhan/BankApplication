//
//  ReusableImageView.swift
//  BankApp
//
//  Created by Ziyadkhan on 06.03.24.
//

import UIKit

class ReusableImageView {
    
    static func reusableImage(imageName: String, 
                              contentMode: UIView.ContentMode) -> UIImageView {
        
        let image = UIImageView()
        image.image = UIImage(named: imageName)
        image.contentMode = contentMode
        
        return image
    }
}
