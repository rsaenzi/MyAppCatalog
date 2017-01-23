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
    
    // --------------------------------------------------
    // Components
    // --------------------------------------------------
    private let endpointUrl = "https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json"
    
    func get(callback: CallbackApiCatalog) {
        
        // Configuration
        let method = Alamofire.Method.GET
        
        // Create the request
        let connector = Alamofire.Manager.sharedInstance.request(method, endpointUrl)
        
        // Start the connection
        connector.responseString { result in
            
            // Handle the result properly
            self.handleResult(result, callback: callback)
        }
    }
    
    private func handleResult(result: Response<String, NSError>, callback: CallbackApiCatalog) {
        
        // Response object
        let response = ApiResponseCatalog()
        
        // If an error was reported
        if let error = result.result.error {
            
            // Error code for no connectivity
            if error.code == -1009 {
                
                // There is no internet connectivity
                response.code = .noInternet
                
            }else{
                
                // Error establishing connection, could be a server down
                response.code = .wrongConnection
            }
        }else {
            
            // If connection was established
            if result.result.isSuccess == true {
                
                // Process the HTTP code
                switch result.response!.statusCode {
                    
                case 200:
                    
                    // Sanitation of the Json string to allow parsing
                    if let jsonString = result.result.value?.replace("\"im:", replacement: "\"") {
                        
                        // Parse the entities from the Json string
                        let catalog = EntityCatalog(JSONString: jsonString)
                        
                        // Saves the response
                        response.code       = .success
                        response.catalog    = catalog
                        response.jsonString = jsonString
                        
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
                
                // Error establishing connection, could be a server down
                response.code = .wrongConnection
            }
        }
    
        // Sends back the response
        callback(response: response)
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
