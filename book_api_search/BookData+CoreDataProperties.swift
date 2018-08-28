//
//  BookData+CoreDataProperties.swift
//  book_api_search
//
//  Created by TAKUTO on 2018/08/27.
//  Copyright © 2018年 TAKUTO. All rights reserved.
//
//

import Foundation
import CoreData


extension BookData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookData> {
        return NSFetchRequest<BookData>(entityName: "BookData")
    }

    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var image: String?
    @NSManaged public var caption: String?
    @NSManaged public var url: String?
    @NSManaged public var date: String?
    @NSManaged public var publisher: String?

}
