//
//  MovieViewModel.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 6/11/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

struct MovieViewModel {
  
  // MARK: - Properties
  
  let movie: Movie
  
  // MARK: - Public API
  
  var title: String {
    return movie.title
  }
  
  var posterPath: String? {
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500/"
    let posterPath = movie.posterPath ?? ""
    let movie = imageBaseUrl + posterPath
    return movie
  }
}

extension MovieViewModel: MoviePresentable {}
