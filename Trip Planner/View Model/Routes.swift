//
//  Routes.swift
//  Trip Planner
//
//  Created by Chris Mauldin on 12/25/17.
//  Copyright © 2017 Chris Mauldin. All rights reserved.
//

import Foundation

extension String {
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}


enum Crud: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
}

enum Resource {
    case user
    case trips
    
    
    
    func method() -> (String, String, String) {
        switch self {
        case .user:
            return (Crud.get.rawValue, Crud.post.rawValue, Crud.put.rawValue)
            
        case .trips:
            return (Crud.get.rawValue, Crud.post.rawValue, Crud.patch.rawValue)
        }
    }
    
    func urlPath() -> String {
        switch self {
        case .user:
            return "/users"
        
        case .trips:
            return "/trips"
        }
    }
    
    //WHEN LOGGING IN, THIS METHODS CREATES HEADER FIELD TO SEND CREDENTIALS (used in conjuction with user GET request)
    func userAuthenticationHeaders(username: String, password: String) -> [String: String] {
        let creden = "\(username):\(password)".toBase64()
        let base64encoded = String(creden)
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Basic \(base64encoded)"
        ]
        return headers
    }
    
    //WHEN SIGNING UP, THIS METHOD RETURNS A GENERIC DICTIONARY FOR THE HTTP BODY FIELD
    func userHttpBody(user: User) -> [String: Any] {
        let body = [
            "username": user.username,
            "password": user.password
        ]
        
        return body
    }
    
    func userPostHeaderField() -> [String : String] {
        let header = ["Content-Type": "application/json"]
        return header
    }
    
    //WHEN USER CREATES(POST) A TRIP, THIS METHOD CREATES THE HTTP BODY FIELD
    func tripPostBody(trip: Trip) -> [String: Any] {
        let body = ["trip_destination": trip.destination,
                    "location": trip.location,
                    "price_roundtrip": trip.price,
                    "image_url": trip.thumbnail,
                    "trip_creator": trip.creator,
                    "trip_attendees": trip.attendees,
                    "did_attend": trip.didAttend] as [String : Any]
        
        return body
    }
    
    
    //WHEN USER WANTS TO MODIFY THEIR TRIP, THIS METHOD CREATES HTTP FIELD WITH UPDATED VALUE TO BE SUBMITTED (Only the attendees and didAttend field can be moddified)
    func tripPatchBody(trip: Trip) -> [String: Any] {
        let body = ["trip_destination": trip.destination,
                    "trip_creator": trip.creator,
                    "trip_attendees": trip.attendees,
                    "did_attend": trip.didAttend] as [String : Any]
        
        return body
    }
    
    
    //WHEN GENERATING THE USER TRIPS TO THE COLLECTION VIEW THIS METHOD WILL BE USED TO POPULATE IT BY GENERATING THE HEADER FIELD
    func tripGetHeaderField(trip: Trip) -> [String: String] {
        let header = ["Content_type": "application/json",
                      "trip_creator": trip.creator,
                      "did_attend": "\(trip.didAttend)"
            ]
        
        return header
    }
    
    
}

