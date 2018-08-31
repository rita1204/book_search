//
//  Memo+CoreDataProperties.swift
//  book_api_search
//
//  Created by TAKUTO on 2018/08/30.
//  Copyright © 2018年 TAKUTO. All rights reserved.
//
//

import Foundation
import CoreData


extension Memo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memo> {
        return NSFetchRequest<Memo>(entityName: "Memo")
    }

    @NSManaged public var content: String?
    @NSManaged public var page: NSObject?
    @NSManaged public var urlKey: String?
    @NSManaged public var icon: String?
    @NSManaged public var belong_to: BookData?

}
