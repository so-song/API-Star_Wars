//
//  FilmsViewController.swift
//  StarWars
//
//  Created by Audrey SOBGOU ZEBAZE on 18/12/2020.
//

import UIKit

class FilmsViewController: UIViewController {
    //
    // MARK: - Constants
    //
    
    /// Search Web Service
    let queryService = MovieService()
    
    
    //
    // MARK: - IBOutlets
    //
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //
    // MARK: - Variables And Properties
    //
    
    var searchResults: [Movie] = []
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
        return recognizer
    }()
    
    //
    // MARK: - Internal Methods
    //
    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    func reload(_ row: Int) {
        tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
    }
    
}

//
// MARK: - Search Bar Delegate
//
extension FilmsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        
        // TODO: Make Request and update TableView
        queryService.getSearchResults(searchTerm: searchText) { [weak self] (result: Result<MovieResponse, MovieService.APIServiceError>) in
            
            switch result {
            case .success(let response):
                
                DispatchQueue.main.async {
                    self?.searchResults = response.results
                    self?.tableView.reloadData()
                }
                print("Response: \(response)")
                
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidBeginEditing")
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing")
        
        view.removeGestureRecognizer(tapRecognizer)
    }
}
