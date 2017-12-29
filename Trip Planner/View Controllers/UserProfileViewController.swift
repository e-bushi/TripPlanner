//
//  UserProfileViewController.swift
//  Trip Planner
//
//  Created by Chris Mauldin on 12/26/17.
//  Copyright © 2017 Chris Mauldin. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    
    @IBOutlet weak var confirmationLabel: UILabel!
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    
    
    
    var labelval: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        profileImage.layer.masksToBounds = true
        
        
        confirmationLabel.text = labelval
    }
    
    
    
    


}
