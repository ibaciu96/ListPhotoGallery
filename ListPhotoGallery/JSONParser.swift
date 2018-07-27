//
//  JSONParser.swift
//  ListPhotoGallery
//
//  Created by Ionut Baciu on 24/07/2018.
//  Copyright © 2018 Ionut Baciu. All rights reserved.
//
import Foundation

class JSONParser {
    
    private var photosArray = [Photo]()
    
    func fetchData(completion: @escaping(Photos) -> ()) {
        let url = URL(string: "https://www.mocky.io/v2/5b584374300000ff05fe4e29")
        URLSession.shared.dataTask(with: url!) { (data, response, error ) in
            if error != nil {
                print(error!)
            } else {
                guard let urlContent = data else { return }
                do {
                    let photos = try JSONDecoder().decode(Photos.self, from: urlContent)
                    DispatchQueue.main.async {
                        completion(photos)
                    }
                } catch {
                    print("Json Processing Failed")
                }
            }
        }.resume()
    }
}
