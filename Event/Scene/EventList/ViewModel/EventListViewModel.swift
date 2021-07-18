//
//  EventListViewModel.swift
//  Event
//
//  Created by João Luis dos Santos on 18/07/21.
//

import RxSwift

protocol EventListViewModelProtocol {
    
}

class EventListViewModel: EventListViewModelProtocol {
    
    private let repository: EventsService
    private let disposeBag = DisposeBag()
    
    init(repository: EventsService = EventsService()) {
        self.repository = repository
        getEvents()
    }
    
    func getEvents() {
        repository.getEvents()
            .subscribe { events in
            print(events)
        }
        .disposed(by: disposeBag)
    }
}
