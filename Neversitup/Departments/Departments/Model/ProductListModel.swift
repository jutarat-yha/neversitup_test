//
//  ProductListModel.swift
//  Departments
//
//  Created by Jutarat Yothasilarak on 9/4/2567 BE.
//

import Foundation

struct ProductList: Decodable {
    let data: [ProductListData]
}

struct ProductListData: Decodable {
    let name, imageUrl, desc, price, type, id, departmentId: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl
        case desc
        case price
        case type
        case id
        case departmentId
    }
}
