//
//  ProductDetailViewModel.swift
//  AdidasChallange
//
//  Created by Himanshu Tripathi on 02/11/21.
//

import Foundation

final class ProductDetailViewModel : ObservableObject {
    
    func fetchAllReviews(productId:String, completion:@escaping ([Review]) -> ()) {
        
        guard let url = URL(string: "http://localhost:3002/reviews/\(productId)") else {
            print("Invalid url...")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let response = data {
                
                let reviews : [Review] = try! JSONDecoder().decode([Review].self, from: response)
                
                DispatchQueue.main.async {
                    completion(reviews)
                }
            }
        }
        .resume()
    }
}
