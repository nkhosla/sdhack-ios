//
//  serverside.swift
//  AIhacks
//
//  Created by Yago Arconada on 6/24/17.
//  Copyright © 2017 bima.engine. All rights reserved.
//

import UIKit
import Alamofire

class serverside: NSObject {
    
    
//    class func getImageURL(keyword: String) -> NSURL {
//        return NSURL.init();
//    }
    
    class func stringSimilarity(stringOne: String, stringTwo:String, completion: @escaping (_ result: Float) -> Void) {
        
        let key = "41689ab0590c4c15b25498ed85819575";
        
        /**
         Similarity (Get)
         get https://westus.api.cognitive.microsoft.com/academic/v1.0/similarity
         */
        
        // Add Headers
        let headers = [
            "Ocp-Apim-Subscription-Key":key,
            ]
        
        // Add URL parameters
        let urlParams = [
            "s1":stringOne,
            "s2":stringTwo,
            ]
        print(stringOne)
        print(stringTwo)
        
        print("in function")
        // Fetch Request
        Alamofire.request("https://westus.api.cognitive.microsoft.com/academic/v1.0/similarity", method: .get, parameters: urlParams, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    
                    debugPrint("HTTP Response Body: \(response)")
                    
                    let intvalstring = "\(response)".components(separatedBy: " ")[1]
                    print(intvalstring)
                    
                    completion(Float(intvalstring)!)
                    
                }
                else {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                }
        }
        
        
    }
    
//    class func luisAnanlyzeString(str: String, completion: @escaping (_ dict: String) -> Void) {
//        
//    }
    
    
    class func clearDatabase() {
        
    }
}
