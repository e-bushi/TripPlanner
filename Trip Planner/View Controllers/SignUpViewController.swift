//
//  SignUpViewController.swift
//  Trip Planner
//
//  Created by Chris Mauldin on 12/26/17.
//  Copyright © 2017 Chris Mauldin. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var registerAccount: CustomButton!
    
    //HOLDS NEW SIGNEE CREDENTIALS (username, password)
    var credentials: (String, String)?
    
    
    //INITIATE USER NETWORK
    let network = UsersNetworking()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        userNameTextField.delegate = self
        passwordTextfield.delegate = self
        
        registerAccount.layer.cornerRadius = registerAccount.frame.size.height / 2
        registerAccount.layer.masksToBounds = true
        
    }

    @IBAction func registerNewUser(_ sender: Any) {
        credentials = retrieveNewUserCredentials()
        let user = User(id: "", username: credentials!.0, password: credentials!.1)
        
        network.postUser(user: user, resource: .user) { (code) in
            if code.statusCode == 201 {
                self.performSegue(withIdentifier: "signedIn", sender: self)
            }
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signedIn" {
            let userProVC = segue.destination as! UserProfileViewController
            
            userProVC.usernamelabelval = credentials?.0
            
        }
    }
}



extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func retrieveNewUserCredentials() -> (String, String) {
        let credentials = ("\(userNameTextField.text!)", "\(passwordTextfield.text!)")
        
        return credentials
    }
    
    
    
}
