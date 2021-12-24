//
//  AddOrderViewController.swift
//  HotCoffee
//
//  Created by Mariana Steblii on 23/12/2021.
//

import UIKit

protocol AddOrderViewControllerDelegate {
    func addOrderViewControllerDidSave(order: Order, controller: UIViewController)
    func addOrderViewControllerDidClose(controller: UIViewController)
}

class AddOrderViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!

    // MARK: - Private properties
    private var vm = AddNewOrderViewModel()
    private var coffeeSizesSegmentedController: UISegmentedControl!
    
    // MARK: - Public properties
    var delegate: AddOrderViewControllerDelegate?
    
    // MARK: - View functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        self.coffeeSizesSegmentedController = UISegmentedControl(items: self.vm.sizes)
        
        /// add constraints to segmented controller
        self.coffeeSizesSegmentedController.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.coffeeSizesSegmentedController)
        self.coffeeSizesSegmentedController.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 20.0).isActive = true
        self.coffeeSizesSegmentedController.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    // MARK: - IBActions
    @IBAction func save(_ sender: UIBarButtonItem) {
        let name = nameTextField.text
        let price = priceTextField.text
        let size = coffeeSizesSegmentedController.titleForSegment(at: coffeeSizesSegmentedController.selectedSegmentIndex)

        guard let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("error in selected coffee")
        }
        self.vm.name = name
        self.vm.price = Double(price!)
        self.vm.selectedSize = size
        self.vm.selectedType = self.vm.types[indexPath.row]
        
        WebService().load(resource: Order.create(vm: self.vm)) { result in
            switch result {
            case .success(let order):
                if let order = order, let delegate = self.delegate {
                    DispatchQueue.main.async {
                        delegate.addOrderViewControllerDidSave(order: order, controller: self)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        if let delegate = self.delegate {
            delegate.addOrderViewControllerDidClose(controller: self)
        }
    }
}

extension AddOrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}

extension AddOrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "addOrderCell", for: indexPath) as? AddOrderTableViewCell else {
            fatalError("cell not found")
        }
        cell.coffeeNameLabel.text = self.vm.types[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.types.count
    }
}
