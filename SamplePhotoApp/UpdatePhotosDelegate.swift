//
//  UpdatePhotosDelegate.swift
//  SamplePhotoApp
//
//  Created by Douglas Galante on 4/11/17.
//  Copyright © 2017 Dougly. All rights reserved.
//

import Foundation

protocol GetPhotoDataDelegate {
    func getNextBatch(with completion: @escaping (Bool) -> Void)
}
