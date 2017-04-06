//
//  APIClient.swift
//  SamplePhotoApp
//
//  Created by Douglas Galante on 4/6/17.
//  Copyright © 2017 Dougly. All rights reserved.
//

import Foundation

class APIClient {
    
    class func parseJSON(from urlAsString: String, completion: @escaping ([[String : Any]]) -> Void) {
        
        // Convert string to URL and create shared session
        let url = URL(string: urlAsString)
        let session = URLSession.shared
        
        // If url is valid attemt to parse obtain JSON and parse it
        if let url = url {
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let data = data {
                    
                    //
                    do {
                        let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as! [[String : Any]]
                        completion(responseJSON)

                    } catch {
                        print("In url session could not serialize data into JSON")
                        if let response = response {
                            print("Response: \(response)")
                        }
                        print("Error: \(error)")
                    }
                }
            })
            task.resume()
        }
        
    }
    
}
