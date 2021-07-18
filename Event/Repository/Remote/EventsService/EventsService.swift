//
//  EventsService.swift
//  Event
//
//  Created by João Luis dos Santos on 18/07/21.
//

import RxSwift

protocol EventsServiceProtocol {
    func getEvents() -> Observable<[Event]>
    func getEvent(by id: String) -> Observable<Event>
    func getData(url: String) -> Observable<Data>
    func postCheckin(params: [String: String]) -> Observable<Bool>
}

class EventsService: BaseService, EventsServiceProtocol {
    func getEvents() -> Observable<[Event]> {
        return request(APIRequest.events.endPoint)
    }
    
    func getEvent(by id: String) -> Observable<Event> {
        return request(APIRequest.events.endPoint + id)
    }
    
    func getData(url: String) -> Observable<Data> {
        return requestData(url)
    }
    
    func postCheckin(params: [String: String]) -> Observable<Bool> {
        return post(params, endPoint: APIRequest.checkin.endPoint)
    }
}
