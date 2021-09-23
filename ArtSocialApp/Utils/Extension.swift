//
//  Extension.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 18/09/2021.
//

import Foundation
import UIKit

extension UIView{
    
    
    
    func anchor ( top : NSLayoutYAxisAnchor? = nil,
                  leading : NSLayoutXAxisAnchor? = nil,
                  trailing : NSLayoutXAxisAnchor? = nil,
                  bottom : NSLayoutYAxisAnchor? = nil,
                  paddingTop : CGFloat = 0,
                  paddingLeft : CGFloat = 0,
                  paddingRight : CGFloat = 0,
                  paddingBottom : CGFloat = 0){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        
        if let left = leading {
            leadingAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let right = trailing {
            trailingAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
    }
    
    func centerX ( view : UIView,
                   paddingTop : CGFloat? = 0,
                   paddingBottom : CGFloat? = 0){
        translatesAutoresizingMaskIntoConstraints = false
        
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let top = paddingTop{
            topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        }
     
        
        
        if let botttom = paddingBottom {
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -botttom).isActive = true
        }
        
        
    }
    
    func centerY( view : UIView,
                  paddingLeft : CGFloat? = 0,
                  paddingRight : CGFloat? = 0){
        translatesAutoresizingMaskIntoConstraints = false
        
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        if let left = paddingLeft{
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: left).isActive = true
        }
     
        
        
        if let right = paddingRight {
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -right).isActive = true
        }
        
    }
    
   
    
    func setDimension( width : CGFloat , height : CGFloat){
        translatesAutoresizingMaskIntoConstraints = false
        
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setHeight (height : CGFloat){
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
  
}
