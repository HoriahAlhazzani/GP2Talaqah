//
//  ViewController.swift
//  LoginExample
//
//  Created by Gary Tokman on 3/10/19.
//  Copyright © 2019 Gary Tokman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class LoginViewController: UIViewController {
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var resetTextField: UITextField!
    @IBOutlet weak var regEmail: UITextField!
    @IBOutlet weak var regPassword: UITextField!
    var validation = Validation()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
 



    }
      @IBAction func loginF(_ sender: Any) {
        
        guard
//            let name = validateNameTxtFld.text,
            let email = emailTextField.text,
            let password = passwordTextField.text
        //,
//        let phone = validatePhoneTxtFld.text
            else {
           return
            }
//               let isValidateName = self.validation.validateName(name: name)
//               if (isValidateName == false) {
//                  print("Incorrect Name")
//                  return
//               }
               let isValidateEmail = self.validation.validateEmailId(emailID: email)
               if (isValidateEmail == false) {
                  print("Incorrect Email")
                self.showToast(message: "Incorrect Email", font: UIFont(name: "Times New Roman", size: 12.0)!)
                emailTextField.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)

                  return
               }
               let isValidatePass = self.validation.validatePassword(password: password)
               if (isValidatePass == false) {
                  print("Incorrect Pass")
                self.showToast(message: "Incorrect password", font: UIFont(name: "Times New Roman", size: 12.0)!)
                passwordTextField.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)

                  return
               }
//               let isValidatePhone = self.validation.validaPhoneNumber(phoneNumber: phone)
//               if (isValidatePhone == false) {
//                  print("Incorrect Phone")
//                  return
//               }
//               if (isValidateName == true || isValidateEmail == true || isValidatePass == true || isValidatePhone == true) {
//                  print("All fields are correct")
        if (isValidateEmail == true || isValidatePass == true ) {
                       print("All fields are correct")
               }
            
        
        // Signing in the user
        Auth.auth().signIn(withEmail: self.emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if user != nil {
                // Couldn't sign in
//                self.errorLabel.text = error!.localizedDescription
//                self.errorLabel.alpha = 1
                print("user has signed in")
                self.performSegue(withIdentifier: "toHome", sender: nil)
            }
            else {
                if error != nil{
              print("Hmmm...")
                    
                }
        }
        
        }
    }
    
    
   
    @IBAction func signOut(_ sender: Any) {
      
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
             print ("signing out DONE")
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
 
    
}

