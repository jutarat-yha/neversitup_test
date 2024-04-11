//
//  DepartmentModel.swift
//  Departments
//
//  Created by Jutarat Yothasilarak on 9/4/2567 BE.
//

import Foundation

struct Department: Decodable {
    let data: [DepartmentData]
}

struct DepartmentData: Decodable {
    let name, imageUrl, id: String
    var isSelected: Bool = false

    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl
        case id
    }
}
