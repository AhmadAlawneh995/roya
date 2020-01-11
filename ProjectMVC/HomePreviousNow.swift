//
//  HomeData.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/9/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import Foundation


// MARK: - HomeModel
struct HomeModel: Codable {
    let elementType: String?
    let items: Items?
    let homepageID: Int?
    let elementTitle: JSONNull?

    enum CodingKeys: String, CodingKey {
        case elementType = "element_type"
        case items
        case homepageID = "homepage_id"
        case elementTitle = "element_title"
    }
}

// MARK: - Items
struct Items: Codable {
    let the0: JSONNull?
    let previous, now: Now?

    enum CodingKeys: String, CodingKey {
        case the0 = "0"
        case previous, now
    }
}

// MARK: - Now
struct Now: Codable {
    let programs: Programs?
    let timestamp: Int?
}

// MARK: - Programs
struct Programs: Codable {
    let reachable: Bool?
    let programID: Int?
    let imageURL: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case reachable
        case programID = "program_id"
        case imageURL = "image_url"
        case name
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
