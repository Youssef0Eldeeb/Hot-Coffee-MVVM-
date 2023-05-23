//
//  OrdersTableViewController.swift
//  Hot Coffee (MVVM)
//
//  Created by Youssef Eldeeb on 22/05/2023.
//

import UIKit

class OrdersTableViewController: UITableViewController {

    var orderListViewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    private func populateOrders(){
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else{
            fatalError("URL is incorrect")
        }
        let resource = Resource<[Order]>(url: url)
        WebService.shared.load(resouce: resource) { [weak self] result in
            switch result{
            case .success(let orders):
                self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
            case.failure(let error):
                print(error)
            }
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
