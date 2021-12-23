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
    private var coffeeSizesSegmentedController: UISegmentedControl!
    
    // MARK: - View functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        self.coffeeSizesSegmentedController = UISegmentedControl(items: self.vm.coffeeSizes)
        
        /// add constraints to segmented controller
        self.coffeeSizesSegmentedController.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.coffeeSizesSegmentedController)
        self.coffeeSizesSegmentedController.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 20.0).isActive = true
        self.coffeeSizesSegmentedController.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
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
