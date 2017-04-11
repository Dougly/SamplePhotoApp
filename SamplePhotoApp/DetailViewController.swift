//
//  DetailViewController.swift
//  SamplePhotoApp
//
//  Created by Douglas Galante on 4/11/17.
//  Copyright © 2017 Dougly. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var photo: Photo?
    
    @IBOutlet var detailView: DetailView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let photo = photo {
            detailView.imageView.image = photo.thumbnail
            detailView.detailLabel.text = photo.title
        }
        getImage()
        detailView.xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)
            
        
        let swipeGR = UISwipeGestureRecognizer(target: self, action: #selector(xButtonTapped))
        swipeGR.direction = .down
        detailView.addGestureRecognizer(swipeGR)
    }
    
    
    func getImage() {
        if let photo = photo {
            if photo.largeImage == nil {
                photo.downloadlargeImage {
                    DispatchQueue.main.async {
                        self.detailView.imageView.image = self.photo?.largeImage!
                        self.detailView.activityIndicator.stopAnimating()
                    }
                }
            } else {
                detailView.imageView.image = photo.largeImage
                detailView.activityIndicator.stopAnimating()
            }
        }
    }
    
    func xButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
