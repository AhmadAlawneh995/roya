//
//  ArticlesModel.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/10/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import Foundation



// MARK: - Article
struct Article: Codable {
    let category, title: String?
    let imageURL: String?
    let id, categoryID: Int?
    let publishedAt: String?

    enum CodingKeys: String, CodingKey {
        case category, title
        case imageURL = "image_url"
        case id
        case categoryID = "category_id"
        case publishedAt = "published_at"
    }
}

typealias Articles = [Article]
