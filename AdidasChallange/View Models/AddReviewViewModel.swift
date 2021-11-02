//
//  AddReviewViewModel.swift
//  AdidasChallange
//
//  Created by Himanshu Tripathi on 02/11/21.
//

import Foundation

final class AddReviewViewModel : ObservableObject {
    
    func postAReview(review: [String: Any]) {
        
        guard let productId = review["productId"] else {
            return
        }
        
        guard let url = URL(string: "http://localhost:3002/reviews/\(productId)") else {
            print("Invalid url...")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: review, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }
        task.resume()
    }
}
