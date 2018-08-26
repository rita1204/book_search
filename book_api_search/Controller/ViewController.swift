//
//  ViewController.swift
//  book_api_search
//
//  Created by TAKUTO on 2018/08/25.
//  Copyright © 2018年 TAKUTO. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var bookTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var books:[Book] = []
    var pageCount = 0
    
    static let applicationID = "1013263298846387208"
    var endpoint = "https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404?applicationId=\(applicationID)"

    @IBOutlet weak var params: UISegmentedControl!
    var param:Int = 0

    @IBAction func paramChanged(_ sender: Any) {
        param = params.selectedSegmentIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        bookTableView.dataSource = self
        bookTableView.delegate = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookTableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        cell.textLabel?.text = books[indexPath.row].title
        return cell
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if self.bookTableView.contentOffset.y + self.bookTableView.frame.size.height > self.bookTableView.contentSize.height  && self.bookTableView.isDragging {
//            print("now reached the bottom line!!")
//        }
//    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text!
        let input = text.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let searchWord = "https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404?applicationId=1013263298846387208&author=\(input!)"
        let url = URL(string: searchWord)
        getBooks(url: url!)
        
    }
    
    func getBooks(url:URL) {
        Alamofire.request(url).responseJSON { (response) in
            defer{self.next()}
            guard let object = response.result.value as? [String:Any] else{
                print("error")
                return
            }

            let json = JSON(object)
            self.pageCount = json["count"].intValue
//            var times = 0
//            while times <= self.pageCount {
//                
//            }
            json["Items"].forEach({ ( _ ,json) in
                let book = Book(isbn: json["Item"]["isbn"].string!, title: json["Item"]["title"].string!, author: json["Item"]["author"].string!, salesDate: json["Item"]["salesDate"].string!, itemUrl: json["Item"]["itemUrl"].string!,publisherName: json["Item"]["publisherName"].string!, smallImageUrl: json["Item"]["smallImageUrl"].string!, mediumImageUrl: json["Item"]["mediumImageUrl"].string!, largeImageUrl: json["Item"]["largeImageUrl"].string!)
                self.books.append(book)
            })
        }
        
    }
    
    func next(){
        
        print(self.books[0])
        self.bookTableView.reloadData()
    }
    
    

    




}

