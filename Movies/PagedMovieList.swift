//
//  PagedMovieList.swift
//  Movies
//
//  Created by Jether Canhada on 22/02/17.
//  Copyright © 2017 Jether Canhada. All rights reserved.
//

import Foundation
import MovieKit

class PagedMovieList {
    
    private let queue = DispatchQueue(label: "PagedMovieList")
    private let webService = WebService(apiKey: "b7945bed3806ddaece188b2cf7b50b30")
    
    public private(set) var lastLoadedPageNumber = 0
    
    func loadOneMorePage(completion: @escaping ([Movie]?) -> Void) {
        queue.async {
            let nextPageNumber = self.lastLoadedPageNumber+1
            let semaphore = DispatchSemaphore(value: 0)
            print("Loading page #\(nextPageNumber)")
            self.webService.load(resource: Movie.popular(pageNumber: nextPageNumber)) { response in
                switch response {
                case .success(let response):
                    self.lastLoadedPageNumber = nextPageNumber
                    completion(response.results)
                    semaphore.signal()
                case .error(let msg):
                    print("Page #\(nextPageNumber) failed to load: \(msg)")
                    completion(nil)
                    semaphore.signal()
                }
            }
            semaphore.wait()
        }
    }
}
