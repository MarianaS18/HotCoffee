//
//  OrdersTableViewController.swift
//  HotCoffee
//
//  Created by Mariana Steblii on 23/12/2021.
//
// MARK: - IBOutlets
// MARK: - Private properties
// MARK: - Public properties
// MARK: - Public functions
// MARK: - @objc private functions
// MARK: - IBActions

import UIKit

class OrdersTableViewController: UITableViewController {
    // MARK: - View functions
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
        
    }
    
    // MARK: - Private functions
    private func populateOrders() {
        guard let url = URL(string: "https://island-bramble.glitch.me/orders") else {
            fatalError("URL was incorrect")
        }
        
        let resource = Resource<[Order]>(url: url)
        
        WebService().load(resource: resource) { result in
            switch result {
            case .success(let orders):
                print(orders)
            case .failure(let error):
                print(error)
            }
        }
    }
}
