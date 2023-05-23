//
//  OrderViewModel.swift
//  Hot Coffee (MVVM)
//
//  Created by Youssef Eldeeb on 23/05/2023.
//

import Foundation

class OrderListViewModel{
    var ordersViewModel: [OrderViewModel]
    
    init() {
        self.ordersViewModel = [OrderViewModel]()
    }
    
    func orderInIndex(at index: Int) -> OrderViewModel {
        return self.ordersViewModel[index]
    }
}

struct OrderViewModel{
    let order: Order
    
    var name: String{
        return order.name
    }
    var email: String{
        return  order.email
    }
    var type: String{
        return order.type.rawValue.capitalized
    }
    var size: String{
        return order.size.rawValue.capitalized
    }
    
}
