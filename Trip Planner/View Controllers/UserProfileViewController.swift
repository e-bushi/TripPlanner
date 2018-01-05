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
    var usernamelabelval: String!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    //ATTENDANCE INFORMATION TO SEND IN SEGUE
    var attendance: Bool?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        profileImage.layer.masksToBounds = true
        
        
        confirmationLabel.text = usernamelabelval
    }
    
    
    @IBAction func getPastTrips(_ sender: Any) {
        attendance = true
        
        performSegue(withIdentifier: "trips", sender: self)
        
    }
    
    
    @IBAction func getUpcomingTrips(_ sender: Any) {
        attendance = false
        
        performSegue(withIdentifier: "trips", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "trips" {
            let TripsCVC = segue.destination as! TripsCollectionViewController
            
            TripsCVC.username = confirmationLabel.text!
            
            if let didAttend = attendance {
                TripsCVC.attendance = didAttend
            }
        }
    }
    

}
