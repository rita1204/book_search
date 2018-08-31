//
//  memoVC.swift
//  book_api_search
//
//  Created by TAKUTO on 2018/08/30.
//  Copyright © 2018年 TAKUTO. All rights reserved.
//

import UIKit
import CoreData

class memoVC: UIViewController {

    @IBOutlet weak var pageField: UITextField!
    @IBOutlet weak var contentField: UITextView!
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var bookData:BookData?
    let icons = ["risu","inu","sakana","arupaka","usa","ebi","ushi"]
    
    @IBAction func saveBtn(_ sender: Any) {
        let memo = Memo(context: context)
        memo.page = pageField.text! as NSObject
        memo.content = contentField.text
        memo.urlKey = bookData?.url
        let random = Int(arc4random_uniform(6))
        memo.icon = icons[random]
        bookData?.addToMemo(memo)
        appDelegate.saveContext()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextview()
    }
    
    func setTextview(){
        let color = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        contentField.layer.borderColor = color
        contentField.layer.borderWidth = 0.5
        contentField.layer.cornerRadius = 5
    }
    



}
