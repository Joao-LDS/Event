//
//  Event.swift
//  Event
//
//  Created by João Luis dos Santos on 18/07/21.
//

import Foundation

struct Event: Codable {
    let people: [Person]
    let date: Int
    let description: String
    let image: String
    let longitude, latitude, price: Double
    let title, id: String
    
    struct Person: Codable {
        let id, eventId, name, picture: String
    }
}
