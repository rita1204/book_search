//
//  DetailViewController.swift
//  book_api_search
//
//  Created by TAKUTO on 2018/08/26.
//  Copyright © 2018年 TAKUTO. All rights reserved.
//

import UIKit
import CoreData
import NotificationBannerSwift

class DetailVC: UIViewController {
    var book:Book?
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var publisherLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var captionLbl: UILabel!
    @IBOutlet weak var addRemoveBtn: UIButton!
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<BookData>(entityName: "BookData")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    override func viewWillAppear(_ animated: Bool) {
        changeBtnState()
    }
    
    @IBAction func addRemoveData(_ sender: Any) {
        if bookExists() == false {
            let favorite = NSEntityDescription.insertNewObject(forEntityName: "BookData", into: context) as! BookData
            
            saveData(data: favorite, book: self.book!)
            let banner = NotificationBanner(title: "本棚に追加されました！", style: .success)
            banner.show()
            changeBtnState()
            
        }
        else {
            request.predicate = NSPredicate(format: "title = %@", (book?.title)!)
            
            let result:Bool = deleteData(request: request)
            if result == true {
                let banner = NotificationBanner(title: "本棚から削除されました！",style: .danger)
                banner.show()
                changeBtnState()
            } else {
                let banner = NotificationBanner(title: "削除に失敗しました",style: .warning)
                banner.show()
            }
            
        }
    }
    
    
    func changeBtnState() {
        if bookExists() == true {
            let removeAttributes:[NSAttributedStringKey: Any] = [.foregroundColor: UIColor.red]
            let btnTitle = NSAttributedString(string: "- 本棚から削除する", attributes: removeAttributes)
            addRemoveBtn.setAttributedTitle(btnTitle, for: .normal)
        } else {
            let addAttributes:[NSAttributedStringKey: Any] = [.foregroundColor: UIColor.blue]
            let btnTitle = NSAttributedString(string: "+本棚に追加する", attributes: addAttributes)
            addRemoveBtn.setAttributedTitle(btnTitle, for: .normal)
        }
    }
    
    func bookExists() -> Bool {
        request.predicate = NSPredicate(format: "title = %@", (book?.title)!)
        let count = try! context.count(for: request)
        let exists = count == 0 ? false : true
        return exists
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


