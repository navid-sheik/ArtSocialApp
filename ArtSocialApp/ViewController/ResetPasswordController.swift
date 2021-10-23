//
//  ResetPasswordController.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 19/10/2021.
//

import Foundation
import UIKit


class ResetPasswordController : UIViewController{
    
    //MARK: PROPRIETIS
    var resetViewModel  = ResetViewModel()
    var delegate : ProtocolResetDelegate?
    
    
    private let imageViewLogo : UIImageView =  {
        let imageView =  UIImageView()
        imageView.image = UIImage(named: "artex")
        imageView.contentMode =  .scaleAspectFit
        imageView.setHeight(height: 60)
        return imageView
    }()
    
     lazy  var backButton  : UIImageView = {
        let imageView  =  UIImageView()
        imageView.image = UIImage(systemName: "chevron.left")
        imageView.contentMode =  .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBackButton)))
        return imageView
        
    }()
    
    
    private let emailTxtField : CustomTextField = {
        let textField =  CustomTextField(placeholder: "Email")
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    
    
    private let resetButton : CustomButton = {
        let button =  CustomButton(placeHolder: "Reset Password")
        button.setHeight(height: 50)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).withAlphaComponent(0.5)
        button.setTitleColor(UIColor(white: 1, alpha: 0.2), for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
        return button
    }()
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setNavigationBar()
        setUpViews()
        
    }
    
    //MARK: FUNCTION
    
    private func setUpViews (){
        view.addSubview(backButton)
        backButton.anchor(top : view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, paddingTop: 10, paddingLeft: 10)
        backButton.setDimension(width: 40, height: 40)
        
        let stackView  =  UIStackView(arrangedSubviews: [imageViewLogo, emailTxtField, resetButton])
        //stackView.alignment = .fill
        //stackView.backgroundColor = .black
        stackView.axis = .vertical
        stackView.spacing =  20
        view.addSubview(stackView)
        stackView.anchor(top: backButton.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 120, paddingLeft: 32, paddingRight: 32)
        emailTxtField.addTarget(self, action: #selector(addTxtFieldObservers), for: .editingChanged)
        
    }
    
    //MARK: API
    
  
    
    //MARK: OBSERVER
    @objc private func addTxtFieldObservers (){
        emailTxtField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
 
    }
    
    //MARK: NAVIGATION CONTROLLER
    
    private func setNavigationBar(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    
    
    
    
    
    //MARK: HELPER FUNCTION
    
    @objc func resetPassword (){
        print("Reset password ")
        guard let email  = emailTxtField.text else {return}
        self.show(true)
        AuthService.resetPassword(email: email) { (error) in
            self.show(false)
            if let error = error{
                print("Error in resetting the password")
                self.showMessage(title: "Message", message: "Fail ")
                return
            }
            self.delegate?.sendResetPasswordLink(self)
            
        }
    }
    
    @objc func handleBackButton(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange(_ sender : UITextField){
        if sender == emailTxtField{
            resetViewModel.email =  sender.text
        }
        
        resetButton.backgroundColor =  resetViewModel.backgroundBtnColor
        resetButton.setTitleColor(resetViewModel.textBtnColor, for: .normal)
        resetButton.isEnabled =  resetViewModel.formIsValid
    }
}
