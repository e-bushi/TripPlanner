//
//  LogInViewController.swift
//  Trip Planner
//
//  Created by Chris Mauldin on 12/26/17.
//  Copyright © 2017 Chris Mauldin. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    
    
    @IBOutlet weak var logInButton: CustomButton!
    
    @IBOutlet weak var lineContainerOne: UIView!
    @IBOutlet weak var lineContainerTwo: UIView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //HOLDS USER INFO
    var credentials: (String, String)?
    
    //ESTABLISH USER NETWORK
    var network = UsersNetworking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let firstLine = UIImageView(image: #imageLiteral(resourceName: "Line"))
        lineContainerOne.mask = firstLine
        
        let secondLine = UIImageView(image: #imageLiteral(resourceName: "Line"))
        lineContainerTwo.mask = secondLine
        
        //ASSIGN DELEGATES
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        logInButton.layer.cornerRadius = logInButton.frame.size.height / 2
        logInButton.layer.masksToBounds = true
        
    }
    
    @IBAction func initiateAuthentication(_ sender: Any) {
        credentials = retrieveUserCredentials()
        let user = User(id: "", username: credentials!.0, password: credentials!.1)
        
        self.network.authentication(user: user, resource: .user) {(code) in
            if code.statusCode == 200 {
                
                self.performSegue(withIdentifier: "loggedIn", sender: self)
                
            } else {
                print(code)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loggedIn" {
            let userProVC = segue.destination as! UserProfileViewController
            userProVC.usernamelabelval = credentials!.0
        }
    }

}


extension LogInViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func retrieveUserCredentials() -> (String, String) {
        let credentials = ("\(usernameTextField.text!)", "\(passwordTextField.text!)")
        
        return credentials
    }
    
    
    
    
    func usernameEmpty(){}
    
    func paswordIsEmpty(){}
    
    func isPasswordSatifiable() -> Bool {
        let pass = passwordTextField.text!
        
        if pass.count < 6 {
            return false
        }
        
        return true
    }
    
    
    
    
}





