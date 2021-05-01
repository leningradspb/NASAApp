//
//  SearchModels.swift
//  NASAApp
//
//  Created by Eduard Sinyakov on 01.05.2021.
//

import Foundation

struct SearchModel: Decodable {
    let collection: SearchCollection?
}

struct SearchCollection: Decodable {
    let metadata: Metadata?
    let items: [Item]?
}

struct Metadata: Decodable {
    let total_hits: Int?
}

struct Item: Decodable {
    let links: [Link]?
    let data: [SearchData]?
}

struct Link: Decodable {
    let href: String?
}

struct SearchData: Decodable {
    let title, description, date_created: String?
}
