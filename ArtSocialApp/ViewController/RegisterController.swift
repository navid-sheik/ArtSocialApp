//
//  RegisterController.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 19/09/2021.
//

import Foundation
import UIKit

class RegisterController  : UIViewController{
    
    //MARK - PROPRIETIES
    private let imageViewLogo : UIImageView =  {
        let imageView =  UIImageView()
        imageView.image = UIImage(named: "artex")
        imageView.contentMode =  .scaleAspectFit
        imageView.setHeight(height: 60)
        return imageView
    }()
    
    
    private let nameTxtField  : CustomTextField = {
        let textField =  CustomTextField(placeholder: "Full Name")
        textField.keyboardType = .default
        return textField
    }()
    
    
    
    private let usernameTxtField  : CustomTextField = {
        let textField =  CustomTextField(placeholder: "Username")
        textField.keyboardType = .default
        return textField
    }()
    
    
    private let emailTxtField : CustomTextField = {
        let textField =  CustomTextField(placeholder: "Email")
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    
    private let passwordTxtField : CustomTextField = {
        let textField =  CustomTextField(placeholder: "Password")
        textField.isSecureTextEntry = true
    
        return textField
    }()
    
    private let passwordTxtField2 : CustomTextField = {
        let textField  = CustomTextField(placeholder: "Repeat Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let signUpButton : CustomButton = {
       let button =  CustomButton(placeHolder: "Create Account")
        button.setHeight(height: 50)
        button.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        return button
    }()
    
    

    
    private lazy var loginButton : UIButton =  {
        let button =  UIButton(type: .system)
        button.setCustomAttributedText(firstPart: "Already have an account?", secondPart: "Log In")
        button.addTarget(self, action: #selector(handleGoLogIn), for: .touchUpInside)
        button.setHeight(height: 50)
        return button
    }()
    
    
    
    //MARK - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  .purple
        setUpNavigationBar()
        setUpViews()
        
    }
    
    //MARK  - NAVIGATION BAR
    private func setUpNavigationBar(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    
    //MARK - FUNCTION
    private func setUpViews(){
        view.backgroundColor = .black
        
        let stackView  =  UIStackView(arrangedSubviews: [imageViewLogo, nameTxtField, usernameTxtField, emailTxtField, passwordTxtField, passwordTxtField2, signUpButton])
        //stackView.alignment = .fill
        //stackView.backgroundColor = .black
        stackView.axis = .vertical
        stackView.spacing =  20
        view.addSubview(stackView)
        stackView.anchor(top: view.topAnchor, leading: view.leadingAnchor,trailing: view.trailingAnchor,paddingTop: 120, paddingLeft: 32, paddingRight: 32)
        
        
        view.addSubview(loginButton)
        loginButton.anchor(leading : view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingLeft: 32, paddingRight: 32, paddingBottom: 0)
        
    }
    
    //MARK - ACTIONS
    
    @objc func createAccount(){
        print("Create Account ")
    }
    
    @objc func handleGoLogIn(){
        navigationController?.popViewController(animated: true)
    }
}
