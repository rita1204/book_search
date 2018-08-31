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
   
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var publisherLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var addRemoveBtn: UIButton!
    @IBOutlet weak var memoTableView: UITableView!

    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let bookRequest = NSFetchRequest<BookData>(entityName: "BookData")
    let memoRequest = NSFetchRequest<Memo>(entityName: "Memo")
    var bookData: BookData?
    private var memos = [Memo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoTableView.delegate = self
        memoTableView.dataSource = self
        memoTableView.estimatedRowHeight = 90
        memoTableView.rowHeight = UITableViewAutomaticDimension
        let rightBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addMemo) )
        navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memos.removeAll()
        //convert NSSet to Array
        memos = Array(bookData!.memo!) as! [Memo]
        memoTableView.reloadData()
    }
    
    @IBAction func openBrowser(_ sender: Any) {
        let url = URL(string: (bookData?.url)!)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func removeData(_ sender: Any) {
        bookRequest.predicate = NSPredicate(format: "title = %@", (bookData?.title)!)
        let result:Bool = deleteBook(request: bookRequest)
        if result == true {
            let banner = NotificationBanner(title: "本棚から削除されました！",style: .danger)
            banner.show()
            self.performSegue(withIdentifier: "unwind", sender: nil)
        } else {
            let banner = NotificationBanner(title: "削除に失敗しました",style: .warning)
            banner.show()
        }
    }
    
    @objc func addMemo(_ sender:UIBarButtonItem) {
        performSegue(withIdentifier: "toMemo", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as? memoVC
        next?.bookData = bookData
    }

    func setData() {
        bookImage.load(url: URL(string: (bookData?.image)!)!)
        titleLbl.text = bookData?.title
        authorLbl.text = bookData?.author
        publisherLbl.text = bookData?.publisher
        dateLbl.text = bookData?.date
    }
    
    func deleteMemo(request: NSFetchRequest<Memo>)-> Bool {
        do {
            let objects = try context.fetch(request)
            for object in objects {
                context.delete(object)
            }
            try context.save()
            return true
        } catch let error as NSError {
            print(error)
            return false
        }
    }
}

extension bookShelfVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = memoTableView.dequeueReusableCell(withIdentifier: "memoCell") as! memoCell
        cell.pageLbl.text = "page:" + (memos[indexPath.row].page! as! String)
        cell.contentLbl.text = memos[indexPath.row].content

        if let image = UIImage(named: memos[indexPath.row].icon!) {
            cell.memoIcon.image = image
        } else {
            cell.memoIcon.image = UIImage(named: "risu")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let memoContent = memos[indexPath.row].content
            memos.remove(at: indexPath.row)
            memoRequest.predicate = NSPredicate(format: "content = %@", memoContent!)
            let result = deleteMemo(request: memoRequest)
            if result == true {
               memoTableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                let banner = NotificationBanner(title: "削除に失敗しました",style: .warning)
                banner.show()
            }
        }
    }
    
}
