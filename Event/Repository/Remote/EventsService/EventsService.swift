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
    
    func getEvent(by id: String) -> Observable<Event> {
        return request(APIRequest.events.endPoint + id)
    }
    
    func getData(url: String) -> Observable<Data> {
        return requestData(url)
    }
}
