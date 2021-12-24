//
//  OrdersTableViewController.swift
//  HotCoffee
//
//  Created by Mariana Steblii on 23/12/2021.
//
// MARK: - IBOutlets
// MARK: - Private properties
// MARK: - Public functions
// MARK: - @objc private functions
// MARK: - IBActions

import UIKit

class OrdersTableViewController: UITableViewController {
    // MARK: - Public properties
    var orderListVM = OrderListViewModel()
    
    // MARK: - View functions
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListVM.ordersViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as? OrderTableViewCell else {
            fatalError("cell not found")
        }
        
        let orderVM = self.orderListVM.orderViewModel(at: indexPath.row)
        cell.coffeeNameLabel.text = orderVM.coffeeName
        cell.coffeeSizeLabel.text = orderVM.coffeSize
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
              let addOrderVC = navC.viewControllers.first as? AddOrderViewController else {
                  fatalError("Error performing segue")
              }
        addOrderVC.delegate = self
    }
    
    // MARK: - Private functions
    private func populateOrders() {
        WebService().load(resource: Order.all) { [weak self] result in
            switch result {
            case .success(let orders):
                self?.orderListVM.ordersViewModel = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension OrdersTableViewController: AddOrderViewControllerDelegate {
    func addOrderViewControllerDidSave(order: Order, controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
        let orderVM = OrderViewModel(order: order)
        self.orderListVM.ordersViewModel.append(orderVM)
        self.tableView.insertRows(at: [IndexPath.init(row: self.orderListVM.ordersViewModel.count - 1, section: 0)], with: .automatic)
    }
    
    func addOrderViewControllerDidClose(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
