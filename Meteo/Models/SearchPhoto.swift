//
//  SearchPhoto.swift
//  Meteo
//
//  Created by Jeoffrey Thirot on 21/02/2019.
//  Copyright © 2019 Jeoffrey Thirot. All rights reserved.
//

import Foundation

class SearchPhoto: Codable, Serializable {
    let total, totalPages: Int
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
    
    init(total: Int, totalPages: Int, results: [Result]) {
        self.total = total
        self.totalPages = totalPages
        self.results = results
    }
}

class Result: Codable {
    let id: String
    let width, height: Int
    let color, description: String
    let urls: Urls
    let links: ResultLinks
    let tags, photoTags: [Tag]
    
    enum CodingKeys: String, CodingKey {
        case id
        case width, height, color, description, urls, links
        case tags
        case photoTags = "photo_tags"
    }
    
    init(id: String, width: Int, height: Int, color: String, description: String, urls: Urls, links: ResultLinks, tags: [Tag], photoTags: [Tag]) {
        self.id = id
        self.width = width
        self.height = height
        self.color = color
        self.description = description
        self.urls = urls
        self.links = links
        self.tags = tags
        self.photoTags = photoTags
    }
}

class ResultLinks: Codable {
    let linksSelf, html, download, downloadLocation: String
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
    
    init(linksSelf: String, html: String, download: String, downloadLocation: String) {
        self.linksSelf = linksSelf
        self.html = html
        self.download = download
        self.downloadLocation = downloadLocation
    }
}

class Tag: Codable {
    let title: String
    
    init(title: String) {
        self.title = title
    }
}

class Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
    
    init(raw: String, full: String, regular: String, small: String, thumb: String) {
        self.raw = raw
        self.full = full
        self.regular = regular
        self.small = small
        self.thumb = thumb
    }
}
