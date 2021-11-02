//
//  AddReviewViewController.swift
//  AdidasChallange
//
//  Created by Himanshu Tripathi on 02/11/21.
//

import UIKit

class AddReviewViewController: UIViewController {
    
    @IBOutlet weak var ratingText : UITextField!
    @IBOutlet weak var reviewText : UITextView!
    
    var productId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratingText.layer.borderColor = UIColor.black.cgColor
        ratingText.layer.borderWidth = 1.0
        ratingText.layer.cornerRadius = 5
        
        reviewText.layer.borderColor = UIColor.black.cgColor
        reviewText.layer.borderWidth = 1.0
        reviewText.layer.cornerRadius = 5
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        
        let addReviewViewModel = AddReviewViewModel()
        
        if let ratingText = ratingText.text,
           let reviewText = reviewText.text,
           let productId = productId {
            
            let review = ["productId":productId,
                          "locale":"en-GB",
                          "rating" : Int(ratingText) ?? 0,
                          "text" : reviewText] as [String : Any]
            
            addReviewViewModel.postAReview(review: review)
        }
        self.navigationController?.popViewController(animated: true)
    }
}


