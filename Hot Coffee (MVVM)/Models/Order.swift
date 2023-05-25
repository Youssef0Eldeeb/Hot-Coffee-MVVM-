//
//  Order.swift
//  Hot Coffee (MVVM)
//
//  Created by Youssef Eldeeb on 23/05/2023.
//

import Foundation

enum CoffeeType: String, Codable, CaseIterable{
    case cappuccino
    case latte
    case espressino
    case cortado
}
enum CoffeeSize: String, Codable, CaseIterable{
    case small
    case medium
    case large
}

struct Order: Codable{
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
}
extension Order{
    init?(_ vm: AddOrderViewModel){
        guard let name = vm.name,
              let email = vm.email,
              let selectedType = CoffeeType(rawValue: vm.selectedType!.lowercased()),
              let selectedSize = CoffeeSize(rawValue: vm.selectedSize!.lowercased()) else{
            return nil
        }
        self.name = name
        self.email = email
        self.type = selectedType
        self.size = selectedSize 
    }
}

extension Order{
    static func create(vm: AddOrderViewModel) -> Resource<Order?>{
        let order = Order(vm)
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders")else{
            fatalError("URL is incorrent")
        }
        guard let data = try? JSONEncoder().encode(order) else{
            fatalError("Error encoding order!")
        }
        var resouce = Resource<Order?>(url: url)
        resouce.httpMethod = HttpMethod.post
        resouce.body = data
        
        return resouce
    }
    static var getAll: Resource<[Order]> {
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders")else{
            fatalError("URL is incorrent")
        }
        return Resource<[Order]>(url: url)
    }
}
