//
//  TripsCollectionViewController.swift
//  Trip Planner
//
//  Created by Chris Mauldin on 12/28/17.
//  Copyright © 2017 Chris Mauldin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "trip"

class TripsCollectionViewController: UICollectionViewController {
    
    //HOLDS THE NAME OF USER
    var username: String!
    
    
    //SETUP TRIPS NETWORK
    var tripsNetwork = TripsNetworking()
    
    //TRIP RESOURCE
    var trip = Trip(creators: "", attended: false)
    
    //TRIP ATTENDANCE
    var attendance: Bool?
    
    //HOLDS LIST OF TRIPS
    var list = [Trip]()
    
    //VISUAL EFFECT
    @IBOutlet weak var visualEffectOne: UIVisualEffectView!
    
    var effect: UIVisualEffect!
    
    //POP UP TO INFORM USER THAT THERE ISNT ANY PAST TRIPS
    @IBOutlet var noTripsPopUp: UIView!
    
    
    
    @IBOutlet var tripCollection: UICollectionView!
    
    var backgroundColor = UIColor(red: 145/255, green: 165/255, blue: 245/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tripCollection.dataSource = self
        tripCollection.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(TripCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        tripCollection.backgroundColor = backgroundColor
        
        //SET INTIAL TRIP VALUES
        setUpTripValues()
        
        
        
        tripsNetwork.get(trip: trip, resource: .trips) { (fetchedTrips) in
            DispatchQueue.main.async {
                print(fetchedTrips)
                
                self.list = fetchedTrips
                self.tripCollection.reloadData()
            }
        }
        
        //ANIMATES POP UP IF LIST EQUALS ZERO
//        noTripsAnimation()
        
        
        
        
    }

    func setUpTripValues() {
        trip.creator = username
        trip.didAttend = attendance!
        
    }
    
    func noTripsAnimation() {
        if list.count == 0 {
            self.view.bringSubview(toFront: visualEffectOne)
            
            visualEffectOne.contentView.addSubview(noTripsPopUp)
            
            noTripsPopUp.center.x = visualEffectOne.contentView.center.x
            
            noTripsPopUp.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            noTripsPopUp.alpha = 0
            
            UIView.animate(withDuration: 0.5, animations: {
                self.visualEffectOne.effect = self.effect
                
                self.noTripsPopUp.alpha = 1
                self.noTripsPopUp.transform = .identity
            })
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return list.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TripCollectionViewCell
    
        // Configure the cell
        cell.trip = list[indexPath.row]
        
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
