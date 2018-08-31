//
//  FavoriteVC.swift
//  book_api_search
//
//  Created by TAKUTO on 2018/08/28.
//  Copyright © 2018年 TAKUTO. All rights reserved.
//

import UIKit
import CoreData

class FavoriteVC: UIViewController {
    private var books = [BookData]()
    private var searchController: UISearchController!
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    var passedData:BookData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllData()
    }
    
    func setup() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.title = "BookShelf"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func fetchAllData(){
        do {
            books = try context.fetch(BookData.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        favoriteCollectionView.reloadData()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as? bookShelfVC
        next?.bookData = passedData
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {}
 
}

extension FavoriteVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemCell
        let book = books[indexPath.row]
        cell.titleLbl.text = book.title
        cell.authorLbl.text = book.author
        cell.bookImage.load(url: URL(string: book.image!)!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        passedData = books[indexPath.row]
        performSegue(withIdentifier: "toBookShelfVC", sender: nil)
    }
}

extension FavoriteVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        // SearchBarに入力したテキストを使って表示データをフィルタリングする。
        let text = searchController.searchBar.text ?? ""
        if text.isEmpty {
            print("not filetered")
            fetchAllData()
        } else {
            books = books.filter { (book: BookData) -> Bool in
                return (book.title?.contains(text))! || (book.author?.contains(text))!
            }
        }
        favoriteCollectionView.reloadData()
    }
}

