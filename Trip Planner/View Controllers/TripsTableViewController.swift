//
//  TripsTableViewController.swift
//  Trip Planner
//
//  Created by Chris Mauldin on 1/5/18.
//  Copyright © 2018 Chris Mauldin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "tripCell"

class TripsTableViewController: UITableViewController {
    
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 100

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        setUpTripValues()
        
        tripsNetwork.get(trip: trip, resource: .trips) { (fetchedTrips) in
            DispatchQueue.main.async {
                self.list = fetchedTrips
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    
    func setUpTripValues() {
        trip.creator = username
        trip.didAttend = attendance!
    }

    

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TripTableViewCell
        
        cell.trip = list[indexPath.row]
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
