//
//  MovieListController.swift
//  Movies
//
//  Created by Jether Canhada on 22/02/17.
//  Copyright © 2017 Jether Canhada. All rights reserved.
//
import UIKit
import MovieKit

class MovieListController: UITableViewController {
    
    var movies: [Movie] = []
    var didSelectMovie: (Movie) -> Void = { _ in }
    
    let dataSource = PagedMovieList()
    let lazyLoadTreshold = 10
    let cellID = "movie"
    
    let searchVC = UISearchController(searchResultsController: SearchResultsController())
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.title = "Popular Movies"
        tableView.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        searchVC.searchResultsUpdater = self
        searchVC.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchVC.searchBar
        definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true
        
        if let searchResultVC = searchVC.searchResultsController as? SearchResultsController {
            searchResultVC.didSelectMovie = { movie in
                self.didSelectMovie(movie)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if movies.count == 0 {
            loadNextPage()
        }
    }
    
    func loadNextPage() {
        dataSource.loadOneMorePage { newItems in
            guard let newItems = newItems else { return }
            DispatchQueue.main.async {
                let insertedIndexes = self.movies.endIndex..<self.movies.endIndex+newItems.count
                let indexPaths = insertedIndexes.map { IndexPath(row: $0, section: 0) }
                self.movies.append(contentsOf: newItems)
                self.tableView.insertRows(at: indexPaths, with: .fade)
            }
        }
    }
}

extension MovieListController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let resultVC = searchVC.searchResultsController as? SearchResultsController {
            let query = searchVC.searchBar.text?.lowercased() ?? ""
            resultVC.movies = movies.filter { $0.title.lowercased().contains(query) }
        }
    }
}

// Data Source
extension MovieListController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MovieListCell
        
        if indexPath.row >= movies.count - lazyLoadTreshold {
            loadNextPage()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// Table Delegate
extension MovieListController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectMovie(movies[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? MovieListCell {
            cell.movie = movies[indexPath.row]
        }
    }
}
