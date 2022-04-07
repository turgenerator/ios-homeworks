//
//  Setupable.swift
//  Navigation
//
//  Created by Nikita Turgenev on 25.03.2022.
//

import Foundation

protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}
