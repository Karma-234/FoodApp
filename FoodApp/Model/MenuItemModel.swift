//
//  MenuItemModel.swift
//  FoodApp
//
//  Created by MAC  on 10/15/23.
//

import Foundation
struct MenuList: Codable {
    let menu: [MenuItem]
}


struct MenuItem: Codable {
    let title: String
    let price: String
    let description: String
    let image: String
} 
