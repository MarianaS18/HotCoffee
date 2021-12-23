//
//  AddNewOrderViewModel.swift
//  HotCoffee
//
//  Created by Mariana Steblii on 23/12/2021.
//

import Foundation

struct AddNewOrderViewModel {
    var name: String?
    var price: Double?
    
    var selectedType: String?
    var selectedSize: String?
    
    var types: [String] {
        return CoffeeType.allCases.map { $0.rawValue.capitalized }
    }
    
    var sizes: [String] {
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
    }
}
