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
  
  var posterPath: String? {
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500/"
    let posterPath = movie.posterPath ?? ""
    let movie = imageBaseUrl + posterPath
    return movie
  }
  
  var backdropPath: String? {
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500/"
    let posterPath = movie.backdropPath ?? ""
    let movie = imageBaseUrl + posterPath
    return movie
  }
  
  var title: String {
    return movie.title
  }
  
  var releaseDate: String {
    return String(movie.releaseDate.prefix(4))
  }
  
  var popularityScore: String {
    return String(format: "%.0f", movie.popularity) + "%"
  }
  
  var voteCount: String {
    return String(movie.voteCount)
  }
}

extension MovieViewModel: MoviePresentable {}
