//
//  BookData+CoreDataClass.swift
//  book_api_search
//
//  Created by TAKUTO on 2018/08/28.
//  Copyright © 2018年 TAKUTO. All rights reserved.
//
//

import UIKit
import CoreData



public class BookData: NSManagedObject {

}

private var appDelegate = UIApplication.shared.delegate as! AppDelegate
private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
func saveData(data:BookData,book:Book) {
    data.title = book.title
    data.author = book.author
    data.date = book.salesDate
    data.image = book.largeImageUrl
    data.publisher = book.publisherName
    data.caption = book.itemCaption
    data.url = book.itemUrl
    appDelegate.saveContext()
}

func deleteData(request: NSFetchRequest<BookData>)-> Bool {
    
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
