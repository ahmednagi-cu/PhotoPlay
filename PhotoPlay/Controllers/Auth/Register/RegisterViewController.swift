//
//  RegisterViewController.swift
//  PhotoPlay
//
//  Created by ahmed nagi on 06/10/2022.
// 

import UIKit
//import Firebase
class RegisterViewController: UIViewController {
// MARK: - properties

    @IBOutlet weak var userImg: UIImageView!{
        didSet {
            userImg.layer.cornerRadius = userImg.frame.height / 2
        }
    }
    
    @IBOutlet weak var fNameTxtField: UITextField! {
        didSet {
            fNameTxtField.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var lNameTxtField: UITextField!{
        didSet {
            lNameTxtField.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var emailTxtField: UITextField!{
        didSet {
            emailTxtField.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var passwordTxtField: UITextField!{
        didSet {
            passwordTxtField.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var confirmPasswordTxtField: UITextField!{
        didSet {
            confirmPasswordTxtField.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var registerBtn: UIButton!{
        didSet {
            registerBtn.layer.cornerRadius = 15
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        imageGesture()
        
    }

// MARK: - Actions
    
    @IBAction func registerbtnAction(_ sender: UIButton) {
               fNameTxtField.resignFirstResponder()
               lNameTxtField.resignFirstResponder()
               emailTxtField.resignFirstResponder()
               passwordTxtField.resignFirstResponder()
               confirmPasswordTxtField.resignFirstResponder()
        
        guard  let firstName = fNameTxtField.text,
               let lastName = lNameTxtField.text,
               let email = emailTxtField.text,
               let password = passwordTxtField.text,
               let confirmpassword = confirmPasswordTxtField.text,
               !firstName.isEmpty,
               !lastName.isEmpty,
               !email.isEmpty,
               !password.isEmpty,
               !confirmpassword.isEmpty else { return }
        if passwordTxtField.text! == confirmPasswordTxtField.text {
          //  register(email: email, password: password)
        }
    }
    
// MARK: - Helper Functions
    
 
    /// Register func
//    private func register(email: String, password: String){
//        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
//            guard let result = result else { return }
//            if error != nil {
//                print(error!.localizedDescription)
//                return
//            }
//            
//            print(result.user.uid)
//            print("DEBUG : register is Success...")
//        }
//    }
   
    
    
    
    
    
    // end database
    
// tap image gesture
    func imageGesture(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChange))
        userImg.addGestureRecognizer(gesture)
        userImg.isUserInteractionEnabled = true
    }
    
    
//MARK:  Selector
        @objc func didTapChange(){
            presentPhotoActionSheet()
        }
}

// image
extension RegisterViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile picture", message: "Select a picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Chose photo", style: .default, handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
       
    }
    
    func presentCamera(){
         let vc = UIImagePickerController()
         vc.sourceType = .camera
         vc.delegate = self
         vc.allowsEditing = true
         present(vc, animated: true, completion: nil)
    }
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        self.userImg.image = selectedImage.circleMasked
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
