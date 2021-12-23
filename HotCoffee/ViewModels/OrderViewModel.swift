//
//  OrderViewModel.swift
//  HotCoffee
//
//  Created by Mariana Steblii on 23/12/2021.
//
// MARK: - IBOutlets
// MARK: - View functions
// MARK: - Private functions
// MARK: - Public functions
// MARK: - @objc private functions
// MARK: - IBActions

import Foundation

struct OrderViewModel {
    // MARK: - Private properties
    private let order: Order
}

extension OrderViewModel {
    // MARK: - Public properties
    var name: String {
        return self.order.name
    }
    
    var coffeeName: String {
        return self.order.coffeeName.rawValue.capitalized
    }
    
    var coffeSize: String {
        return self.order.size.rawValue.capitalized
    }
}
