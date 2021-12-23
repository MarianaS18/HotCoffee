//
//  AddNewOrderViewModel.swift
//  HotCoffee
//
//  Created by Mariana Steblii on 23/12/2021.
//

import Foundation

struct AddNewOrderViewModel {
    var name: String?
    
    var coffeeNames: [String] {
        return CoffeeName.allCases.map { $0.rawValue.capitalized }
    }
    
    var coffeeSizes: [String] {
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
    }
}
