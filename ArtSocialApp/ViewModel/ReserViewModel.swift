//
//  ReserViewModel.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 22/10/2021.
//

import Foundation
import UIKit

struct ResetViewModel {
    var email : String?
    
    var formIsValid : Bool{
        return email?.isEmpty == false
    }
    
    var backgroundBtnColor : UIColor?{
        return formIsValid  ? #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).withAlphaComponent(0.5)
    }
    var textBtnColor : UIColor?{
        return formIsValid  ? .white :  UIColor(white: 1, alpha: 0.2)
    }
}
