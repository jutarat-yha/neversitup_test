//
//  ProductViewModel.swift
//  Departments
//
//  Created by Jutarat Yothasilarak on 11/4/2567 BE.
//

import Foundation

class ProductViewModel: NSObject {
    var onProductListUpdated : (() -> Void)?
    var onErrorMessage: ((ServiceError)->Void)?

    private var apiService = APIService()
    private(set) var productListData: [ProductListData] = [] {
        didSet {
            self.onProductListUpdated?()
        }
    }
    
    override init() {
        super.init()
    }
    
    func fecthProductList(departmentId: String) {
        apiService.callServiceProductList(departmentId: departmentId) { [weak self] result in
            switch result {
            case .success(let productListData):
                self?.productListData = productListData
                
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
        }
    }
}
