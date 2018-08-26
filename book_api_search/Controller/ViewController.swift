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
    var endpoint = "https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404?applicationId=1013263298846387208"
    var books:[Book] = []
    var passedData:Book?
    var param:Int = 0
    
    @IBOutlet weak var bookTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var params: UISegmentedControl!
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       passedData = books[indexPath.row]
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        books = []
        let text = searchBar.text!
        searchBar.text = ""
        let input = text.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let searchWord = searchKey() ? "title" : "author"
        let searchUrl = "\(endpoint)&\(searchWord)=\(input!)&size=2"
        let url = URL(string: searchUrl)
        getBooks(url!)
    }
    

    func getBooks(_ url:URL) {
        for i in 1...3{
            let url = "\(url)&page=\(i)"
            Alamofire.request(url).responseJSON { (response) in
                defer{self.reloadData()}
                guard let object = response.result.value as? [String:Any] else{
                    print("error")
                    return
                }
                let json = JSON(object)
                json["Items"].forEach({ ( _ ,json) in
                    let book = Book(isbn: json["Item"]["isbn"].string!, title: json["Item"]["title"].string!, author: json["Item"]["author"].string!, salesDate: json["Item"]["salesDate"].string!,itemCaption: json["Item"]["itemCaption"].string!, itemUrl: json["Item"]["itemUrl"].string!,publisherName: json["Item"]["publisherName"].string!, smallImageUrl: json["Item"]["smallImageUrl"].string!, mediumImageUrl: json["Item"]["mediumImageUrl"].string!, largeImageUrl: json["Item"]["largeImageUrl"].string!)
                    
                    self.books.append(book)
                    print(self.books.count)
                })
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as? DetailViewController
        next?.book = passedData
    }
    
    func reloadData(){
        self.bookTableView.reloadData()
    }
    
    func searchKey() -> Bool{
        if self.param == 0 {
            return true
        } else {
            return false
        }
    }
    
    

    




}

