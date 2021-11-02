//
//  Review.swift
//  AdidasChallange
//
//  Created by Himanshu Tripathi on 02/11/21.
//

import Foundation

struct Review: Codable {
    let productID, locale: String
    let rating: Int
    let text: String

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case locale, rating, text
    }
}
