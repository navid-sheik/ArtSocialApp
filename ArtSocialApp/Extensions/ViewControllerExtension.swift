//
//  ViewControllerExtension.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 01/10/2021.
//

import Foundation
import UIKit
import JGProgressHUD


//Show and hide progress loader 
extension UIViewController{
    static var progress =   JGProgressHUD(style: .dark)
    
    func show (_ show : Bool){
        view.endEditing(true)
        if (show){
            UIViewController.progress.show(in: view)
            
        }else {
            UIViewController.progress.dismiss(animated: true)
        }
    }
    
    
    func  showMessage(title : String, message : String){
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
