//
//  Order.swift
//  HotCoffee
//
//  Created by Mariana Steblii on 23/12/2021.
//

import Foundation

enum CoffeeName: String, Codable, CaseIterable {
    case cappuccino = "Cappuccino"
    case latte = "Latte"
    case espresso = "Espresso"
    case cortado = "Cortado"
    case hotCoffee = "Hot Coffee"
}

enum CoffeeSize: String, Codable, CaseIterable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
}

struct Order: Codable {
    let name: String
    let coffeeName: CoffeeName
    let total: Double
    let size: CoffeeSize
}
