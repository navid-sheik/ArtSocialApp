//
//  CustomButton.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 19/09/2021.
//

import Foundation
import UIKit

class CustomButton :UIButton{
    
    init(placeHolder :  String) {
        super.init(frame: .zero)
        setTitle(placeHolder, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = .gray
        layer.cornerRadius = 5
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleLabel?.font =  UIFont.boldSystemFont(ofSize: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UIButton{
    func setCustomAttributedText(firstPart : String, secondPart : String){
        let atts : [NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.7), .font : UIFont.systemFont(ofSize: 16)]
        let atttributtedTitle  =  NSMutableAttributedString(string: firstPart, attributes: atts)
        let boldAtts  : [NSAttributedString.Key : Any] =  [.font :  UIFont.boldSystemFont(ofSize: 16)]
        atttributtedTitle.append(NSAttributedString(string: " \(secondPart)", attributes: boldAtts))
        
        setAttributedTitle(atttributtedTitle, for: .normal)
    }
}
