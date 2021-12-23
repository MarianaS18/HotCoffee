//
//  Order.swift
//  HotCoffee
//
//  Created by Mariana Steblii on 23/12/2021.
//

import Foundation

enum CoffeeType: String, Codable, CaseIterable {
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
    let coffeeName: CoffeeType
    let total: Double
    let size: CoffeeSize
}

extension Order {
    init?(_ vm: AddNewOrderViewModel) {
        guard let name = vm.name,
              let price = vm.price,
              let selectedSize = CoffeeSize(rawValue: vm.selectedSize!.lowercased()),
              let selectedType = CoffeeType(rawValue: vm.selectedType!.lowercased()) else {
                  return nil
              }
        
        self.name = name
        self.total = price
        self.coffeeName = selectedType
        self.size = selectedSize
    }
    
    static var all: Resource<[Order]> = {
        guard let url = URL(string: "https://island-bramble.glitch.me/orders") else {
            fatalError("URL was incorrect")
        }
        return Resource<[Order]>(url: url)
    }()
    
    static func create(vm: AddNewOrderViewModel) -> Resource<Order?> {
        let order = Order(vm)
        
        guard let url = URL(string: "https://island-bramble.glitch.me/orders") else {
            fatalError("URL was incorrect")
        }
        
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("Error encoding order")
        }
        
        var resourse = Resource<Order?>(url: url)
        resourse.httpMethod = .post
        resourse.body = data
        return resourse
    }
}
