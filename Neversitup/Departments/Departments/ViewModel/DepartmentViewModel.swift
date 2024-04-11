//
//  DepartmentViewModel.swift
//  Departments
//
//  Created by Jutarat Yothasilarak on 10/4/2567 BE.
//

import Foundation

class DepartmentViewModel: NSObject {
    var onDepartmentsUpdated : (() -> Void)?
    var onErrorMessage: ((ServiceError)->Void)?

    private var apiService = APIService()
    private(set) var departmentData: [DepartmentData] = [] {
        didSet {
            self.onDepartmentsUpdated?()
        }
    }
    
    override init() {
        super.init()
        self.fecthDepartments()
    }
    
    func fecthDepartments() {
        apiService.callServiceDepartments() { [weak self] result in
            switch result {
            case .success(let departmentData):
                self?.departmentData = departmentData
                
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
        }
    }
    
}
