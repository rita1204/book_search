//
//  Book.swift
//  book_api_search
//
//  Created by TAKUTO on 2018/08/25.
//  Copyright © 2018年 TAKUTO. All rights reserved.
//

import Foundation


struct Book {
    let isbn: String
    let title: String
    let author: String
    let salesDate: String
    let itemCaption: String?
    let itemUrl: String
    let publisherName: String
    let smallImageUrl: String?
    let mediumImageUrl: String?
    let largeImageUrl: String?
}
