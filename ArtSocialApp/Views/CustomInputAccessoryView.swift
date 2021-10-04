//
//  CustomAccessoryComment.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 03/10/2021.
//

import Foundation
import UIKit


class CustomInputAccessoryView : UIView{
    
    
    
    
    //MARK: PROPRIETIES
    weak var delegateAccesory : CustomInputAccessoryViewDelegate?
    
    let customTextView  : CustomTextView = {
       let view  =  CustomTextView()
        view.placeholder.text = "Enter comment"
        view.isScrollEnabled = true
        view.placeHolderShouldCenter = true
        return view
    }()
    
    lazy var submitCommnetBtn  : UIButton =  {
        let btn  =  UIButton (type: .system)
        btn.setTitle("SEND", for: .normal)
        btn.setTitleColor(UIColor.systemBlue, for: .normal)
        btn.addTarget(self, action: #selector(handlePostComment), for: .touchUpInside)
        return btn
        
    }()
    
    //MARK: INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: FUCTION
    
    private func setUpView(){
        backgroundColor = .white
        autoresizingMask =  .flexibleHeight
        addSubview(submitCommnetBtn)
        submitCommnetBtn.anchor(top: topAnchor, trailing: trailingAnchor, paddingRight: 8)
        submitCommnetBtn.setDimension(width: 50, height: 50)
        addSubview(customTextView)
        //customTextView.backgroundColor = .red
        customTextView.anchor(top:topAnchor, leading: leadingAnchor, trailing: submitCommnetBtn.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8, paddingBottom: 8)
        customTextView.setHeight(height: 50)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray
        addSubview(divider)
        divider.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        divider.setHeight(height: 0.5)
    }
    
    
    override var intrinsicContentSize: CGSize{
        return .zero
    }
    //MARK: ACTION
    @objc func handlePostComment(){
        guard let comment =  customTextView.text else {return}
        delegateAccesory?.postNewCommment(self, comment: comment)
    }
    
    
    //MARK: HELPER FUNCTION
    
    func clearTextView (){
        customTextView.text = nil
        customTextView.placeholder.isHidden = false
    }
    
    
}
