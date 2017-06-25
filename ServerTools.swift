//
//  ServerTools.swift
//  AutoText
//
//  Created by Nathan khosla on 24 Jun 17.
//  Copyright © 2017 Nathan khosla. All rights reserved.
//

import UIKit
import Alamofire

class ServerTools: NSObject {

    
    class func getImageURL(keyword: String) -> NSURL {
        return NSURL.init();
    }
    
    class func stringSimilarity(stringOne: String, stringTwo:String, completion: @escaping (_ result: Float) -> Void) {
        
        let key = "1026c146bff64614876c55f4b1db402e";
        
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
    
    class func luisAnanlyzeString(str: String, completion: @escaping (_ dict: String) -> Void) {
        
    }
    
    
    class func clearDatabase() {
        
    }
}
