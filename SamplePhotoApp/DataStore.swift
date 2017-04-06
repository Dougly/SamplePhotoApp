//
//  DataStore.swift
//  SamplePhotoApp
//
//  Created by Douglas Galante on 4/6/17.
//  Copyright © 2017 Dougly. All rights reserved.
//

import Foundation

class DataStore {
    
    // set the data store as a singleton
    static let sharedInstance = DataStore.init()
    private init() {}
    
    let urlForSampleJSONAsString = "http://jsonplaceholder.typicode.com/photos"
    var photos: [Photo] = []
    
    func getPhotos(from urlAsString: String) {
        APIClient.parseJSON(from: urlAsString) { (JSON) in
            for item in JSON {
                let photo = Photo(with: item)
                self.photos.append(photo)
            }
            if let firstPhoto = self.photos.first {
                print("🔥First Photo \(firstPhoto.title)")
            }
        }
    }
}
