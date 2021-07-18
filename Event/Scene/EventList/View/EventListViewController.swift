//
//  EventListViewController.swift
//  Event
//
//  Created by João Luis dos Santos on 18/07/21.
//

import UIKit

class EventListViewController: UIViewController {
    
    private let viewModel: EventListViewModel
    
    init(viewModel: EventListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
