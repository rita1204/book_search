//
//  BookData+CoreDataProperties.swift
//  book_api_search
//
//  Created by TAKUTO on 2018/08/30.
//  Copyright © 2018年 TAKUTO. All rights reserved.
//
//

import Foundation
import CoreData


extension BookData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookData> {
        return NSFetchRequest<BookData>(entityName: "BookData")
    }

    @NSManaged public var author: String?
    @NSManaged public var caption: String?
    @NSManaged public var date: String?
    @NSManaged public var image: String?
    @NSManaged public var publisher: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var memo: NSSet?

}

// MARK: Generated accessors for memo
extension BookData {

    @objc(addMemoObject:)
    @NSManaged public func addToMemo(_ value: Memo)

    @objc(removeMemoObject:)
    @NSManaged public func removeFromMemo(_ value: Memo)

    @objc(addMemo:)
    @NSManaged public func addToMemo(_ values: NSSet)

    @objc(removeMemo:)
    @NSManaged public func removeFromMemo(_ values: NSSet)

}
