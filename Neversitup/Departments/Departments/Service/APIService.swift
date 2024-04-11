//
//  APIService.swift
//  Departments
//
//  Created by Jutarat Yothasilarak on 9/4/2567 BE.
//

import Foundation

class APIService: NSObject  {
    func callServiceDepartments(completion: @escaping (Result<[DepartmentData], ServiceError>) -> Void) {
        let apiUrlDepartments = URL(string: "https://659f86b15023b02bfe89c737.mockapi.io/api/v1/departments")!
        var request = URLRequest(url: apiUrlDepartments)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(.failure(.invalidResponse))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let departmentData = try decoder.decode([DepartmentData].self, from: data)
                    completion(.success(departmentData))
                    
                } catch let err {
                    completion(.failure(.invalidData))
                    print(err.localizedDescription)
                }
                
            } else {
                completion(.failure(.unknown))
            }
            
        }.resume()

    }
    
    func callServiceProductList(departmentId: String, completion: @escaping (Result<[ProductListData], ServiceError>) -> Void) {
        let apiUrlProduct = URL(string: "https://659f86b15023b02bfe89c737.mockapi.io/api/v1/departments/\(departmentId)/products")!
        var request = URLRequest(url: apiUrlProduct)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(.failure(.invalidResponse))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let departmentData = try decoder.decode([ProductListData].self, from: data)
                    completion(.success(departmentData))
                    
                } catch let err {
                    completion(.failure(.invalidData))
                    print(err.localizedDescription)
                }
                
            } else {
                completion(.failure(.unknown))
            }
            
        }.resume()

    }
}

enum ServiceError: Error {
    case requestFailed(Error)
    case invalidResponse
    case invalidData
    case unknown
}
