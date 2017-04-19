//
//  PhotoTests.swift
//  SamplePhotoApp
//
//  Created by Douglas Galante on 4/19/17.
//  Copyright © 2017 Dougly. All rights reserved.
//

import XCTest
@testable import SamplePhotoApp

class PhotoTests: XCTestCase {
    
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

    
    func testInit() {
        var photos: [Photo] = []
        for item in sampleJSON {
            photos.append(Photo(with: item))
        }
        
        let expectedFirstTitle = "accusamus beatae ad facilis cum similique qui sunt"
        let resultFirstTitle = photos[0].title
        XCTAssert(expectedFirstTitle == resultFirstTitle, "Expected: \(expectedFirstTitle), Got: \(resultFirstTitle)")
        
        let expectedSecondURL = "http://placehold.it/600/771796"
        let resultSecondURL = photos[1].imageURLString
        XCTAssert(expectedSecondURL == resultSecondURL, "Expected: \(expectedSecondURL), Got: \(resultSecondURL)")
        
        let expectedThirdThumbnailURL = "http://placehold.it/150/24f355"
        let resultThirdThumbnailURL = photos[2].thumbnailURLString
        XCTAssert(expectedThirdThumbnailURL == resultThirdThumbnailURL, "Expected: \(expectedThirdThumbnailURL), Got: \(resultThirdThumbnailURL)")
        
        let expectedFourthAlbumID = 1
        let resultFourthAlbumID = photos[3].albumID
        XCTAssert(expectedFourthAlbumID == resultFourthAlbumID, "Expected: \(expectedFourthAlbumID), Got: \(resultFourthAlbumID)")
        
        let expectedFifthID = 5
        let resultFifthID = photos[4].photoID
        XCTAssert(expectedFifthID == resultFifthID, "Expected: \(expectedFifthID), Got: \(resultFifthID)")
    
    }
    
}
