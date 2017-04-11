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
    
    let screenWidth = UIScreen.main.bounds.width
    var spacing: CGFloat!
    var sectionInsets: UIEdgeInsets!
    var size: CGSize!
    var numberOfCellsPerRow: CGFloat = 3
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        dataStore.getJSON() { success in
            if success {
                self.dataStore.appendNext500Photos {
                    DispatchQueue.main.async {
                        self.activityIndicatorView.stopAnimating()
                        self.collectionView.reloadData()
                    }
                }
            } else {
                self.activityIndicatorView.stopAnimating()
                // TODO: -show error image
            }
        }
    }
    


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataStore.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        
        let photo = dataStore.photos[indexPath.row]
        
        if let selectedIndexPath = selectedIndexPath {
            
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
    
    
    
    //let cellContentView = collectionView.cellForItemAtIndexPath(indexPath)?.contentView
    //let rect = cellContentView!.convertRect(cellContentView!.frame, toView: self.view)
    //addView.center = CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2)
    
    
}

// TODO: -set layout for collection view
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    
    
    func configureLayout () {
        spacing = 5
        let itemWidth = (screenWidth / numberOfCellsPerRow) - (spacing * 4 / 3)
        let itemHeight = itemWidth
        sectionInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        size = CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if selectedIndexPath == indexPath {
            return collectionView.frame.size
        } else {
            return size
        }
    }
    

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

}



