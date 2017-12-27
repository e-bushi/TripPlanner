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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        registerAccount.layer.cornerRadius = registerAccount.frame.size.height / 2
        registerAccount.layer.masksToBounds = true
    }

    
    



}
