//
//  ConfigureView.swift
//  Event
//
//  Created by João Luis dos Santos on 18/07/21.
//

import Foundation

protocol ConfigureView {
    func addSubviews()
    func addConstraints()
    func setupView()
}

extension ConfigureView {
    func setupView() {
        addSubviews()
        addConstraints()
    }
}
