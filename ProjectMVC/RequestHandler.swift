//
//  RequestHandler.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/9/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import Foundation
import Alamofire


enum RequestHandler: URLRequestConvertible {
    
    //MARK:- Helping Method
    
 
    
    case get(url:String)
    case post(parmeters:[String:Any],url:String)
    
    // MARK: - HTTPMethod
    
    var method: HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        }
        
    }
    
    // MARK: - Path
    
    var path: String {
        switch self {
        case .get(let url):
            return url
            
        case .post( _, let url):
            return url
        }
    }
    
    // MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {

        let url = URL(string: ApiURLs.domain)!
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        
        switch self {
            
        case .get(url: _):

            
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
            return urlRequest


        case .post(let parmeters, _):
            
            urlRequest.httpMethod = "POST"
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parmeters)
            

            return urlRequest
            
            
        }
        
        
    
    }
    
    
}
