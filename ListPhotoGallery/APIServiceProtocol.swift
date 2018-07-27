//
//  APIServiceProtocol.swift
//  ListPhotoGallery
//
//  Created by Ionut Baciu on 24/07/2018.
//  Copyright © 2018 Ionut Baciu. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    case noNetwork = "No Network"
    case serviceOverload = "Server is overloaded"
    case permissionDenied = "You don't have permission"
}

protocol APIServiceProtocol {
    func fetchPhoto(complete: @escaping(_ success: Bool, _ photos: [Photo], _ error: APIError?) -> ())
}
