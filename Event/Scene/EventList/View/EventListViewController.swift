//
//  EventListViewController.swift
//  Event
//
//  Created by João Luis dos Santos on 18/07/21.
//

import RxCocoa
import RxSwift

class EventListViewController: UIViewController, UITableViewDelegate {
    
    private let viewModel: EventListViewModel
    private let disposeBag = DisposeBag()
    
    lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        return control
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.identifier)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.addSubview(refreshControl)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    init(viewModel: EventListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Eventos"
        viewModel.getEvents()
        bindViewModel()
    }
    
    override func loadView() {
        self.view = tableView
    }
    
    func bindViewModel() {
        viewModel.events
            .bind(to: tableView.rx.items(cellIdentifier: EventTableViewCell.identifier, cellType: EventTableViewCell.self)) { _, event, cell in
                cell.titleLabel.text = event.title
                cell.dateLabel.text = event.date.timestampToDate.toString(format: .ddMMYYYY)
            }
            .disposed(by: disposeBag)
        
        viewModel.eventRequestStatus
            .subscribe(onNext: { sucess in
                if sucess == false {
                    self.requestError()
                }
                self.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)

        
        tableView.rx.modelSelected(Event.self)
            .subscribe(onNext: { event in
                let viewModel = EventDetailViewModel(eventId: event.id)
                let controller = EventDetailViewController(viewModel: viewModel)
                self.navigationController?.pushViewController(controller, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func requestError() {
        let alert = CommonAlert.createAlert(title: "Desculpe", message: "Não foi possível buscar os eventos.") {
            self.dismiss(animated: true)
        }
        present(alert, animated: true)
    }
    
    @objc func refresh() {
        viewModel.getEvents()
    }

}
