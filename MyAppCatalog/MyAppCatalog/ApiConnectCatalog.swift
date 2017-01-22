//
//  ApiConnectCatalog.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/22/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import Alamofire

typealias ApiCallbackCatalog = (response: ApiResponseCatalog) -> ()

class ApiConnectCatalog {
    
    private var callback: ApiCallbackCatalog?
    private let endpointUrl = "https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json"
    
    func connect(callback: ApiCallbackCatalog) {
        
        // Configuration
        let method = Alamofire.Method.GET
        
        // Create the request
        let connector = Alamofire.Manager.sharedInstance.request(method, endpointUrl)
        
        // Start the connection
        connector.responseString { result in
            
            // Handle the result properly
            self.handleResult(result)
        }
    }
    
    private func handleResult(result: Response<String, NSError>) {
        
        // Response object
        let response = ApiResponseCatalog()
    
        // If connection was established
        if result.result.isSuccess {
            
            // Process the HTTP code
            switch result.response!.statusCode {
                
            case 200:
                
                // Sanitation of the Json string to allow parsing
                if let jsonString = result.result.value?.replace("\"im:", replacement: "\"") {
                
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
    
}
