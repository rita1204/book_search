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
    let request = NSFetchRequest<BookData>(entityName: "BookData")
    var bookData: BookData?
    var memos = [Memo]()

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


}

extension bookShelfVC : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = memoTableView.dequeueReusableCell(withIdentifier: "memoCell") as! memoCell
        cell.pageLbl.text = "page:" + memos[indexPath.row].page!
        cell.contentLbl.text = memos[indexPath.row].content
        cell.memoIcon = UIImageView(image: UIImage(named: "risu"))
        return cell
    }
    
}
