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
    var serializedJSON: [[String : Any]] = []
    var photos: [Photo] = []
    
    func getJSON(from urlAsString: String, completion: @escaping () -> Void) {
        
        // calls and saves JSON data
        if serializedJSON.isEmpty {
            print("json is empty so we populate")
            APIClient.parseJSON(fromURLAs: urlAsString) { (JSON) in
                self.serializedJSON = JSON
                completion()
            }
        }
    }
    
    // Initializes 500 photos at a time depending on collection view scrolling
    func populateNext500Photos() {
        if photos.count == 0 {
            initializePhotos(formStartingIndex: photos.count, toEndingIndex: photos.count + 500)
        } else if photos.count + 500 < serializedJSON.count {
            initializePhotos(formStartingIndex: photos.count + 1, toEndingIndex: photos.count + 500)
        } else if photos.count < serializedJSON.count {
            initializePhotos(formStartingIndex: photos.count + 1, toEndingIndex: serializedJSON.count - 1)
        }
        
        if let lastPhoto = self.photos.last {
            print("🔥Last Photo \(lastPhoto.title)")
        }
    }
    
    func initializePhotos(formStartingIndex starting: Int, toEndingIndex ending: Int) {
        for i in starting...ending {
            print(i)
            print(serializedJSON[i])
            let photoInfo = serializedJSON[i]
            let photo = Photo(with: photoInfo)
            photos.append(photo)
        }
    }
}
