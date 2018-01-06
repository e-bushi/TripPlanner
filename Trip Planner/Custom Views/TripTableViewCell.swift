//
//  TripTableViewCell.swift
//  Trip Planner
//
//  Created by Chris Mauldin on 1/5/18.
//  Copyright © 2018 Chris Mauldin. All rights reserved.
//

import UIKit
import WebKit

class TripTableViewCell: UITableViewCell {
    
    @IBOutlet weak var destinationLabel: UILabel!
    
    
    @IBOutlet weak var destinationImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        destinationImage.layer.cornerRadius = destinationImage.frame.size.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var trip: Trip? {
        didSet {
            
            destinationLabel.text = trip?.destination
            
        }
    }

}
