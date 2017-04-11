//
//  DetailViewController.swift
//  SamplePhotoApp
//
//  Created by Douglas Galante on 4/11/17.
//  Copyright © 2017 Dougly. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let dataStore = DataStore.sharedInstance
    var delegate: GetPhotoDataDelegate!
    var photoIndex: Int!
    @IBOutlet var detailView: DetailView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setImage(with: photoIndex)
        setGestureRecognizers()
    }
    
    
    func setImage(with index: Int) {
        let photo = dataStore.photos[index]
        detailView.imageView.image = photo.thumbnail
        detailView.detailLabel.text = photo.title
        getImage(with: photo)
    }
    
    
    func getImage(with photo: Photo) {
        if photo.largeImage == nil {
            photo.downloadlargeImage {
                DispatchQueue.main.async {
                    self.detailView.imageView.image = photo.largeImage!
                    self.detailView.activityIndicator.stopAnimating()
                }
            }
        } else {
            detailView.imageView.image = photo.largeImage
            detailView.activityIndicator.stopAnimating()
        }
    }
    
    
    func xButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func changeImage(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right && photoIndex > 0 {
            self.photoIndex! -= 1
            setImage(with: self.photoIndex!)
        } else if sender.direction == .left && photoIndex < dataStore.photos.count - 1 {
            self.photoIndex! += 1
            setImage(with: self.photoIndex!)
        } else if sender.direction == .left && photoIndex < dataStore.serializedJSON.count - 1 {
            delegate.getNextBatch { success in
                if success {
                    self.photoIndex! += 1
                    self.setImage(with: self.photoIndex!)
                }
            }
        }
    }
    
    
    func hideLabelAndX() {
        if detailView.xButton.alpha == 1 {
            UIView.animate(withDuration: 0.3) {
                self.detailView.xButton.alpha = 0
                self.detailView.detailLabel.alpha = 0
                self.view.layoutIfNeeded()
            }
            
        } else {
            UIView.animate(withDuration: 0.3) {
                self.detailView.xButton.alpha = 1
                self.detailView.detailLabel.alpha = 1
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    func setGestureRecognizers() {
        detailView.xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(xButtonTapped))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(xButtonTapped))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(changeImage))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(changeImage))
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(hideLabelAndX))
        
        downSwipe.direction = .down
        upSwipe.direction = .up
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        detailView.addGestureRecognizer(downSwipe)
        detailView.addGestureRecognizer(upSwipe)
        detailView.addGestureRecognizer(leftSwipe)
        detailView.addGestureRecognizer(rightSwipe)
        detailView.addGestureRecognizer(tapGR)
    }
}
