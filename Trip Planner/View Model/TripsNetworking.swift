//
//  TripsNetworking.swift
//  Trip Planner
//
//  Created by Chris Mauldin on 12/25/17.
//  Copyright © 2017 Chris Mauldin. All rights reserved.
//

import Foundation


class TripsNetworking {
    
    //OPTIONAL TO HOLD STATUS CODES
    var status: Int?
    
    //OPTIONAL TO STORE USERS
    var user: Data?
    
    //SET UP SESSION
    let session = URLSession.shared
    
    //BASE URL PATH TO TRIPS RESOURCES
    let baseURL = URL(string: "https://trip-planner-cm.herokuapp.com")
    
    func post(trip: Trip, resource: Resource, completion: @escaping (Trip)->()) {
        //SET UP EXTENDED PATH
        let fullURL = baseURL?.appendingPathComponent(resource.urlPath())
        
        //SET UP REQUEST
        var request = URLRequest(url: fullURL!)
        
        //CREATE HTTPBODY FIELD THAT HOLDS NEW TRIP POST
        let body = resource.tripPostBody(trip: trip)
        
        //JSONIFY BODY
        let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        //ADD JSONBODY TO HTTPBODY FIELD IN REQUEST
        request.httpBody = jsonBody!
        
        //INITIATE TASK
        let task = session.dataTask(with: request) { (data, response, _) in
            guard let code = (response as? HTTPURLResponse) else {return}
            self.status = code.statusCode
            
            guard let postedUser = data else {return}
            self.user = postedUser
        }
        
        task.resume()
    }
    
    func get(trip: Trip, resource: Resource, completion: @escaping (Trip)->()) {
        //SET UP EXTENDED PATH
        let fullURL = baseURL?.appendingPathComponent(resource.urlPath())
        
        //SET UP REQUEST
        var request = URLRequest(url: fullURL!)
        
        //ADD HEADER TO REQUEST
        request.allHTTPHeaderFields = resource.tripGetHeaderField(trip: trip)
        
        //INITIATE TASK
        let task = session.dataTask(with: request) { (data, _, _) in
            guard let fetchedUser = data else {return}
            self.user = fetchedUser
        }
        
        task.resume()
    }
}