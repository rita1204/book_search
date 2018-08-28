//
//  bookShelfVC.swift
//  book_api_search
//
//  Created by TAKUTO on 2018/08/28.
//  Copyright © 2018年 TAKUTO. All rights reserved.
//

import UIKit
import CoreData
import NotificationBannerSwift

class bookShelfVC: UIViewController {
    var bookData: BookData?
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
    
    @IBAction func removeData(_ sender: Any) {
        request.predicate = NSPredicate(format: "title = %@", (bookData?.title)!)
        let result:Bool = deleteData(request: request)
        if result == true {
            let banner = NotificationBanner(title: "本棚から削除されました！",style: .danger)
            banner.show()
            self.performSegue(withIdentifier: "unwind", sender: nil)
        } else {
            let banner = NotificationBanner(title: "削除に失敗しました",style: .warning)
            banner.show()
        }
    }

    
    func setData() {
        bookImage.load(url: URL(string: (bookData?.image)!)!)
        titleLbl.text = bookData?.title
        authorLbl.text = bookData?.author
        publisherLbl.text = bookData?.publisher
        dateLbl.text = bookData?.date
        captionLbl.text = bookData?.caption
    }


}
