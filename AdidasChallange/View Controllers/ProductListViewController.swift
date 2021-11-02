//
//  ProductListViewController.swift
//  AdidasChallange
//
//  Created by Himanshu Tripathi on 01/11/21.
//

import UIKit

class ProductListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let productListViewModel = ProductListViewModel()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var products: [Product] = []
    
    var filteredProducts: [Product] = []
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        filteredProducts = products.filter({ product in
            let match = product.name.lowercased().contains(searchText.lowercased())  || product.description.lowercased().contains(searchText.lowercased()) || ("\(product.price)").lowercased().contains(searchText.lowercased())
            return match
        })
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search Products"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        productListViewModel.fetchAllProducts{ (products) in
            
            if products.count > 0 {
                self.products = products
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "ShowDetailSegue",
            let indexPath = tableView.indexPathForSelectedRow,
            let productDetailViewController = segue.destination as? ProductDetailViewController
        else {
            return
        }
        
        productDetailViewController.product = isFiltering ? self.filteredProducts[indexPath.row] : self.products[indexPath.row]
    }
}


extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? self.filteredProducts.count : self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? ProductTableViewCell else {
            
            return UITableViewCell()
        }
        
        cell.setUp(product: isFiltering ? self.filteredProducts[indexPath.row] : self.products[indexPath.row])
        
        return cell
    }
}

extension ProductListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


extension ProductListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
