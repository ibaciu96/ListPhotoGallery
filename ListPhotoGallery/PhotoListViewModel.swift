//
//  PhotoListViewModel.swift
//  ListPhotoGallery
//
//  Created by Ionut Baciu on 26/07/2018.
//  Copyright © 2018 Ionut Baciu. All rights reserved.
//

import Foundation

class PhotoListViewModel {
    private var parser = JSONParser()
    var photos: [Photo] = [Photo]() {
        didSet {
            self.reloadTableViewC?()
        }
    }
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    var numberOfCells: Int {
        return photos.count
    }
    var selectedPhoto: Photo?
    var reloadTableViewC: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    
    func initFetch() {
        self.isLoading = true
        parser.fetchData(completion: { [weak self] (photos) in
            self?.isLoading = false
            for photo in photos.photos {
                self?.photos.append(photo)
            }
        })
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> Photo {
        return photos[indexPath.row]
    }
}
