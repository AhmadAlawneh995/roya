//
//  APIHandler.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/9/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import Foundation
import Alamofire


typealias Response = DataResponse
typealias DefaultResponse = DefaultDataResponse
typealias ImageFormData = (name: String?, data: Data?)

protocol URLRequestMultipartable {
    var image: ImageFormData? { get }
}


class APIHandler {
    
    func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }

    func newJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }
    
    // to here
    
    static let sessionManager: SessionManager = {
           let trustPolicies = MyServerTrustPolicyManager(policies: [:])
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        configuration.urlCache = nil
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        let s = SessionManager(configuration: configuration, delegate: SessionDelegate(), serverTrustPolicyManager: trustPolicies)
        
        return s
    }()
    

    
    static func request<T: Decodable>(endpoint: URLRequestConvertible, onComplete: @escaping (_ response: Response<T>) -> Void){
        
        let cookieStore = HTTPCookieStorage.shared
        for cookie in cookieStore.cookies ?? [] {
            cookieStore.deleteCookie(cookie)
        }
        
        let request = APIHandler.sessionManager.request(endpoint)
        print(request.debugDescription)
        request.validate(statusCode: 200...300).responseDecodable { (response: DataResponse<T>) in
            print(response.debugDescription)
            onComplete(response)
        }
    }
    
    static func requestBoolean(endpoint: URLRequestConvertible, onSuccess: @escaping (_ response: Bool) -> Void, onFailure: @escaping (_ error: Error) -> Void) {
        
        let request =  APIHandler.sessionManager.request(endpoint)
        request.validate(statusCode: 200...300).responseString { (response) in
            
            print(response.debugDescription)
            
            switch response.result {
            case .success(let v):
                onSuccess(v == "true" ? true : false)
            case .failure(let e):
                onFailure(e)
            }
            
        }
    }

    /* Used to request Unknown response type or in empty response */
    static func requestEmpty(endpoint: URLRequestConvertible, onComplete: @escaping (_ response: DefaultResponse) -> Void){
        
        let request =  APIHandler.sessionManager.request(endpoint)
        print(request.debugDescription)
        request.validate(statusCode: 200...300).response { (response) in
            onComplete(response)
        }
        
    }
    
    static func requestString(endpoint: URLRequestConvertible, onComplete: @escaping (_ response: Response<String>) -> Void){
        
        let request =  APIHandler.sessionManager.request(endpoint)
        request.validate(statusCode: 200...300).responseString { (response) in
            
            print(response.debugDescription)
            onComplete(response)
        }
    }
    
}

extension DataRequest {
    func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            let decoder = JSONDecoder()
            if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iSO8601Full)
            }
            
            return Result { try decoder.decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
}

extension DateFormatter {
    static let iSO8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}


open class MyServerTrustPolicyManager: ServerTrustPolicyManager {

    // Override this function in order to trust any self-signed https
    open override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        return ServerTrustPolicy.disableEvaluation
    }
}
