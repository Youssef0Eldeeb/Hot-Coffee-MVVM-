//
//  AddOrderViewController.swift
//  Hot Coffee (MVVM)
//
//  Created by Youssef Eldeeb on 22/05/2023.
//

import UIKit

class AddOrderViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextFiels: UITextField!
    
    private var segmintedControl: UISegmentedControl!
    private var addOrderViewModel = AddOrderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
    }
    

    private func setupUI(){
        segmintedControl = UISegmentedControl(items: addOrderViewModel.size)
        segmintedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(segmintedControl)
        segmintedControl.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
        segmintedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    @IBAction func saveBtn(){
        let name = nameTextField.text ?? ""
        let email = emailTextFiels.text ?? ""
 
        let selectedSize = segmintedControl.titleForSegment(at: segmintedControl.selectedSegmentIndex)
        guard let indexPath = tableView.indexPathForSelectedRow else{
            fatalError("Error in Selecting Coffee Type")
        }
        
        addOrderViewModel.name = name
        addOrderViewModel.email = email
        addOrderViewModel.selectedSize = selectedSize
        addOrderViewModel.selectedType = addOrderViewModel.types[indexPath.row]
        
        let resource = Order.create(vm: addOrderViewModel)
        WebService.shared.load(resouce: resource) { result in
            switch result{
            case .success(let order):
                print(order)
            case .failure(let error):
                print(error)
            }
        }
    }
    

}

extension AddOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addOrderViewModel.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aCell", for: indexPath)
        cell.textLabel?.text = addOrderViewModel.types[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
