//
//  CustomTextView.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 30/09/2021.
//

import Foundation
import UIKit

class CustomTextView : UITextView{
    
    //MARK: PROPRITIES
    
    var captionPlaceHolderText : String? {
        didSet{
            placeholder.text =  captionPlaceHolderText
            
        }
    }
    
    var placeholder :  UILabel =  {
        let label  = UILabel()
        label.textColor =  .lightGray
        return label
    }()
    
    var placeHolderShouldCenter  = true{
        didSet{
            if placeHolderShouldCenter{
                placeholder.anchor(leading : leadingAnchor, trailing: trailingAnchor, paddingLeft: 8)
            }else{
                placeholder.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 5, paddingLeft: 6, paddingRight: 6)
            }
            
        }
    }
    
    
    //MARK: INIT
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configureUI()
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        addSubview(placeholder)
        placeholder.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 5, paddingLeft: 6, paddingRight: 6)
        
        
    }
    
    //MARK: ACTION
    
    @objc private func handleTextDidChange(){
        placeholder.isHidden =  !text.isEmpty
    }
    
    
    
}
