//
//  Users.swift
//  Trip Planner
//
//  Created by Chris Mauldin on 12/25/17.
//  Copyright © 2017 Chris Mauldin. All rights reserved.
//

import Foundation


struct User {
    var id: String
    var username: String
    var password: String
}

extension User: Codable {
    enum UserKeys: String, CodingKey {
        case id = "_id"
        case username
        case password
    }
    
    enum IdKeys: String, CodingKey {
        case oid = "$oid"
    }
    
    enum PasswordKeys: String, CodingKey {
        case binary = "$binary"
    }
    
    init(from decoder: Decoder) throws {
        
        //key the top level container
        let userContainer = try? decoder.container(keyedBy: UserKeys.self)
        
        //Get username
        let usr = try? userContainer?.decode(String.self, forKey: .username)
        
        
        //Create Id Container and extract id value
        let idContainer = try? userContainer!.nestedContainer(keyedBy: IdKeys.self, forKey: .id)
        let id_ = try? idContainer?.decode(String.self, forKey: .oid)
        
        
        //Create Password Container and extract value
        let passwordContainer = try? userContainer!.nestedContainer(keyedBy: PasswordKeys.self, forKey: .password)
        let passw = try? passwordContainer?.decode(String.self, forKey: .binary)
        
        
        self.init(id: id_!!, username: usr!!, password: passw!!)
    }
    
    func encode(to encoder: Encoder) {
        var userContainer = encoder.container(keyedBy: UserKeys.self)
        
        try? userContainer.encode(username, forKey: .username)
        
        var idContainer = userContainer.nestedContainer(keyedBy: IdKeys.self, forKey: .id)
        try? idContainer.encode(id.self, forKey: .oid)
        
        try? userContainer.encode(password, forKey: .password)
    }
}

