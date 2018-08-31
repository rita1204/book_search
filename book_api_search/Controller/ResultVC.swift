//
//  ResultController.swift
//  book_api_search
//
//  Created by TAKUTO on 2018/08/27.
//  Copyright © 2018年 TAKUTO. All rights reserved.
//

import UIKit

class ResultVC: UIViewController{
    @IBOutlet weak var bookTableView: UITableView!
    var books:[Book]?
    var passedData:Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookTableView.dataSource = self
        bookTableView.delegate = self
        bookTableView.estimatedRowHeight = 85
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as? DetailVC
        next?.book = passedData
    }
    
}

extension ResultVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookTableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! ListCell
        let book = books![indexPath.row]
        cell.bookTitle.text = book.title
        cell.bookAuthor.text = book.author
        cell.bookImage.load(url: URL(string: book.smallImageUrl!)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        passedData = books?[indexPath.row]
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
}

