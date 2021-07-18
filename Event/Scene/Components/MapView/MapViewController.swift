//
//  MapViewController.swift
//  Event
//
//  Created by João Luis dos Santos on 18/07/21.
//

import MapKit

class MapViewController: UIViewController {

    private let viewModel: MapViewModelProtocol

    lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        view.setTitle("Voltar", for: .normal)
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    init(viewModel: MapViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupMap()
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func loadView() {
        self.view = mapView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMap() {
        let location = CLLocationCoordinate2D(latitude: viewModel.coordinates.latitude,
                                              longitude: viewModel.coordinates.longitude)
        mapView.setCenter(location, animated: true)
        
        let region = MKCoordinateRegion(center: location,
                                        span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                               longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = location
        mapView.addAnnotation(pin)
    }
    
    @objc func backAction() {
        dismiss(animated: true)
    }

}

extension MapViewController: ConfigureView {
    func addSubviews() {
        mapView.addSubview(backButton)
    }
    
    func addConstraints() {
        backButton.topAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        backButton.leadingAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
