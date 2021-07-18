//
//  EventDetailViewModel.swift
//  Event
//
//  Created by João Luis dos Santos on 18/07/21.
//

import RxSwift
import RxCocoa

protocol EventDetailViewModelProtocol {
    var eventTitle: BehaviorRelay<String> { get }
    var eventDate: BehaviorRelay<String> { get }
    var eventPrice: BehaviorRelay<String> { get }
    var eventDescription: BehaviorRelay<String> { get }
    var eventImage: BehaviorRelay<UIImage?> { get }
    var eventCoordinate: Coordinates? { get }
    var eventRequestStatus: PublishSubject<Bool> { get }
    var eventCheckinStatus: PublishSubject<Bool> { get }
    func postCheckin()
    func getEvent()
}

class EventDetailViewModel: EventDetailViewModelProtocol {
    
    var eventTitle = BehaviorRelay<String>(value: "")
    var eventDate = BehaviorRelay<String>(value: "")
    var eventPrice = BehaviorRelay<String>(value: "")
    var eventDescription = BehaviorRelay<String>(value: "")
    var eventImage = BehaviorRelay<UIImage?>(value: nil)
    var eventCoordinate: Coordinates?
    let eventRequestStatus = PublishSubject<Bool>()
    let eventCheckinStatus = PublishSubject<Bool>()
    
    private let eventId: String
    private let repository: EventsService
    private let disposeBag = DisposeBag()
    
    init(eventId: String, repository: EventsService = EventsService()) {
        self.eventId = eventId
        self.repository = repository
    }
    
    func getImage(from url: String) {
        repository.getData(url: url)
            .subscribe { data in
                self.eventImage.accept(UIImage(data: data))
            } onError: { error in
                self.eventImage.accept(UIImage(named: "image-not-found"))
            }
            .disposed(by: disposeBag)
    }
    
    func getEvent() {
        repository.getEvent(by: eventId)
            .subscribe { event in
                self.getImage(from: event.image)
                self.eventTitle.accept(event.title)
                self.eventDate.accept(event.date.timestampToDate.toString(format: .ddMMYYYY))
                self.eventPrice.accept(event.price.toCurrency(.real))
                self.eventDescription.accept(event.description)
                self.eventCoordinate = Coordinates(longitude: event.longitude, latitude: event.latitude)
                self.eventRequestStatus.onNext(true)
            } onError: { _ in
                self.eventRequestStatus.onNext(false)
            }
            .disposed(by: disposeBag)
    }
    
    func postCheckin() {
        let params = ["eventId": eventId, "name": "nome", "email": "email"]
        repository.postCheckin(params: params)
            .subscribe { status in
                self.eventCheckinStatus.onNext(status.element ?? false)
            }
            .disposed(by: disposeBag)
    }
}

