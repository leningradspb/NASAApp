//
//  PictureOfDayModel.swift
//  NASAApp
//
//  Created by Eduard Sinyakov on 10.04.2021.
//

import Foundation

struct PictureOfDayModel: Decodable {
    let copyright: String?
    let date: String?
    let explanation: String?
    let url: String?
    let title: String?
}
