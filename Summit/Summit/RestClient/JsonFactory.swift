//
//  JsonFactory.swift
//  Summit
//
//  Created by Reagan Wood on 3/14/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import Foundation

public class JsonFactory {
    public static func convertToJSON(from data: Data?) -> Json? {
        guard let data = data else { return nil }
        
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? Json
        } catch {
            return nil
        }
    }
}
