//
//  HomeViewController.swift
//  Login
//
//  Created by Atheer Alghannam on 07/06/1441 AH.
//  Copyright © 1441 Gary Tokman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class HomeViewController: UIViewController {
@IBOutlet weak var ResetTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetPassword(_ sender: Any) {
            Auth.auth().sendPasswordReset(withEmail: self.ResetTextField.text!) { error in
                if error != nil {
               print("email is wrong")
                     self.showToast(message: "email is wrong.", font: UIFont(name: "Times New Roman", size: 12.0)!)
              } else {
                print("Password reset email sent.")
                self.showToast(message: "Password reset email sent.", font: UIFont(name: "Times New Roman", size: 12.0)!)
                // Password reset email sent.
              }
            }
    }

}
