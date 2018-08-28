//
//  ResultController.swift
//  book_api_search
//
//  Created by TAKUTO on 2018/08/27.
//  Copyright © 2018年 TAKUTO. All rights reserved.
//

import UIKit

class ResultVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var bookTableView: UITableView!
    var books:[Book]?
    var passedData:Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookTableView.dataSource = self
        bookTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookTableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        cell.textLabel?.text = books![indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        passedData = books?[indexPath.row]
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as? DetailVC
        next?.book = passedData
    }

    



}
