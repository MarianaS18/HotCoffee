//
//  OrderListViewModel.swift
//  HotCoffee
//
//  Created by Mariana Steblii on 23/12/2021.
//
// MARK: - Private properties
// MARK: - Private functions
// MARK: - @objc private functions

import Foundation

class OrderListViewModel {
    // MARK: - Public properties
    var ordersViewModel: [OrderViewModel]
    
    // MARK: - View functions
    init() {
        self.ordersViewModel = [OrderViewModel]()
    }
}

extension OrderListViewModel {
    // MARK: - Public functions
    func orderViewModel(at index: Int) -> OrderViewModel {
        return self.ordersViewModel[index]
    }
}
