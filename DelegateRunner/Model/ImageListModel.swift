//
//  ImageListModel.swift
//  DelegateRunner
//
//  Created by YUSUF KESKİN on 11.04.2024.
//

import Foundation

struct ImageListModel: Codable {
    let id: String?
    let author: Author?
    let width, height: Int?
    let url, downloadURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}

enum Author: String, Codable {
    case alejandroEscamilla = "Alejandro Escamilla"
}

typealias ImageListModels = [ImageListModel]
