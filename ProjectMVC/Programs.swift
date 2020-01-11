//
//  Programs.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/9/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import Foundation
// MARK: - ProgramModel
struct ProgramModel: Codable {
    let category: [Category]?
}

// MARK: - Category
struct Category: Codable {
    let categoryID: Int?
    let name: String?
    let programs: [Program]?
    let subcategory: [Subcategory]?

    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case name, programs, subcategory
    }
}

// MARK: - Program
struct Program: Codable {
    let programID: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case programID = "program_id"
        case image
    }
}

// MARK: - Subcategory
struct Subcategory: Codable {
    let subCategoryID: Int?
    let name: String?
    let programs: [Program]?

    enum CodingKeys: String, CodingKey {
        case subCategoryID = "subCategory_id"
        case name, programs
    }
}
