//
//  ApiConnectCatalog.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/22/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import Alamofire

typealias CallbackApiCatalog = (response: ApiResponseCatalog) -> ()

class ApiConnectCatalog {
    
    private var callback: CallbackApiCatalog?
    private let endpointUrl = "https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json"
    
    func get(callback: CallbackApiCatalog) {
        
        // Saves the callback for later execution
        self.callback = callback
        
        // Configuration
        let method = Alamofire.Method.GET
        
        // Create the request
        let connector = Alamofire.Manager.sharedInstance.request(method, endpointUrl)
        
        // Start the connection
        connector.responseString { result in
            
            //print("Connection Result: \(result)")
            
            // Handle the result properly
            self.handleResult(result)
        }
    }
    
    private func handleResult(result: Response<String, NSError>) {
        
        // Response object
        let response = ApiResponseCatalog()
        
        print("Hanlde Result Success: \(result.result.isSuccess)")
    
        // If connection was established
        if result.result.isSuccess {
            
            // Process the HTTP code
            switch result.response!.statusCode {
                
            case 200:
                
                // Sanitation of the Json string to allow parsing
                if let jsonString = result.result.value?.replace("\"im:", replacement: "\"") {
                    
                    //print("Json String: \(jsonString)")
                
                    // Parse the entities from the Json string
                    let catalog = EntityCatalog(JSONString: jsonString)
                    
                    // Saves the response
                    response.code    = .success
                    response.catalog = catalog
                    
                }else {
                    // There is no Json data to parse...
                    response.code = .emptyResponse
                }
            
            case 400:
                // Client error
                response.code = .httpClientError
                
            case 500:
                // Server error
                response.code = .httpServerError
                
            default:
                // No valid HTTP code
                response.code = .httpBadCode
            }
            
        }else {
            
            // There is no internet connectivity
            response.code = .noInternet
        }
        
        // Sends back the response
        callback?(response: response)
    }
    
    // --------------------------------------------------
    // Unique-Access Singleton
    // --------------------------------------------------
    private static var instanceCreated = false
    
    required init?() {
        if ApiConnectCatalog.instanceCreated == false {
            ApiConnectCatalog.instanceCreated = true
        }else{
            return nil
        }
    }
    
}
