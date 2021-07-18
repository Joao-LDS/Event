//
//  EventsService.swift
//  Event
//
//  Created by João Luis dos Santos on 18/07/21.
//

import RxSwift

class EventsService: BaseService {
    func getEvents() -> Observable<[Event]> {
        return request(APIRequest.events.endPoint)
    }
}
