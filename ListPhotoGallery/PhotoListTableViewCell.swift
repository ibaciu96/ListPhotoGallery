//
//  PhotoListTableViewCell.swift
//  ListPhotoGallery
//
//  Created by Ionut Baciu on 24/07/2018.
//  Copyright © 2018 Ionut Baciu. All rights reserved.
//

import UIKit

class PhotoListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageViewCell: UIImageView!
    let imageCache = ImagesManager()
    
    func setPhoto(photo: Photo) {
        imageCache.get()
        
        setImage(photo: photo)
        
        nameLabel.text = photo.name
        
        if let text = photo.description {
            descriptionLabel.text = text
        } else {
            descriptionLabel.text = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: photo.createdAt) {
            let newFormatter = DateFormatter()
            newFormatter.dateFormat = "dd/MM/yyyy"
            dateLabel.text = newFormatter.string(from: date)
        } else {
            dateLabel.text = ""
        }
        
        imageCache.save()
    }
    
    func setImage(photo: Photo) {
        getImageFromURL(from: photo.imageURL) { [weak self] (image) in
            self?.imageViewCell.image = image
        }
    }
    
    func getImageFromURL(from url: String, completion: @escaping(UIImage) -> ()) {
        DispatchQueue.global().async {
            if let cachedImage = self.imageCache.getFromCache(with: url) {
                DispatchQueue.main.async {
                    completion(cachedImage)
                }
            } else {
                if let imageURL = URL(string: url) {
                    if let data = try? Data(contentsOf: imageURL) {
                        if let image = UIImage(data: data) {
                            self.imageCache.addToCache(put: image, with: url)
                            DispatchQueue.main.async {
                                completion(image)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getData() -> (String?, UIImage?) {
        return (nameLabel.text, imageViewCell.image)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
