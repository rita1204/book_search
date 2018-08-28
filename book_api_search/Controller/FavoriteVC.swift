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
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
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
