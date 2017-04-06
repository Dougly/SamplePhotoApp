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
        dataStore.getPhotos(from: dataStore.urlForSampleJSONAsString)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

