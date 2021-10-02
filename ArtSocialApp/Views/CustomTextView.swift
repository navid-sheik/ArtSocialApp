//
//  CustomTextView.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 30/09/2021.
//

import Foundation
import UIKit

class CustomTextView : UITextView{
    
    var captionPlaceHolderText : String? {
        didSet{
            placeholder.text =  captionPlaceHolderText
            
        }
    }
    
    var placeholder :  UILabel =  {
        let label  = UILabel()
        label.textColor =  .lightGray
//        label.font =  UIFont.systemFont(ofSize: 16)
//        label.numberOfLines  = 2
        return label
    }()
    
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
