//
//  ProductDetailViewController.swift
//  AdidasChallange
//
//  Created by Himanshu Tripathi on 02/11/21.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var productImage : UIImageView!
    @IBOutlet var tableView: UITableView!
    
    let productDetailViewModel = ProductDetailViewModel()
    
    var reviews: [Review] = []
    
    var product: Product? {
        didSet {
            configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if let productId = product?.id {
            
            productDetailViewModel.fetchAllReviews(productId: productId) { [self] (reviews) in
                
                if reviews.count > 0 {
                    self.reviews = reviews
                    self.tableView.reloadData()
                } else {
                    tableView.isHidden = true
                }
            }
        }
    }
    
    func configureView() {
        if let product = product, let nameLabel = nameLabel {
            title = product.name
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "addReview",
            let addReviewViewController = segue.destination as? AddReviewViewController
        else {
            return
        }
        addReviewViewController.productId = product?.id
    }
}

extension ProductDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath)
        
        cell.textLabel?.text = "Rating: \(self.reviews[indexPath.row].rating)"
        cell.detailTextLabel?.text = self.reviews[indexPath.row].text
        
        return cell
    }
}
