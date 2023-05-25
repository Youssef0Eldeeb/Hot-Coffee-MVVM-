//
//  OrdersTableViewController.swift
//  Hot Coffee (MVVM)
//
//  Created by Youssef Eldeeb on 22/05/2023.
//

import UIKit

class OrdersTableViewController: UITableViewController,addCoffeeDelegate {

    var orderListViewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    private func populateOrders(){

        WebService.shared.load(resouce: Order.getAll) { [weak self] result in
            switch result{
            case .success(let orders):
                self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
            case.failure(let error):
                print(error)
            }
        }
    }

    func saveNewOrder(order: Order) {
        let orderVM = OrderViewModel(order: order)
        orderListViewModel.ordersViewModel.append(orderVM)
        tableView.reloadData()
    }
    
    @IBAction func addOrderBtn(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "vc") as? AddOrderViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.orderListViewModel.ordersViewModel.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let singleOrder = self.orderListViewModel.orderInIndex(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = singleOrder.type
        cell.detailTextLabel?.text = singleOrder.size
        
        return cell
    }

}
