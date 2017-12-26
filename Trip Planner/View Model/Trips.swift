//
//  Trips.swift
//  Trip Planner
//
//  Created by Chris Mauldin on 12/25/17.
//  Copyright © 2017 Chris Mauldin. All rights reserved.
//

import Foundation


struct Trip: Codable {
    var id: String
    var destination: String
    var location: Array<Double>
    var price: Int
    var thumbnail: URL
    var creator: String
    var attendees: Array<String>
    var didAttend: Bool
}

extension Trip {
    
    enum TripKeys: String, CodingKey {
        case id = "_id"
        case destination = "trip_destination"
        case location
        case price = "price_roundtrip"
        case thumbnail = "image_url"
        case creator = "trip_creator"
        case attendees = "trip_attendees"
        case didAttend = "did_attend"
    }
    
    enum IdKeys: String, CodingKey {
        case oid = "$oid"
    }
    
    
    init(from decoder: Decoder) throws {
        
        //key the top level container
        let tripContainer = try? decoder.container(keyedBy: TripKeys.self)
        
        //retrieve destination
        let destin = try? tripContainer?.decode(String.self, forKey: .destination)
        
        //retrieve id
        let idContainer = try! tripContainer?.nestedContainer(keyedBy: IdKeys.self, forKey: .id)
        let ID = try? idContainer?.decode(String.self, forKey: .oid)
        
        
        //retrieve location
        let locat = try! tripContainer?.decode(Array<Double>.self, forKey: .location)
        
        //retrive price
        let price = try! tripContainer?.decode(Int.self, forKey: .price)
        
        //retrieve thumbnail image
        let image = try! tripContainer?.decode(URL.self, forKey: .thumbnail)
        
        //retrieve creator of trip
        let creator = try! tripContainer?.decode(String.self, forKey: .creator)
        
        //retrieve attendees of trip
        let attendees = try! tripContainer?.decode(Array<String>.self, forKey: .attendees)
        
        //retrieve creator attendance info
        let didAttend = try! tripContainer?.decode(Bool.self, forKey: .didAttend)
        
        self.init(id: ID!!, destination: destin!!, location: locat!, price: price!, thumbnail: image!, creator: creator!, attendees: attendees!, didAttend: didAttend!)
    }
    
    
    func encode(to encoder: Encoder) {
        //container
        var tripContainer = encoder.container(keyedBy: TripKeys.self)
        
        //encode destination
        try? tripContainer.encode(destination, forKey: .destination)
        
        //create id container to encode from
        var idContainer = tripContainer.nestedContainer(keyedBy: IdKeys.self, forKey: .id)
        
        //encode oid
        try? idContainer.encode(id, forKey: .oid)
        
        //encode location
        try? tripContainer.encode(location, forKey: .location )
        
        //encode price
        try? tripContainer.encode(price, forKey: .price)
        
        //encode image
        try? tripContainer.encode(thumbnail, forKey: .thumbnail)
        
        //encode creator of trip
        try? tripContainer.encode(creator, forKey: .creator)
        
        //encode attendees
        try? tripContainer.encode(attendees, forKey: .attendees)
        
        //encode creator attendance
        try? tripContainer.encode(didAttend, forKey: .didAttend)
    }
    
}
