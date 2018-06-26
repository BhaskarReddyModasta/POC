//
//  APIClient.swift
//  POC
//
//  Created by Admin on 13/06/18.
//  Copyright © 2018 Bhaskar. All rights reserved.
//

import Foundation
import Alamofire
// this API Clicent will be called by the viewModel to get data from API.
class APIClient: NSObject {
    
    func getRequestFetch(urlString: String, completion: @escaping (Dictionary<String, Any>?, _ isSuccess: Bool?, _ error: String?) -> Void) {
        
        // unwrap our API endpoint
        guard let url = URL(string: urlString) else {
            print("Error unwrapping URL");
            return
        }
        Alamofire.request(url).responseData { response in
            // unwrap our returned data
            guard let unwrappedData = response.data else { print("Error getting data"); return }
            let responseStrInISOLatin = String(data: unwrappedData, encoding: String.Encoding.isoLatin1)
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                print("could not convert data to UTF-8 format")
                completion(nil, false, "json failed")
                return
            }
            do {
                let responseJSONDict = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format)
                completion(responseJSONDict as? Dictionary<String, Any>, response.result.isSuccess, nil)
            } catch {
                completion(nil, false, error.localizedDescription)
            }
        }
    }
}
