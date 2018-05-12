//
//  NetworkRequest.swift
//  Major Roads
//
//  Created by Cerebro on 11/05/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import Alamofire

class NetworkRequest {
    
    func roadStatusRequest(roads:String, completionHandler: @escaping (_ dictReturned: NSArray?, _ error: String?) -> Void) {
        
        let url = "https://api.tfl.gov.uk/Road/\(roads)?app_id=\(appID)&app_key=\(apiKey)"
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).validate().responseJSON { response in
            if let data = response.data {
                switch response.result {
                case .success:
                    completionHandler(self.convertDataToArray(data: data), nil)
                case .failure(_):
                    completionHandler(nil, self.getErrorMessage(data: data))
                }
            }
        }
    }
    
    private func convertDataToArray(data:Data) -> NSArray? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! NSArray
            return json
        } catch {
            return nil
        }
    }
    
    private func getErrorMessage(data:Data) -> String? {
        if let dict = self.convertToDictionary(text: NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String), let message = dict["message"] as? String  {
            return message
        }
        return nil
    }
    
    private func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
