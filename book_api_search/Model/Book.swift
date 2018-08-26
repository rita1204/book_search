//
//  Book.swift
//  book_api_search
//
//  Created by TAKUTO on 2018/08/25.
//  Copyright © 2018年 TAKUTO. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Book {
    let isbn: String
    let title: String
    let author: String
    let salesDate: String
    let itemCaption: String
    let itemUrl: String
    let publisherName: String
    let smallImageUrl: String?
    let mediumImageUrl: String?
    let largeImageUrl: String?
}




//struct Book: Codable {
//    let title: String
//    let titleKana : String?
//    let subTitle: String?
//    let subTitleKana: String?
//    let seriesName: String?
//    let seriesNameKana: String?
//    let contents: String?
//    let author: String
//    let authorKana: String?
//    let publisherName: String
//    let size: String
//    let isbn: String
//    let itemCapition: String
//    let salesDate: String
//    let itemPrice: Int
//    let listPrice: Int
//    let discountRate: Int
//    let discountPrice: Int
//    let itemUrl: String
//    let affiliateUrl: String?
//    let smallImageUrl: String?
//    let mediumImageUrl: String?
//    let largeImageUrl: String?
//    let chirayomiUrl: String?
//    let availability: String
//    let postageFlag: Int
//    let limitedFlag: Int
//    let reviewAverage: String?
//    let booksGenreId: String
//
//}
