//
//  ImageViewController.swift
//  ListPhotoGallery
//
//  Created by Ionut Baciu on 26/07/2018.
//  Copyright © 2018 Ionut Baciu. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var trailingConstraintIV: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraintIV: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraintIV: NSLayoutConstraint!
    @IBOutlet weak var topConstraintIV: NSLayoutConstraint!
    
    var text = String()
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = self.image
        self.textView.text = self.text
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        scrollView.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(scrollView.bounds.size)
    }
    
    func updateConstraintsForSize(_ size: CGSize) {
        let yOff = max(0, (size.height - imageView.frame.height) / 2.5)
        let xOff = max(0, (size.width - imageView.frame.width) / 2.5)
        
        topConstraintIV.constant = yOff
        bottomConstraintIV.constant = yOff
        leadingConstraintIV.constant = xOff
        trailingConstraintIV.constant = xOff
    }
    
    private func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = 1
        scrollView.zoomScale = minScale
    }
}
