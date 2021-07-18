//
//  EventDetailViewController.swift
//  Event
//
//  Created by João Luis dos Santos on 18/07/21.
//

import RxCocoa
import RxSwift

class EventDetailViewController: UIViewController {
    
    private var viewModel: EventDetailViewModel
    private let uiview: EventDetailView
    private let disposeBag = DisposeBag()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: EventDetailViewModel) {
        self.viewModel = viewModel
        self.uiview = EventDetailView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setActivityIndicator()
        bind()
    }
    
    override func loadView() {
        self.view = uiview
    }
    
    func setActivityIndicator() {
        uiview.isLoading(true)
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func bind() {
        viewModel.eventTitle
            .bind(to: uiview.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.eventImage
            .bind(to: uiview.imageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.eventDate
            .bind(to: uiview.dateLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.eventPrice
            .bind(to: uiview.priceLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.eventDescription
            .bind(to: uiview.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.eventRequestStatus
            .subscribe(onNext: { status in
                if status == false {
                    self.requestError()
                } else {
                    self.uiview.isLoading(false)
                    self.activityIndicator.stopAnimating()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func requestError() {
        let alert = CommonAlert.createAlert(title: "Desculpe", message: "Não foi possível buscar os dados do evento.") {
            self.navigationController?.popViewController(animated: true)
        }
        present(alert, animated: true)
    }

}