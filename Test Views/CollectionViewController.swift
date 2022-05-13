//
//  CollectionViewController.swift
//  Test Views
//
//  Created by Curitiba01 on 08/09/21.
//  Copyright © 2021 Curitiba01. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftyJSON

struct User {
    var id: Int
    var email: String
    var firstName: String
    var lastName: String
    var avatarURL: String
    
    init(json: JSON) {
        id = json["id"].intValue
        firstName = json["first_name"].stringValue
        lastName = json["last_name"].stringValue
        email = json["email"].stringValue
        avatarURL = json["avatar"].stringValue
    }
}

enum Category: String, CaseIterable {
    case x = "x"
    case y = "y"
}

class CollectionViewController: UICollectionViewController {
    
    let names = [
        "Davi",
        "Jose",
        "Maria",
        "Fernando",
        "Mariana",
        "Rosalia",
        "João"
    ]    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        LoadingView.shared.show()
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            LoadingView.shared.hide()
        }
    }
    
    private func setupHeader() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "searchBarPlaceholder".localized
        searchController.searchBar.scopeButtonTitles = Category.allCases.map { $0.rawValue }
        //searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemGray.cgColor
        cell.layer.cornerRadius = 8
        cell.tripPicImageView.image = UIImage(named: "rio-de-janeiro")
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let url = URL(string: "https://reqres.in/api/users?page=2") else { return }
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "GET"
//        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                guard let data = data,
//                      let json = try? JSON(data: data)
//                else { return }
//
//                let users = json["data"].arrayValue.map { User(json: $0) }
//                print(users)
//            }
//        }
//        task.resume()
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2
        
        let array = ["", ""]
        let filtered = array.filter { (item) -> Bool in
            return item.contains("")
        }
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
}

extension CollectionViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        let predicate = NSPredicate(format: "self CONTAINS[cd] %@", text)
        
//        AVCaptureDevice.authorizationStatus(for: .video) == .authorized
//        AVCaptureDevice.requestAccess(for: .video) { <#Bool#> in
//            <#code#>
//        }
        
        if text.isEmpty {
            print(names)
            return
        }
        
        if let namesFiltered = (names as NSArray).filtered(using: predicate) as? [String] {
            let selectedScopeIndex = searchController.searchBar.selectedScopeButtonIndex
            print(Category.allCases[selectedScopeIndex].rawValue)
            print(namesFiltered)
        }
    }
}
