//
//  AddOrderViewModel.swift
//  Hot Coffee (MVVM)
//
//  Created by Youssef Eldeeb on 24/05/2023.
//

import Foundation

struct AddOrderViewModel{
    var name: String?
    var email: String?
    var selectedType: String?
    var selectedSize: String?
    var types: [String] {
        return CoffeeType.allCases.map{ $0.rawValue.capitalized }
    }
    var size: [String] {
        return CoffeeSize.allCases.map{ $0.rawValue.capitalized }
    }
}
