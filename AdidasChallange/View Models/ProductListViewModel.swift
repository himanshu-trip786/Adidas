//
//  ProductListViewModel.swift
//  AdidasChallange
//
//  Created by Himanshu Tripathi on 01/11/21.
//

import Foundation


final class ProductListViewModel : ObservableObject {
    
    func fetchAllProducts(completion:@escaping ([Product]) -> ()) {
        
        guard let url = URL(string: "http://localhost:3001/product") else {
            print("Invalid url...")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let response = data {
                let products : [Product] = try! JSONDecoder().decode([Product].self, from: response)
                
                DispatchQueue.main.async {
                    completion(products)
                }
            }
        }
        .resume()
    }
}


