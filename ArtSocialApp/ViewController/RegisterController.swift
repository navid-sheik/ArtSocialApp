//
//  RegisterController.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 19/09/2021.
//

import Foundation
import UIKit

class RegisterController  : UIViewController{
    var signUpViewModel =   SignUpViewModel()
    
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
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).withAlphaComponent(0.5)
        button.setTitleColor(UIColor(white: 1, alpha: 0.2), for: .normal)
        button.isEnabled = false
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
        configureObserverTxtFields()
        
    }
    
    //MARK  - NAVIGATION BAR
    private func setUpNavigationBar(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    
    //MARK - FUNCTION
    private func setUpViews(){
        view.backgroundColor = .black
        
        let stackView  =  UIStackView(arrangedSubviews: [imageViewLogo, nameTxtField, usernameTxtField, emailTxtField, passwordTxtField, signUpButton])
        //stackView.alignment = .fill
        //stackView.backgroundColor = .black
        stackView.axis = .vertical
        stackView.spacing =  20
        view.addSubview(stackView)
        stackView.anchor(top: view.topAnchor, leading: view.leadingAnchor,trailing: view.trailingAnchor,paddingTop: 120, paddingLeft: 32, paddingRight: 32)
        
        
        view.addSubview(loginButton)
        loginButton.anchor(leading : view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingLeft: 32, paddingRight: 32, paddingBottom: 0)
        
    }
    
    private func configureObserverTxtFields (){
        nameTxtField.addTarget(self, action: #selector(handleTextDidChange), for: .editingChanged)
        usernameTxtField.addTarget(self, action: #selector(handleTextDidChange), for: .editingChanged)
        emailTxtField.addTarget(self, action: #selector(handleTextDidChange), for: .editingChanged)
        passwordTxtField.addTarget(self, action: #selector(handleTextDidChange), for: .editingChanged)
    }
    
    //MARK - ACTIONS
    
    @objc func createAccount(){
        print("Create Account ")
        guard let fullName =  nameTxtField.text  else {return}
        guard let userName  = usernameTxtField.text  else {return}
        guard let emailAddress =  emailTxtField.text else {return}
        guard let password  = passwordTxtField.text   else {return}
        
        let auth =  AuthCreditials(fullname: fullName, username: userName, email: emailAddress, password: password)
        
        AuthService.registerNewUser(userCreditials: auth) { (created) in
            if created {
                DispatchQueue.main.async {
                    self.navigationController?.dismiss(animated: true, completion: nil)
                }
      
            }
        }
        
        
    }
    
    @objc func handleGoLogIn(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleTextDidChange(_ sender : UITextField){
        if sender == nameTxtField{
            signUpViewModel.fullName =  sender.text
            
        }else if sender == usernameTxtField{
            signUpViewModel.username =  sender.text
        }else if sender == emailTxtField{
            signUpViewModel.email =  sender.text
        }else if sender == passwordTxtField{
            signUpViewModel.password =  sender.text
        }
        signUpButton.backgroundColor =  signUpViewModel.backgroundBtnColor
        signUpButton.setTitleColor(signUpViewModel.textBtnColor, for: .normal)
        signUpButton.isEnabled =  signUpViewModel.formIsValid
        
        
    }
}
