//
//  LoginViewController.swift
//  PhotoPlay
//
//  Created by ahmed nagi on 06/10/2022.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {
// MARK: - Properties
    
    @IBOutlet weak var emailTxtField: UITextField! {
        didSet {
            emailTxtField.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var passwordTxtField: UITextField!{
        didSet {
            passwordTxtField.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var loginBtn: UIButton!{
        didSet {
            loginBtn.layer.cornerRadius = 15
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
    }



// MARK: - Actions
    
    @IBAction func forgotBtnAction(_ sender: UIButton) {
        let vc = ForgotPasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func loginBtnAction(_ sender: UIButton) {
       // goToApp()
        guard let email = emailTxtField.text,
              let password = passwordTxtField.text,
              !email.isEmpty,
              !password.isEmpty
        else { return }
         login(email: email, password: password)
      
    }
    
    @IBAction func RegisterBtnAction(_ sender: UIButton) {
        gotoRegister()
        
       
        
    }
// MARK: - Helper functions
    func goToApp(){
        let vc = MainTabBarViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .flipHorizontal
        present(nav, animated: true, completion: nil)
    }
    
    func gotoRegister(){
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
        let backbutton = UIBarButtonItem()
        backbutton.title = ""
        backbutton.tintColor = .darkGray
        navigationController?.navigationBar.topItem?.backBarButtonItem? = backbutton
    }
    
    
    // dataBase
       /// Login func
       private func login(email: String, password: String){
           Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
               guard let result = result else { return }
               if error != nil {
                   print(error!.localizedDescription)
                   return
               }
               print(result.user.uid)
               print("DEBUG : register is Success...")
           }
       }
   

}
