//
//  ProductTableViewCell.swift
//  AdidasChallange
//
//  Created by Himanshu Tripathi on 01/11/21.
//

import UIKit

final class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var productImage : UIImageView!
    
    func setUp(product:Product) {
        
        nameLabel.text = product.name
        descriptionLabel.text = product.description
        priceLabel.text = "\(product.currency) \(product.price)"
        
        if let url = URL(string: product.imgURL) {
            if let data = try? Data(contentsOf: url) {
                // Create Image and Update Image View
                productImage.image = UIImage(data: data)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        descriptionLabel.text = nil
        priceLabel.text = nil
        productImage.image = nil
    }
}
