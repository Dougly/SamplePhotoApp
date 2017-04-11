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
    var spacing: CGFloat!
    var sectionInsets: UIEdgeInsets!
    var itemSize: CGSize!
    var numberOfCellsPerRow: CGFloat = 3
    var selectedPhotoIndex = -1
    var hitBottomOfScrollView = false
    fileprivate let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        getPhotoData()
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(getPhotoData), for: .valueChanged)
    }
    
    func getPhotoData() {
        dataStore.getJSON { success in
            if success {
                self.dataStore.photos = []
                self.dataStore.appendNext30Photos {
                    DispatchQueue.main.async {
                        self.activityIndicatorView.stopAnimating()
                        self.refreshControl.endRefreshing()
                        self.collectionView.reloadData()
                    }
                }
            } else {
                if self.dataStore.photos.isEmpty {
                    // TODO: - put image error up
                }
                self.activityIndicatorView.stopAnimating()
                self.refreshControl.endRefreshing()
            }
        }
    }

}




extension ViewController: GetPhotoDataDelegate {
    
    
    func getNextBatch(with completion: @escaping (Bool) -> Void) {
        dataStore.appendNext30Photos {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.hitBottomOfScrollView = false
                completion(true)
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

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + 1) >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            if !hitBottomOfScrollView {
                hitBottomOfScrollView = true
                dataStore.appendNext30Photos {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.hitBottomOfScrollView = false
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPhotoIndex = indexPath.row
        self.performSegue(withIdentifier: "presentDetailView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentDetailView" {
            let destination = segue.destination as! DetailViewController
            destination.photoIndex = selectedPhotoIndex
            destination.delegate = self
        }
    }
}




extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func configureLayout () {
        spacing = 5
        let itemWidth = (UIScreen.main.bounds.width / numberOfCellsPerRow) - (spacing * 4 / 3)
        let itemHeight = itemWidth
        sectionInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
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



