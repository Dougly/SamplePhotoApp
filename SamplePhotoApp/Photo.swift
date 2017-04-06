//
//  Photo.swift
//  SamplePhotoApp
//
//  Created by Douglas Galante on 4/6/17.
//  Copyright © 2017 Dougly. All rights reserved.
//

import UIKit


class Photo {
    
    let thumbnailURLString: String
    let imageURLString: String
    let title: String
    let albumID: Int
    let photoID: Int
    var thumbnail: UIImage?
    var largeImage: UIImage?
    
    init(with dict: [String : Any]) {
        self.thumbnailURLString = dict["url"] as! String
        self.imageURLString = dict["thumbnailUrl"] as! String
        self.title = dict["title"] as! String
        self.albumID = dict["albumId"] as! Int
        self.photoID = dict["id"] as! Int
    }
    
    func downloadThumbnail(with completion: @escaping () -> Void) {
        downloadImage(fromURL: thumbnailURLString) { (thumbnail) in
            self.thumbnail = thumbnail
            completion()
            
        }
    }
    
    func downloadlargeImage(with completion: @escaping () -> Void) {
        downloadImage(fromURL: imageURLString) { (largeImage) in
            self.largeImage = largeImage
            completion()
        }
    }
    
    
    private func downloadImage(fromURL string: String, completion: @escaping (UIImage) -> Void) {
        let url = URL(string: string)
        let session = URLSession.shared
        
        if let url = url {
            session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let data = data {
                    let responseImageData = UIImage(data: data)
                    if let image = responseImageData {
                        completion(image)
                    } else {
                        print("could not convert data to image")
                        completion(#imageLiteral(resourceName: "broken_image"))
                    }
                } else {
                    if let error = error, let response = response {
                        print("didn't recieve data \nERROR: \(error)\nRESPONSE: \(response)")
                    }
                }
            }).resume()
        }
    }
    
    
}
