//
//  HomeNewsModel.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/10/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import Foundation


// MARK: - HomeNewsModelElement
class HomeNewsModelElement: Codable {
    let elementTitle: String?
    let elementType: ElementType?
    let items: [Item]?
    let homepageID: Int?

    enum CodingKeys: String, CodingKey {
        case elementTitle = "element_title"
        case elementType = "element_type"
        case items
        case homepageID = "homepage_id"
    }

    init(elementTitle: String?, elementType: ElementType?, items: [Item]?, homepageID: Int?) {
        self.elementTitle = elementTitle
        self.elementType = elementType
        self.items = items
        self.homepageID = homepageID
    }
}

enum ElementType: String, Codable {
    case latestEpisode = "latest_episode"
    case row = "row"
}

// MARK: - Item
class Item: Codable {
    let links: Links?
    let imageURL: String?
    let rowID: Int?
    let name: String?
    let royaColor: RoyaColor?

    enum CodingKeys: String, CodingKey {
        case links
        case imageURL = "image_url"
        case rowID = "row_id"
        case name
        case royaColor = "roya_color"
    }

    init(links: Links?, imageURL: String?, rowID: Int?, name: String?, royaColor: RoyaColor?) {
        self.links = links
        self.imageURL = imageURL
        self.rowID = rowID
        self.name = name
        self.royaColor = royaColor
    }
}

// MARK: - Links
class Links: Codable {
    let type: TypeEnum?
    let value: String?

    init(type: TypeEnum?, value: String?) {
        self.type = type
        self.value = value
    }
}

enum TypeEnum: String, Codable {
    case eps = "EPS"
    case pro = "PRO"
}

enum RoyaColor: String, Codable {
    case dd4801 = "#dd4801"
    case the00085D = "#00085d"
    case the018D87 = "#018d87"
    case the117F0E = "#117f0e"
    case the535353 = "#535353"
    case the771055 = "#771055"
    case the8E0101 = "#8e0101"
}

typealias HomeNewsModel = [HomeNewsModelElement]
