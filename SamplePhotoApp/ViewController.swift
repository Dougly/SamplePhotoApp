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
    var selectedIndexPath: IndexPath? = nil
    
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

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataStore.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        
        let photo = dataStore.photos[indexPath.row]
        
        
        if selectedIndexPath == indexPath {
            
            if let largeImage = photo.largeImage {
                cell.imageView.image = largeImage
            } else {
                photo.downloadlargeImage {
                    DispatchQueue.main.async {
                        cell.imageView.image = photo.largeImage
                    }
                }
            }
            
        } else {
            
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
        }
        
       
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPath != nil {
            selectedIndexPath = nil
            collectionView.performBatchUpdates({
                self.collectionView.setCollectionViewLayout(collectionView.collectionViewLayout, animated: true, completion: nil)
            }, completion: { success in
                collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
            })
        } else {
            selectedIndexPath = indexPath
            collectionView.performBatchUpdates({
                self.collectionView.setCollectionViewLayout(collectionView.collectionViewLayout, animated: true, completion: nil)
            }, completion: { (success) in
                collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if selectedIndexPath == indexPath {
            return collectionView.frame.size
        } else {
            return CGSize(width: 100, height: 100)
        }
    }
    
    //let cellContentView = collectionView.cellForItemAtIndexPath(indexPath)?.contentView
    //let rect = cellContentView!.convertRect(cellContentView!.frame, toView: self.view)
    //addView.center = CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2)
    
    
}




