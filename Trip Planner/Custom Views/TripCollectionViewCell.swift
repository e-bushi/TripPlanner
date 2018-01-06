//
//  TripCollectionViewCell.swift
//  Trip Planner
//
//  Created by Chris Mauldin on 1/4/18.
//  Copyright © 2018 Chris Mauldin. All rights reserved.
//

import UIKit
import WebKit

class TripCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var didAttendLabel: UILabel!
    @IBOutlet weak var attendeesLabel: UILabel!
    
    @IBOutlet weak var destinationImage: WKWebView!
    
    var trip: Trip? {
        didSet {
            let request = URLRequest(url: (trip?.thumbnail)!)
            locationLabel.text = trip!.destination
            didAttendLabel.text = String(describing: trip!.didAttend)
            attendeesLabel.text = String(describing: trip!.attendees)
            
            destinationImage.load(request)
        }
    }
    
}
