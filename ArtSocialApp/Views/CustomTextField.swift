//
//  CustomTextField.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 19/09/2021.
//

import Foundation
import UIKit

class CustomTextField : UITextField{
    
    
    init(placeholder : String) {
        super.init(frame: .zero)
        
        let spacer  =  UIView()
        spacer.setDimension(width: 12, height: 50)
        leftView =  spacer
        leftViewMode =  .always
        
        textColor =  .white
        keyboardAppearance =  .dark
        backgroundColor =  UIColor(white: 1, alpha: 0.1)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        attributedPlaceholder =  NSAttributedString(string: placeholder, attributes: [.foregroundColor : UIColor(white: 1, alpha: 0.7) ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
