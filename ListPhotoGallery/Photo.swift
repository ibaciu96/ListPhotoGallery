//
//  Photo.swift
//  ListPhotoGallery
//
//  Created by Ionut Baciu on 24/07/2018.
//  Copyright © 2018 Ionut Baciu. All rights reserved.
//

import Foundation

struct Photos: Decodable {
    var photos = [Photo]()
}

struct Photo: Decodable {
    var id: Int
    var name: String
    var description: String?
    var createdAt: String
    var imageURL: String
    var forSale: Bool
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case createdAt = "created_at"
        case imageURL = "image_url"
        case forSale = "for_sale"
    }
    
    
    mutating func update(id: Int, name: String, description: String?, date: String, url: String, forSale: Bool) {
        self.id = id
        self.name = name
        self.description = description ?? ""
        self.createdAt = date
        self.imageURL = url
        self.forSale = forSale
    }
    
    func prinDetails() {
        print("\(self.name) with url \(self.imageURL)")
    }
}
