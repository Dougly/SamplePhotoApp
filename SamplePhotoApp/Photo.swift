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
    
    init(with JSON: [String : Any]) {
        self.thumbnailURLString = JSON["url"] as! String
        self.imageURLString = JSON["thumbnailUrl"] as! String
        self.title = JSON["title"] as! String
        self.albumID = JSON["albumId"] as! Int
        self.photoID = JSON["id"] as! Int
        
        
//        
//            albumId: 1,
//            id: 31,
//            title: "voluptate voluptates sequi",
//            url: "http://placehold.it/600/a7c272",
//            thumbnailUrl: "http://placehold.it/150/a7c272"
    }
    
}
