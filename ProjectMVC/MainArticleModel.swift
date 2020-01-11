//
//  MainArticleModel.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/9/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import Foundation

// MARK: - MainArticleM
struct MainArticleModel: Codable {
    let category, title, publishedAt: String?
    let id: Int?
    let imageURL: String?
    let categoryID: Int?

    enum CodingKeys: String, CodingKey {
        case category, title
        case publishedAt = "published_at"
        case id
        case imageURL = "image_url"
        case categoryID = "category_id"
    }
}
