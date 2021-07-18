//
//  EventDetailViewModel.swift
//  Event
//
//  Created by João Luis dos Santos on 18/07/21.
//

import RxSwift
import RxCocoa

protocol EventDetailViewModelProtocol {
    var eventTitle: PublishSubject<String> { get }
    var eventDate: PublishSubject<String> { get }
    var eventPrice: PublishSubject<String> { get }
    var eventDescription: PublishSubject<String> { get }
    var eventImage: PublishSubject<UIImage?> { get }
    var eventCoordinate: Coordinates? { get }
    var eventRequestStatus: PublishSubject<Bool> { get }
}

class EventDetailViewModel: EventDetailViewModelProtocol {
    
    var eventTitle = PublishSubject<String>()
    var eventDate = PublishSubject<String>()
    var eventPrice = PublishSubject<String>()
    var eventDescription = PublishSubject<String>()
    var eventImage = PublishSubject<UIImage?>()
    var eventCoordinate: Coordinates?
    let eventRequestStatus = PublishSubject<Bool>()
    
    private let eventId: String
    private let repository: EventsService
    private let disposeBag = DisposeBag()
    
    init(eventId: String, repository: EventsService = EventsService()) {
        self.eventId = eventId
        self.repository = repository
        getEvent()
    }
    
    func getImage(from url: String) {
        repository.getData(url: url)
            .subscribe { data in
                self.eventImage.onNext(UIImage(data: data))
            } onError: { error in
                self.eventImage.onNext(UIImage(named: "image-not-found"))
            }
            .disposed(by: disposeBag)
    }
    
    func getEvent() {
        repository.getEvent(by: eventId)
            .subscribe { event in
                self.getImage(from: event.image)
                self.eventTitle.onNext(event.title)
                self.eventDate.onNext(event.date.timestampToDate.toString(format: .ddMMYYYY))
                self.eventPrice.onNext(event.price.toCurrency(.real))
                self.eventDescription.onNext(event.description)
                self.eventCoordinate = Coordinates(longitude: event.longitude, latitude: event.latitude)
                self.eventRequestStatus.onNext(true)
            } onError: { _ in
                self.eventRequestStatus.onNext(false)
            }
            .disposed(by: disposeBag)
        
        
    }
}

