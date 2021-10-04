//
//  CustomInputAccessoryViewDelegate.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 03/10/2021.
//

import Foundation

import UIKit


protocol CustomInputAccessoryViewDelegate :  class{
    func postNewCommment (_ accessoryView: CustomInputAccessoryView, comment : String)
}
