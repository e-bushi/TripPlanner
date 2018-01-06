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
    
    //OPTIONAL TO STORE TRIPS
    var trips: [Trip]?
    
    //
    var trip: Data?
    
    //SET UP SESSION
    let session = URLSession.shared
    
    //BASE URL PATH TO TRIPS RESOURCES
    let baseURL = URL(string: "http://127.0.0.1:5000")
    
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
            self.trip = postedUser
        }
        
        task.resume()
    }
    
    func get(trip: Trip, resource: Resource, completion: @escaping ([Trip])->()) {
        //SET UP EXTENDED PATH
        let fullURL = baseURL?.appendingPathComponent(resource.urlPath())
        
        //SET UP REQUEST
        var request = URLRequest(url: fullURL!)
        
        //ADD HEADER TO REQUEST
        request.allHTTPHeaderFields = resource.tripGetHeaderField(trip: trip)
        
        //INITIATE TASK
        let task = session.dataTask(with: request) { (data, _, _) in
            if let fetchedTrips = data {
                let tripList = try? JSONDecoder().decode([Trip].self, from: fetchedTrips)
                
                self.trips = tripList
            }
            
            completion(self.trips!)
        }
        
        task.resume()
    }
    
    func patch(trip: Trip, resource: Resource, completion: @escaping (Trip)->()) {
        //SET UP EXTENDED PATH
        let fullURL = baseURL?.appendingPathComponent(resource.urlPath())
        
        //SET UP REQUEST
        var request = URLRequest(url: fullURL!)
        
        //CREATE HTTPBODY FIELD THAT HOLDS NEW TRIP POST
        let body = resource.tripPatchBody(trip: trip)
        
        //JSONIFY BODY
        let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        //ADD JSONBODY TO HTTPBODY FIELD IN REQUEST
        request.httpBody = jsonBody!
        
        //INITIATE TASK
        let task = session.dataTask(with: request) { (data, response, _) in
            guard let code = (response as? HTTPURLResponse) else {return}
            self.status = code.statusCode
            
            guard let patchedTrip = data else {return}
            self.trip = patchedTrip
        }
        
        task.resume()
        
    }
    
}
