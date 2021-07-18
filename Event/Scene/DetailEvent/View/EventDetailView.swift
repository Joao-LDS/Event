//
//  EventDetailView.swift
//  Event
//
//  Created by João Luis dos Santos on 18/07/21.
//

import UIKit

class EventDetailView: UIScrollView {
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var priceLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var locationButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Location", for: .normal)
        return view
    }()
    
    lazy var checkinButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Checkin", for: .normal)
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isLoading(_ finish: Bool) {
        locationButton.isHidden = finish
        checkinButton.isHidden = finish
    }
    
}

extension EventDetailView: ConfigureView {
    
    func addSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(priceLabel)
        addSubview(locationButton)
        addSubview(checkinButton)
        addSubview(descriptionLabel)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.3),
            
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            
            dateLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            
            priceLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            
            locationButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            locationButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16),
            locationButton.heightAnchor.constraint(equalToConstant: 50),
            
            checkinButton.leadingAnchor.constraint(equalTo: locationButton.trailingAnchor, constant: 16),
            checkinButton.centerYAnchor.constraint(equalTo: locationButton.centerYAnchor),
            checkinButton.heightAnchor.constraint(equalToConstant: 50),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 16),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40)
        ])
    }
}
