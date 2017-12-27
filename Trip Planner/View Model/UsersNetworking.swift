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
    let baseUrl = URL(string: "http://127.0.0.1:5000")
    
    
    func authentication(user: User,resource: Resource, completion: @escaping (HTTPURLResponse)->()) {

        //ATTAIN URL PATH TO USERS RESOURCE
        let fullUrl = baseUrl?.appendingPathComponent(resource.urlPath())
        
        //CREATE REQUEST
        var request = URLRequest(url: fullUrl!)
        
        //SET HTTPMETHOD AS GET
        request.httpMethod = resource.method().0
        
        //ADD AUTHENTICATION HEADERS
        request.allHTTPHeaderFields = resource.userAuthenticationHeaders(username: user.username, password: user.password)
        
        //INITIATE DATATASK & RETRIEVE STATUS CODE
        session.dataTask(with: request) { (_, response, _) in
            guard let code = (response as? HTTPURLResponse) else {return}
        
            completion(code)
            
        }.resume()
        
    }
    
    
    
    func postUser(user: User, resource: Resource, completion: @escaping (User)->()) {
        
        //ATTAIN URL PATH TO USERS RESOURCE
        let fullUrl = baseUrl?.appendingPathComponent(resource.urlPath())
        
        //CREATE REQUEST
        var request = URLRequest(url: fullUrl!)
        
        //SET HTTPMETHOD AS GET
        request.httpMethod = resource.method().1
        
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
