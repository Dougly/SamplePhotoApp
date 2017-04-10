//
//  ImageCollectionViewCell.swift
//  SamplePhotoApp
//
//  Created by Douglas Galante on 4/6/17.
//  Copyright © 2017 Dougly. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(activityIndicatorView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
        imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        activityIndicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
    }
    
}
