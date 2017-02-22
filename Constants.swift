//
//  Constants.swift
//  Movies
//
//  Created by Jether Canhada on 22/02/17.
//  Copyright © 2017 Jether Canhada. All rights reserved.
//

import Foundation
class Constants {
        
    
    static func apiKeyValue() -> String? {
        
        let apiKeyPlist = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Info", ofType: "plist")!)
        let movieApiKey: String = apiKeyPlist!.object(forKey: "MovieApiKey") as! String
    
        return movieApiKey
    }


}
