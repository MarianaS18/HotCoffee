//
//  AddOrderViewController.swift
//  HotCoffee
//
//  Created by Mariana Steblii on 23/12/2021.
//

import UIKit

class AddOrderViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties
    private var vm = AddNewOrderViewModel()
}

extension AddOrderViewController: UITableViewDelegate {
    
}

extension AddOrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "addOrderCell", for: indexPath) as? AddOrderTableViewCell else {
            fatalError("cell not found")
        }
        cell.coffeeNameLabel.text = self.vm.coffeeNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.coffeeNames.count
    }
}
