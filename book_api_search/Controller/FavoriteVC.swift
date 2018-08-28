//
//  FavoriteVC.swift
//  book_api_search
//
//  Created by TAKUTO on 2018/08/28.
//  Copyright © 2018年 TAKUTO. All rights reserved.
//

import UIKit
import CoreData

class FavoriteVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    private var books = [BookData]()
    private var searchController: UISearchController!
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            books = try context.fetch(BookData.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        favoriteCollectionView.reloadData()
    }
    
    func setup() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.title = "BookShelf"
            // UISearchControllerをUINavigationItemのsearchControllerプロパティにセットする。
        navigationItem.searchController = searchController
            
            // trueだとスクロールした時にSearchBarを隠す（デフォルトはtrue）
            // falseだとスクロール位置に関係なく常にSearchBarが表示される
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
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
}

extension FavoriteVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        // SearchBarに入力したテキストを使って表示データをフィルタリングする。
        let text = searchController.searchBar.text ?? ""
        if text.isEmpty {
            
        } else {
            
        }
        favoriteCollectionView.reloadData()
    }
}
