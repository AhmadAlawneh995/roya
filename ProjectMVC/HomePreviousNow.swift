//
//  HomeData.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/9/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import Foundation


// MARK: - HomeModel
class HomeModel: Codable {
    let homepageID: Int?
    let elementType: String?
    let elementTitle: JSONNull?
    let items: Items?

    enum CodingKeys: String, CodingKey {
        case homepageID = "homepage_id"
        case elementType = "element_type"
        case elementTitle = "element_title"
        case items
    }

    init(homepageID: Int?, elementType: String?, elementTitle: JSONNull?, items: Items?) {
        self.homepageID = homepageID
        self.elementType = elementType
        self.elementTitle = elementTitle
        self.items = items
    }
}

// MARK: - Items
class Items: Codable {
    let previous, now, next, later: Later?

    init(previous: Later?, now: Later?, next: Later?, later: Later?) {
        self.previous = previous
        self.now = now
        self.next = next
        self.later = later
    }
}

// MARK: - Later
class Later: Codable {
    let timestamp: Int?
    let programs: Programs?

    init(timestamp: Int?, programs: Programs?) {
        self.timestamp = timestamp
        self.programs = programs
    }
}

// MARK: - Programs
class Programs: Codable {
    let programID: Int?
    let name: String?
    let imageURL: String?
    let reachable: Bool?

    enum CodingKeys: String, CodingKey {
        case programID = "program_id"
        case name
        case imageURL = "image_url"
        case reachable
    }

    init(programID: Int?, name: String?, imageURL: String?, reachable: Bool?) {
        self.programID = programID
        self.name = name
        self.imageURL = imageURL
        self.reachable = reachable
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
