//
//  APIRequest.swift
//  Event
//
//  Created by João Luis dos Santos on 18/07/21.
//

import Foundation

enum APIRequest {
    case events
    case checkin
}

extension APIRequest {
    
    private var baseUrl: String {
        return "http://5f5a8f24d44d640016169133.mockapi.io/api/"
    }
    
    public var endPoint: String {
        switch self {
        case .events:
            return baseUrl + "events/"
        case .checkin:
            return baseUrl + "checkin/"
        }
    }
    
}
