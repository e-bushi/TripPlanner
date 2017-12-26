//
//  ViewController.swift
//  Trip Planner
//
//  Created by Chris Mauldin on 12/21/17.
//  Copyright © 2017 Chris Mauldin. All rights reserved.
//

import UIKit
import TextFieldEffects

class ViewController: UIViewController {

    
    
    @IBOutlet weak var logInButton: CustomButton!
    
    @IBOutlet weak var lineContainerOne: UIView!
    @IBOutlet weak var lineContainerTwo: UIView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let firstLine = UIImageView(image: #imageLiteral(resourceName: "Line"))
        lineContainerOne.mask = firstLine
        
        let secondLine = UIImageView(image: #imageLiteral(resourceName: "Line"))
        lineContainerTwo.mask = secondLine
        
    }

    
    @IBAction func initiateAuthentication(_ sender: Any) {
        var username = self.usernameTextField.text
        var password = self.passwordTextField.text
        
        
        
    }
    

}

