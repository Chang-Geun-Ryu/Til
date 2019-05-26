//
//  SignUpVC.swift
//  MyInstargram
//
//  Created by CHANGGUEN YU on 13/05/2019.
//  Copyright © 2019 유창근. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  var imageSelected = false
  
  let plusPhotoBtn: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "plus_photo")?.withRenderingMode(.alwaysOriginal), for: .normal)
    button.addTarget(self, action: #selector(handleSelectProfilePhoto), for: .touchUpInside)
    return button
  }()
  
  let emailTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Email"
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = UIFont.systemFont(ofSize: 14)
    tf.addTarget(self, action: #selector(formValidaction), for: .editingChanged)
    return tf
  }()
  
  let passwordTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Password"
    tf.isSecureTextEntry = true
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = UIFont.systemFont(ofSize: 14)
    tf.addTarget(self, action: #selector(formValidaction), for: .editingChanged)
    return tf
  }()
  let fullNameTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Full Name"
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = UIFont.systemFont(ofSize: 14)
    tf.addTarget(self, action: #selector(formValidaction), for: .editingChanged)
    return tf
  }()
  
  let UserNameTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "UserName"
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = UIFont.systemFont(ofSize: 14)
    tf.addTarget(self, action: #selector(formValidaction), for: .editingChanged)
    return tf
  }()
  
  let signUpButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Sign Up", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
    button.layer.cornerRadius = 5
    button.isEnabled = false
    button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    return button
  }()
  
  let alreadydontHaveAccountButton: UIButton = {
    let button = UIButton(type: .system)
    let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ",
                                                    attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray] )
    attributedTitle.append(NSAttributedString(string: "Sign In",
                                              attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    view.addSubview(plusPhotoBtn)
    plusPhotoBtn.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
    plusPhotoBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    configureViewComponents()
    
    view.addSubview(alreadydontHaveAccountButton)
    alreadydontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
   
    guard let profileImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
      imageSelected = false
      return
    }
    
    // set imageselected
    imageSelected = true
    
    // configure plusPhotoBtn with selected image
    plusPhotoBtn.layer.cornerRadius = plusPhotoBtn.frame.width / 2
    plusPhotoBtn.layer.masksToBounds = true
    plusPhotoBtn.layer.borderColor = UIColor.black.cgColor
    plusPhotoBtn.layer.borderWidth = 2
    plusPhotoBtn.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
    
    self.dismiss(animated: true)
  }
  
  @objc func handleSelectProfilePhoto() {
    
    // configure image picker
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    
    // present image picker
    self.present(imagePicker, animated: true)
    
  }
  
  @objc func handleShowLogin() {
    _ = navigationController?.popViewController(animated: true)
  }
  
  @objc func handleSignUp() {
    
    // properties
    guard let email = emailTextField.text else { return }
    guard let password = passwordTextField.text else { return }
    guard let fullName = fullNameTextField.text else { return }
    guard let userName = UserNameTextField.text else { return }
    
    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
      // handle error
      if let error = error {
        print("Failed to create user with error: ", error.localizedDescription)
        return
      }
      
      // set profile image
      guard let profileImg = self.plusPhotoBtn.imageView?.image else { return }
      
      // success
      guard let uploadData = profileImg.jpegData(compressionQuality: 0.3) else { return }
      
      let fileName = NSUUID().uuidString
      let storageRef = Storage.storage().reference().child("profile_images").child(fileName)
      
      storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
        // handle error
        if let error = error {
          print("Failed to upload image to Firebase Storage with error: ", error.localizedDescription)
        }
        
        // UPDATE: - Firebase 5 must retrieve download url
        storageRef.downloadURL(completion: { (downloadURL, error) in
          guard let profileImageURL = downloadURL?.absoluteString else {
            print("DEBUG: Profile image url is nil")
            return
          }
          
          let dictionaryValues = ["name": fullName,
                                  "username": userName,
                                  "profileImageUrl": profileImageURL]
          
          let values []
          
          // save user info to database
          Database.database().reference().child("users").updateChildValues(dictionaryValues, withCompletionBlock: { (error, ref) in
            
          })
          
        })
      })
    }
  }
  
  @objc func formValidaction() {
    guard emailTextField.hasText,
      passwordTextField.hasText,
      fullNameTextField.hasText,
      UserNameTextField.hasText,
      imageSelected == true
      else {
      signUpButton.isEnabled = false
      signUpButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
      return
    }
    
    signUpButton.isEnabled = true
    signUpButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
    
  }
  
  func configureViewComponents() {
    let stackView = UIStackView(arrangedSubviews: [emailTextField, fullNameTextField, UserNameTextField, passwordTextField, signUpButton])
    
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.distribution = .fillEqually
    
    view.addSubview(stackView)
    stackView.anchor(top: plusPhotoBtn.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 240)
  }
  
}
