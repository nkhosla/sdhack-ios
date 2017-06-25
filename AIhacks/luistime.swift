//
//  luistime.swift
//  AIhacks
//
//  Created by Yago Arconada on 6/24/17.
//  Copyright © 2017 bima.engine. All rights reserved.
//

import Foundation
import Alamofire

class luistime: NSObject {

    class func sendRequest2Request(str: String,completion: @escaping (_ intent: String, _ entities: String) -> Void) {
    /**
     Request (2)
     get https://westus.api.cognitive.microsoft.com/luis/v2.0/apps/6dc24e47-4be6-4a17-bad5-11cf23a1f1b0
     */
    
    // Add URL parameters
    let urlParams = [
        "subscription-key":"f5aa08fcae3b463f8c5a2f9896985b34",
        "timezoneOffset":"0",
        "verbose":"true",
        "q":str,
        ]
    
    // Fetch Request
    Alamofire.request("https://westus.api.cognitive.microsoft.com/luis/v2.0/apps/6dc24e47-4be6-4a17-bad5-11cf23a1f1b0", method: .get, parameters: urlParams)
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            if (response.result.error == nil) {
                debugPrint("HTTP Response Body: \(response)")
                if let result = response.result.value {
                    print("JSON: \(result)")
                    
                    let json = result as! NSDictionary
                    
                    print(type(of: json))
                    
                    let topScoringIntentDict = json["topScoringIntent"] as! NSDictionary
                    let intent = topScoringIntentDict["intent"] as! String
                    print(intent)
                    
                    
                    let entityArray = json["entities"] as! NSArray
                    var entities = " "
                    let maxIndex = entityArray.count-1
                    
                    for i in 0...maxIndex {
                        let e = entityArray[i] as! NSDictionary
                        entities = e["entity"] as! String + " " + entities
//                        entities.append(e["entity"] as! String)
                    }
                    
                    print(entities)
                    
                    completion(intent, entities)
                    // ARE THE ENTITIES SEPARATED BY A SPACE????
                }
            }
            else {
                debugPrint("HTTP Request failed: \(response.result.error)")
            }
    }
}
}
