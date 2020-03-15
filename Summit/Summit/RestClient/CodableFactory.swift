//
//  JsonFactory.swift
//  Summit
//
//  Created by Reagan Wood on 3/14/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import Foundation

public class ResponseFactory {
    public func convertToJSON(from data: Data?) -> Json? {
        guard let data = data else { return nil }
        
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? Json
        } catch {
            return nil
        }
    }
    
    public func parse<T: Decodable>(_ json: Json, to: T.Type, parseWithSnakeCase: Bool = true) -> T? {
        guard let serializedJson = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]) else {
            print("could not serialize the json response")
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = parseWithSnakeCase ? .convertFromSnakeCase : .useDefaultKeys
            return try decoder.decode(T.self, from: serializedJson)
        } catch let error {
            print("Decoding json failed with the following message \(String(describing: error))")
            return nil
        }
    }
}
