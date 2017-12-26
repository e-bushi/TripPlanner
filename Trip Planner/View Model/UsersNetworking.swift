//
//  UsersNetworking.swift
//  Trip Planner
//
//  Created by Chris Mauldin on 12/25/17.
//  Copyright © 2017 Chris Mauldin. All rights reserved.
//

import Foundation

class UsersNetworking {
    
    //OPTIONAL TO HOLD STATUS CODES
    var status: Int?
    
    //OPTIONAL TO STORE USERS
    var user: Data?
    
    //INITIALIZE A SESSION
    let session = URLSession.shared
    
    //BASE URL BY WHICH ALL OTHERS BRANCH OFF
    let baseUrl = URL(string: "https://trip-planner-cm.herokuapp.com")
    
    
    func authentication(user: User,resource: Resource, completion: @escaping (User)->()) {

        //ATTAIN URL PATH TO USERS RESOURCE
        let fullUrl = baseUrl?.appendingPathComponent(resource.urlPath())
        
        //CREATE REQUEST
        var request = URLRequest(url: fullUrl!)
        
        //ADD AUTHENTICATION HEADERS
        request.allHTTPHeaderFields = resource.userAuthenticationHeaders(username: user.username, password: user.username)
        
        //INITIATE DATATASK & RETRIEVE STATUS CODE
        let task = session.dataTask(with: request) { (data, response, _) in
            guard let code = (response as? HTTPURLResponse) else {return}
            self.status = code.statusCode
        }
        
        task.resume()
    }
    
    
    
    func postUser(user: User, resource: Resource, completion: @escaping (User)->()) {
        
        //ATTAIN URL PATH TO USERS RESOURCE
        let fullUrl = baseUrl?.appendingPathComponent(resource.urlPath())
        
        //CREATE REQUEST
        var request = URLRequest(url: fullUrl!)
        
        //ADD NEW USER WITH HTTPBODY FIELD
        let body = resource.userHttpBody(user: user)
        
        //JSONIFY HTTPBODY FIELD
        let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        //ASSIGN SERIALIZED BODY TO REQUEST
        request.httpBody = jsonBody!
        
        //INITIATE DATATASK
        let task = session.dataTask(with: request) { (data, response, _) in
            guard let code = (response as? HTTPURLResponse) else {return}
            self.status = code.statusCode
            
            guard let postedUser = data else {return}
            self.user = postedUser
        }
        
        task.resume()
    }
    
    
}
