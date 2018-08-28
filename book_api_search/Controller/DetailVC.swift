//
//  DetailViewController.swift
//  book_api_search
//
//  Created by TAKUTO on 2018/08/26.
//  Copyright © 2018年 TAKUTO. All rights reserved.
//

import UIKit
import CoreData

class DetailVC: UIViewController {
    var book:Book?
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var publisherLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var captionLbl: UILabel!
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    
    func setData(){
        bookImage.load(url: URL(string: (book?.largeImageUrl)!)!)
        titleLbl.text = book?.title
        authorLbl.text = book?.author
        publisherLbl.text = book?.publisherName
        dateLbl.text = book?.salesDate
        captionLbl.text = book?.itemCaption
    }
    


}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
