//
//  Product.swift
//  AdidasChallange
//
//  Created by Himanshu Tripathi on 01/11/21.
//

import Foundation

struct Product: Codable {
    let currency: String
    let price: Int
    let id, name, description: String
    let imgURL: String

    enum CodingKeys: String, CodingKey {
        case currency, price, id, name
        case description = "description"
        case imgURL = "imgUrl"
    }
}
