//
//  ViewCode+.swift
//  CineHarbor
//
//  Created by Milena on 23/04/2025.
//

protocol ViewCode {
    func setupView()
    func setupHierarchy()
    func setupConstraints()
}

extension ViewCode {
    func setupView() {
        setupHierarchy()
        setupConstraints()
    }
}
