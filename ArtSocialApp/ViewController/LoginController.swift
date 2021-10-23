//
//  LoginController.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 19/09/2021.
//

import Foundation
import UIKit


class LoginController :  UIViewController{
    
    var loginViewModel  =  LoginViewModel()
    weak var delegateAuthetication : AuthenticationDelegate?
    
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
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).withAlphaComponent(0.5)
        button.setTitleColor(UIColor(white: 1, alpha: 0.2), for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        return button
    }()
    
    private let forgetButton :  UIButton = {
        let button  = UIButton(type: .system)
        button.setCustomAttributedText(firstPart: "Forget Password?", secondPart: "Get Help Sign In")
        button.addTarget(self, action: #selector(handleForgetPassword), for: .touchUpInside)
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
        addTxtFieldObservers()
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
        view.addSubview(stackView)
        stackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 120, paddingLeft: 32, paddingRight: 32)
        view.addSubview(signUpButton)
        signUpButton.anchor(leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingLeft: 32, paddingRight: 32, paddingBottom: 20)
        
    }
    private func addTxtFieldObservers (){
        emailTxtField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTxtField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    
    
    //MARK - ACTIONS
    
    @objc func logIn(){
        guard let email =  emailTxtField.text  else {return}
        guard let password  = passwordTxtField.text  else {return}
        
        AuthService.logInUser(email: email, password: password) { (auth, error) in
            if let error = error {
                print("DEBUG : can't loging user \(error.localizedDescription)")
            }
            
            self.delegateAuthetication?.reFetchUserData()
            //self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleGoSignUp(){
        let controller  =  RegisterController()
        controller.delegateAuthetication = delegateAuthetication
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChange(_ sender : UITextField){
        if sender == emailTxtField{
            loginViewModel.email =  sender.text
        }else{
            loginViewModel.password = sender.text
        }
        
        loginButton.backgroundColor =  loginViewModel.backgroundBtnColor
        loginButton.setTitleColor(loginViewModel.textBtnColor, for: .normal)
        loginButton.isEnabled =  loginViewModel.formIsValid
    }
    
    @objc func handleForgetPassword(){
        let passwordController  = ResetPasswordController()
        passwordController.delegate = self
        navigationController?.pushViewController(passwordController, animated: true)
    }
    
}

extension LoginController : ProtocolResetDelegate{
    func sendResetPasswordLink(_ controller: ResetPasswordController) {
        navigationController?.popViewController(animated: true)
        showMessage(title: "Success", message: "We've send email for you")
        
    }
    
    
}
