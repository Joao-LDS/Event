//
//  EventListViewModel.swift
//  Event
//
//  Created by João Luis dos Santos on 18/07/21.
//

import RxSwift
import RxCocoa

protocol EventListViewModelProtocol {
    var events: PublishSubject<[Event]> { get }
    var eventRequestStatus: BehaviorRelay<Bool> { get }
    func getEvents()
}

class EventListViewModel: EventListViewModelProtocol {
    
    let events = PublishSubject<[Event]>()
    let eventRequestStatus = BehaviorRelay<Bool>(value: true)
    private let repository: EventsService
    private let disposeBag = DisposeBag()
    
    init(repository: EventsService = EventsService()) {
        self.repository = repository
    }
    
    func getEvents() {
        repository.getEvents()
            .subscribe { events in
                self.eventRequestStatus.accept(true)
                self.events.onNext(events)
            } onError: { error in
                self.eventRequestStatus.accept(false)
            }
            .disposed(by: disposeBag)
    }
}
