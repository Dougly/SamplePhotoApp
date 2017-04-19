//
//  DataStoreTests.swift
//  SamplePhotoApp
//
//  Created by Douglas Galante on 4/19/17.
//  Copyright © 2017 Dougly. All rights reserved.
//

import XCTest
@testable import SamplePhotoApp

class DataStoreTests: XCTestCase {
    
    let dataStore = DataStore.sharedInstance
    
    let sampleJSON: [[String : Any]] = [[   "albumId": 1,
                                            "id": 1,
                                            "title": "accusamus beatae ad facilis cum similique qui sunt",
                                            "url": "http://placehold.it/600/92c952",
                                            "thumbnailUrl": "http://placehold.it/150/92c952"],
                                        [
                                            "albumId": 1,
                                            "id": 2,
                                            "title": "reprehenderit est deserunt velit ipsam",
                                            "url": "http://placehold.it/600/771796",
                                            "thumbnailUrl": "http://placehold.it/150/771796"],
                                        [
                                            "albumId": 1,
                                            "id": 3,
                                            "title": "officia porro iure quia iusto qui ipsa ut modi",
                                            "url": "http://placehold.it/600/24f355",
                                            "thumbnailUrl": "http://placehold.it/150/24f355"],
                                        [
                                            "albumId": 1,
                                            "id": 4,
                                            "title": "culpa odio esse rerum omnis laboriosam voluptate repudiandae",
                                            "url": "http://placehold.it/600/d32776",
                                            "thumbnailUrl": "http://placehold.it/150/d32776"],
                                        [
                                            "albumId": 1,
                                            "id": 5,
                                            "title": "natus nisi omnis corporis facere molestiae rerum in",
                                            "url": "http://placehold.it/600/f66b97",
                                            "thumbnailUrl": "http://placehold.it/150/f66b97"]]

        
    
    
    func testAppendNext30Photos() {
        dataStore.serializedJSON = sampleJSON
        dataStore.appendNext30Photos {}

        var expectedPhotos: [Photo] = []
        for item in sampleJSON {
            expectedPhotos.append(Photo(with: item))
        }
        
        let resultPhotos = dataStore.photos
        
        var pass = true
        for (index, photo) in expectedPhotos.enumerated() {
            if photo.title != resultPhotos[index].title {
                pass = false
            }
        }
        
        XCTAssert(pass)
    }
    
}
