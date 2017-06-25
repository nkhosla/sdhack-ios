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
    
    class func luisAnanlyzeString(str: String, completion: @escaping (_ intent: String, _ entities:String) -> Void) {
        
        print("started luis function")
        let key = "f5aa08fcae3b463f8c5a2f9896985b34"
        
        /**
         LUIS
         get https://westus.api.cognitive.microsoft.com/luis/v2.0/apps/6dc24e47-4be6-4a17-bad5-11cf23a1f1b0
         */
        
        // Add URL parameters
        let urlParams = [
            "subscription-key":key,
            "timezoneOffset":"0",
            "verbose":"true",
            "q":str,
            ]
        
        // Fetch Request
        print("sending request")
        Alamofire.request("https://westus.api.cognitive.microsoft.com/luis/v2.0/apps/6dc24e47-4be6-4a17-bad5-11cf23a1f1b0", method: .get, parameters: urlParams)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    
                    if let result = response.result.value {
                       // print("JSON: \(result)")
                        
                        let json = result as! NSDictionary
                        
                       // print(type(of: json))
                        
                        let topScoringIntentDict = json["topScoringIntent"] as! NSDictionary
                        let intent = topScoringIntentDict["intent"] as! String
                        print(intent)
                        
                        
                        let entityArray = json["entities"] as! NSArray
                        var entities = ""
                        let maxIndex = entityArray.count - 1
                        
                        print("maxidx ",maxIndex)
                        
                        if maxIndex>0 {
                            for i in 0...maxIndex {
                                let e = entityArray[i] as! NSDictionary
                                let  estring = e["entity"] as! String
                                entities += estring
                                entities += " "
                            }
                        }
                        
                        print(entities)
                        
                        completion(intent, entities)
                        
                        
                    }
                }
                else {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                }
        }
        
        
    }
    
    
    class func clearDatabase() {
        
    }
}
