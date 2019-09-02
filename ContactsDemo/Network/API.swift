//
//  API.swift
//  ContactsDemo
//
//  Created by Apple on 01/09/19.
//  Copyright © 2019 Abhilash. All rights reserved.
//

import Foundation
import Alamofire

class API {
    static let baseUrl = "http://gojek-contacts-app.herokuapp.com"
    enum Endpoints {
        case fetchContacts
        case saveContact(Parameters)
        case updateContact(Parameters)
        case showContact(Parameters)
        
        var method: HTTPMethod {
            switch self {
            case .fetchContacts, .showContact:
                return .get
            case .saveContact:
                return .post
            case .updateContact:
                return .put
            }
        }
        
        var path: URLConvertible {
            switch self {
            case .fetchContacts, .saveContact:
                return baseUrl + "/contacts.json"
            case .showContact(let keywords), .updateContact(let keywords):
                let id = (keywords["id"] as? String) ?? ""
                return baseUrl + "/contacts/\(id).json"
            }
        }
        
        var parameters: Parameters {
            var parameters = Parameters()
            switch self {
            case .fetchContacts, .showContact:
                return [:]
            case .saveContact(let keywords), .updateContact(let keywords):
                for(key,value) in keywords {
                    parameters[key] = value
                }
            }
            return parameters
        }
        
        var headers:[String:String]{
            var headers = [String:String]()
            headers["Content-Type"] = "application/json"
            return headers
        }
    }
    
    static func request(endpoint: API.Endpoints,completionHandler:  ((_ result: Data?, _ error: Error?) -> ())?) {
        Alamofire.request(endpoint.path,method: endpoint.method, parameters: endpoint.parameters, headers: endpoint.headers).responseJSON { response in
            if let data = response.data {
                if let block = completionHandler {
                    block(data, nil)
                }
            }
            else {
                if let block = completionHandler {
                    block(nil, response.result.error)
                }
            }
        }
    }
    
    static func requestPOST(endpoint: API.Endpoints,completionHandler:  ((_ result: Data?, _ error: Error?) -> ())?) {
        Alamofire.request(endpoint.path, method: endpoint.method, parameters: endpoint.parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if let data = response.data {
                if let block = completionHandler {
                    block(data, nil)
                }
            }
            else {
                if let block = completionHandler {
                    block(nil, response.result.error)
                }
            }
        }
    }
}
