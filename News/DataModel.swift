//
//  DataModel.swift
//  News
//
//  Created by 李超逸 on 2018/02/23.
//  Copyright © 2018 李超逸. All rights reserved.
//

import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: ArticleSource
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
}

struct ArticleSource: Codable {
    let name: String
}
