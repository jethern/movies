//
//  JSONDecodable.swift
//  Movies
//
//  Created by Jether Canhada on 22/02/17.
//  Copyright © 2017 Jether Canhada. All rights reserved.
//



import Foundation

// TODO: Report parsing errors in detail?
public protocol JSONDecodable {

    init?(jsonObject: Any)
}

extension JSONDecodable {

    init?(jsonData: Data) {
        if let object = try? JSONSerialization.jsonObject(with: jsonData, options: []) {
            self.init(jsonObject: object as AnyObject)
        } else {
            return nil
        }
    }

    init?(jsonString: String) {
        if let data = jsonString.data(using: String.Encoding.utf8) {
            self.init(jsonData: data)
        } else {
            return nil
        }
    }
}
