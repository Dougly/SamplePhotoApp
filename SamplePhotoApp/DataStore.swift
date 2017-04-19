//
//  DataStore.swift
//  SamplePhotoApp
//
//  Created by Douglas Galante on 4/6/17.
//  Copyright © 2017 Dougly. All rights reserved.
//

import Foundation

class DataStore {
    
    // Create Singleton
    static let sharedInstance = DataStore()
    private init() {}
    let sampleURL = "http://jsonplaceholder.typicode.com/photos"
    var serializedJSON: [[String : Any]] = []
    var photos: [Photo] = []
    
    
    
    // Gets photo info and saves it to the datastore
    func getJSON(with completion: @escaping (Bool) -> Void) {
        APIClient.getPhotoInfo(fromURL: sampleURL) { (JSON) in
            if JSON.count == 0 {
                completion(false)
            } else {
                self.serializedJSON = JSON
                completion(true)
            }
        }
    }
    
    // Initializes 30 photos at a time depending on collection view scrolling
    func appendNext30Photos(with completion: () -> Void) {
        if photos.count == 0 && !serializedJSON.isEmpty && photos.count > 29 {
            initializePhotos(formStartingIndex: photos.count, toEndingIndex: photos.count + 29)
        } else if photos.count + 29 < serializedJSON.count {
            initializePhotos(formStartingIndex: photos.count, toEndingIndex: photos.count + 29)
        } else if photos.count < serializedJSON.count {
            initializePhotos(formStartingIndex: photos.count, toEndingIndex: serializedJSON.count - 1)
        }
        completion()
    }
    
    func initializePhotos(formStartingIndex starting: Int, toEndingIndex ending: Int) {
        for i in starting...ending {
            let photoInfo = serializedJSON[i]
            let photo = Photo(with: photoInfo)
            photos.append(photo)
        }
    }
    
    
}
