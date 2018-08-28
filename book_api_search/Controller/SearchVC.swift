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

class SearchVC: UIViewController,UISearchBarDelegate {
    var endpoint = "https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404?applicationId=1013263298846387208&size=2"
    var books:[Book] = []
    
    @IBOutlet weak var titleSearchBar: UISearchBar!
    @IBOutlet weak var authorSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleSearchBar.delegate = self
        authorSearchBar.delegate = self
    }
    

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        books = []
        let text = searchBar.text!
        searchBar.text = ""
        let input = text.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let searchWord = searchKey(searchBar) ? "title" : "author"
        let searchUrl = "\(endpoint)&\(searchWord)=\(input!)"
        let url = URL(string: searchUrl)
        getBooks(url!)
    }
    

    func getBooks(_ url:URL) {
        for i in 1...3{
            let url = "\(url)&page=\(i)"
            Alamofire.request(url).responseJSON { (response) in
                defer{if i == 3 {
                      self.performSegue(withIdentifier: "toResultVC", sender: nil)
                    }}
                guard let object = response.result.value as? [String:Any] else{
                    print("error")
                    return
                }
                let json = JSON(object)
                json["Items"].forEach({ ( _ ,json) in
                    let book = Book(isbn: json["Item"]["isbn"].string!, title: json["Item"]["title"].string!, author: json["Item"]["author"].string!, salesDate: json["Item"]["salesDate"].string!,itemCaption: json["Item"]["itemCaption"].string!, itemUrl: json["Item"]["itemUrl"].string!,publisherName: json["Item"]["publisherName"].string!, smallImageUrl: json["Item"]["smallImageUrl"].string!, mediumImageUrl: json["Item"]["mediumImageUrl"].string!, largeImageUrl: json["Item"]["largeImageUrl"].string!)
                    self.books.append(book)
                })
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as? ResultVC
        next?.books = books
    }

    
    
    func searchKey(_ searchBar:UISearchBar) -> Bool{
        if searchBar == self.titleSearchBar {
            return true
        } else {
            return false
        }
    }
    
    

    




}

