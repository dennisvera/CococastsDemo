//
//  NowPlayingViewModel.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 6/1/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

final class NowPlayingViewModel {
  
  // MARK: - Properties
  
  private let apiClient: APIClient
  
  private var movies: [Movie] = [] {
    didSet {
      DispatchQueue.main.async {
        self.moviesDidChange?()
      }
    }
  }
  
  var moviesDidChange: (() -> Void)?
  
  // MARK: - Public Properties
  
  var numberOfMovies: Int {
    return movies.count
  }
  
  // MARK: - Initialization
  
  init(apiClient: APIClient) {
    self.apiClient = apiClient
    
    fetchMovies()
  }
  
  // MARK: - Public API
  
  func movies(at index: Int) -> Movie {
    return movies[index]
  }
  
  // MARK: - Helper Methods
  
  private func fetchMovies() {
    // Fetch Movies
    APIClient().fetchMovies { [weak self] result in
      switch result {
      case .success(let movies):
        print(movies.results.count)
        guard let strongSelf = self else { return }
        strongSelf.movies = movies.results
      case .failure(let error):
        print(error)
      }
    }
  }
}