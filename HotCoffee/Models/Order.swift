//
//  Order.swift
//  HotCoffee
//
//  Created by Mariana Steblii on 23/12/2021.
//

import Foundation

enum CoffeeName: String, Codable {
    case cappuccino
    case latte
    case espresso
    case cortado
    case hotCoffee = "Hot Coffee"
}

enum CoffeeSize: String, Codable {
    case small = "Small"
    case medium = "Medium"
    case large
}

struct Order: Codable {
    let name: String
    let coffeeName: CoffeeName
    let total: Double
    let size: CoffeeSize
}
