//
//  LoginController.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 19/09/2021.
//

import Foundation
import UIKit


class LoginController :  UIViewController{
    
    
    //MARK - PROPRETIES
    private let imageViewLogo : UIImageView =  {
        let imageView =  UIImageView()
        imageView.image = UIImage(named: "artex")
        imageView.contentMode =  .scaleAspectFit
        imageView.setHeight(height: 60)
        return imageView
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
    
    private let loginButton : CustomButton = {
       let button =  CustomButton(placeHolder: "Log In")
        button.setHeight(height: 50)
        button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        return button
    }()
    
    private let forgetButton :  UIButton = {
        let button  = UIButton(type: .system)
        button.setCustomAttributedText(firstPart: "Forget Password?", secondPart: "Get Help Sign In")
        return button
    }()
    
    private lazy var signUpButton : UIButton =  {
        let button =  UIButton(type: .system)
        button.setCustomAttributedText(firstPart: "Need a new account?", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(handleGoSignUp), for: .touchUpInside)
        return button
    }()
    //MARK - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setNavigationBar()
        configureView()
    }
    //MARK - NAVIGATION CONTROLLER
    
    private func setNavigationBar(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    
    

    
    
    //MARK - FUNCTIONS
    private func configureView(){
        
        let stackView  =  UIStackView(arrangedSubviews: [imageViewLogo, emailTxtField, passwordTxtField, loginButton, forgetButton])
        //stackView.alignment = .fill
        //stackView.backgroundColor = .black
        stackView.axis = .vertical
        stackView.spacing =  20
//        
//        view.addSubview(imageViewLogo)
//        imageViewLogo.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 200, paddingLeft: 32, paddingRight: 32)
//        imageViewLogo.setHeight(height: 60)

        
        view.addSubview(stackView)
        stackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 120, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(signUpButton)
        signUpButton.anchor(leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingLeft: 32, paddingRight: 32, paddingBottom: 20)
     
    }
    
    //MARK - ACTIONS
    
    @objc func logIn(){
        print("Login my account")
    }
    
    @objc func handleGoSignUp(){
        let controller  =  RegisterController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}