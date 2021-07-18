//
//  MapViewModel.swift
//  Event
//
//  Created by João Luis dos Santos on 18/07/21.
//

import Foundation

protocol MapViewModelProtocol {
    var coordinates: Coordinates { get }
}

class MapViewModel: MapViewModelProtocol {
    
    let coordinates: Coordinates
    
    init(coordinates: Coordinates) {
        self.coordinates = coordinates
    }
}
