//
//  ApiService.swift
//  GloriaAppChallenge
//
//  Created by Martin Regas on 27/07/2021.
//

import UIKit
import Alamofire

class ApiService: NSObject {
    
    func request<T:Decodable>(_ apiRequest: ApiRequest,
                              completion: @escaping ([T]) -> Void,
                              failure: @escaping (Error) -> Void) {
        
        let urlString = Constants.apiBasePath + apiRequest.path.rawValue
        let method = HTTPMethod(rawValue: apiRequest.method.rawValue.uppercased())
        let parameters = apiRequest.parameters

        AF.request(urlString, method: method, parameters: parameters).responseData(completionHandler: {
            response in

            switch response.result {
            case .success(let data):
                let json = String(data: data, encoding: .utf8) ?? String()

                print("Response: \(json)")

                var entities = [T]()
                let decoder = JSONDecoder()

                do {
                    entities = try decoder.decode([T?].self, from: data).compactMap { $0 }
                } catch(let error) {
                    print(error)
                    do {
                        entities = [try decoder.decode(T.self, from: data)]
                    } catch(let error) {
                        failure(error)
                        return
                    }
                }
                
                completion(entities)

            case .failure(let error):
                print("Failure: \(error.localizedDescription)")
                failure(error)
            }
        })
    }
}
