//
//  ViewController.swift
//  SamplePhotoApp
//
//  Created by Douglas Galante on 4/6/17.
//  Copyright © 2017 Dougly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let dataStore = DataStore.sharedInstance
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataStore.getJSON() {
            self.dataStore.appendNext500Photos {
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    self.collectionView.reloadData()
                }
            }
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Get serializedJason for first 500 photos
        
        
        

    }
    
    
    
    


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("calling number of items in section: \(dataStore.photos.count)")

        return dataStore.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        
        let photo = dataStore.photos[indexPath.row]
        if let thumbnail = photo.thumbnail {
            cell.activityIndicatorView.stopAnimating()
            cell.imageView.image = thumbnail
        } else {
            photo.downloadThumbnail {
                DispatchQueue.main.async {
                    cell.activityIndicatorView.stopAnimating()
                    cell.imageView.image = photo.thumbnail
                }
            }
        }
        return cell
    }
    
}

