//
//  RegisterViewController.swift
//  Login
//
//  Created by Haneen Abdullah on 12/02/2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterController: UIViewController {
     
        var validation = Validation()
        
        
        
    //    @IBOutlet weak var registerView: UIView!
        
     
                
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var nIDTextField: UITextField!

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
        
    //    @IBOutlet weak var genderSegmented: UISegmentedControl!
        
       
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var registerButton: UIButton!
    
    
    @IBAction func genderSegmented(_ sender: Any) {
   //        let getIndex = genderSegmented.selectedSegmentIndex
      //        print(getIndex)
        
    }
    
        
        override func viewDidLoad() {
            super.viewDidLoad()

              // Do any additional setup after loading the view.
                          setUpElements()
        }
                
            override func awakeFromNib() {
                self.view.layoutIfNeeded()

            }

         
            
                func setUpElements() {
                
                    // Hide the error label
                    errorLabel.alpha = 0
                
                    // Style the elements
                    Utilities.styleTextField(textfield: firstNameTextField)
                     Utilities.styleTextField(textfield: lastNameTextField)
                     Utilities.styleTextField(textfield: nIDTextField)
                    Utilities.styleTextField(textfield: emailTextField)
                    Utilities.styleTextField(textfield: phoneNumberTextField)
                    Utilities.styleTextField(textfield: passwordTextField)
                    Utilities.styleTextField(textfield: confirmPasswordTextField)
                    Utilities.styleFilledButton(button: registerButton)
            
                    //todo set up genderSegmented Style
            
                    }
                
                // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
                func validateFields() -> String? {
                    
                    // Get text input from TextField
                                        guard
                              let password=passwordTextField.text
                            
                    else {
                                  return nil}
                    
                      let confirmPassword = confirmPasswordTextField.text
                    
                           // Check that all fields are filled in
                           if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                               lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                            nIDTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                            phoneNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                               passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                               confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                               
                               return "Please fill in all fields."
                           }
                    
                    
              
               // Check if the password is secure
                    let isValidatePass = self.validation.validatePassword( password: password)
                let isMatchedPass=(password==confirmPassword)
                     
                    
                   if isValidatePass == false {
                                             // Password isn't secure enough
                                             return "Please make sure your password is at least 8 characters, contains a special character and a number."
                                         }
                    if isMatchedPass==false{
                        return "Please make sure your password is at least 8 characters, contains a special character and a number."

                    }
                           
                           return nil
                }
                

               
                
                func showError(_ message:String) {
                    
                    errorLabel.text = message
                    errorLabel.alpha = 1
                }
                
    //            func transitionToHome() {
    //
    //                let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
    //
    //                view.window?.rootViewController = homeViewController
    //                view.window?.makeKeyAndVisible()
    //
    //            }

        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */
    
    
    @IBAction func RegisterTapped(_ sender: Any) {
  
        // Validate the fields
                            let error = validateFields()
                            
                            if error != nil {
                                
                                // There's something wrong with the fields, show error message
                                showError(error!)
                            }
                            else {
                                
                                // Create cleaned versions of the data
                                let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                                let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                                let nID = nIDTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                                let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                                let phone = phoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                                let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                                let gender="female"
                                
                                // Create the user
                                Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                                    
                                    // Check for errors
                                    if err != nil {
                                        
                                        // There was an error creating the user
                                        self.showError("Error creating user")
                                        print("Error creating user")
                                    }
                                    else {
                                        
                                        // User was created successfully, now store the first name and last name
                                        let db = Firestore.firestore()
    //                                     db.collection("users").addDocument(data: ["NID": nID,"FirstName":firstName,"LastName":lastName,"Email":email, "PhoneNumber": phone,"Gender":gender,"uid": result!.user.uid ]) { (error) in
                                        db.collection("patients").addDocument(data: ["NID": nID, "FirstName":firstName, "LastName":lastName, "Email":email, "PhoneNumber": phone, "Gender":gender, "uid": result!.user.uid ]) { (error) in
                                            
                                            
                                            
                                            if error != nil {
                                                // Show error message
                                                self.showError("Error saving user data")
                                                print("Error saving user data")
                                            }
                                        }
                                        
                                        // Transition to the home screen
    //                                  self.transitionToHome()
                                      self.performSegue(withIdentifier: "toStart", sender: nil)
                                    }
                                    
                                }
                                
                                
                                
                            }
                        }
        
        
    @IBAction func LoginTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toLogin", sender: nil)
    }
    
        }
        



    // todo get gender input,add within user info,modify user info

