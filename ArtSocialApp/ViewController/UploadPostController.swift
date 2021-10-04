//
//  UploadPostController.swift
//  ArtSocialApp
//
//  Created by Navid Sheikh on 30/09/2021.
//

import Foundation

import UIKit

class UploadPostController  : UIViewController{
    
    var user : User
    
    weak var delegateUploader  : PostUploaderDelegate?
    //MARK: PROPRIETIES
    let uploadedImageView : UIImageView =  {
        let imageView =  UIImageView()
        imageView.contentMode =  .scaleAspectFill
        imageView.image = UIImage(named: "postPlaceholder")
        return imageView
    }()
    
    private let caption : CustomTextView = {
        let captionView  = CustomTextView()
        captionView.captionPlaceHolderText = "Enter the caption here"
        captionView.placeHolderShouldCenter = false
        return captionView
    }()
    
    
    
    
    //MARK: LIFECYCLE
    init(image : UIImage, user: User) {
        self.uploadedImageView.image =  image
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setNavigationController()
    }
    
    
    //MARK: FUNCTION
    
    private func setNavigationController (){
        navigationItem.title =  "Upload Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .done, target: self, action: #selector(handleUploadPost))
    }
    
    private func configureUI (){
        view.backgroundColor = .white
        view.addSubview(uploadedImageView)
        uploadedImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0)
        uploadedImageView.setHeight(height: 250)
        view.addSubview(caption)
        caption.anchor(top: uploadedImageView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 50 , paddingLeft: 20,paddingRight: 20)
        caption.setHeight(height: 250)
        
        
    }
    
    
    
    //MARK: ACTION
    
    @objc private func handleCancel (){
        print("Cancel post")
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc private func handleUploadPost(){
        guard let imageToUpload  = uploadedImageView.image else {
            print("DEUBUG : must upload pci ")
            return
        }
        guard let captionText = caption.text else {
            print("DEBUG : caption must be full ")
            return
        }
        
        show(true)
        
        PostService.uploadPosts(username: user.userName, caption: captionText, postImage: imageToUpload) { (error) in
            self.show(false)
            if let error  = error {
                print("DEBUG : There is an error while uploading post \(error.localizedDescription)")
                return
            }
            self.delegateUploader?.didFinishUploading(self)
        }
        
       
        
    }
    
}
