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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get serializedJSON and first 500 photos
        dataStore.getJSON(from: dataStore.urlForSampleJSONAsString) {
            print(self.dataStore.serializedJSON.count)
            self.dataStore.populateNext500Photos()
        }
        
    }


}

