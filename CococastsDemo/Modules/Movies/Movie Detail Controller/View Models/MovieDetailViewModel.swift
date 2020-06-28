//
//  MovieDetailViewModel.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 6/11/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

final class MovieDetailViewModel {
  
  // MARK: - Properties
  
  private let movie: Movie?
  private var video: [Video] = []
  private let apiClient: FlickNiteAPIClient
  private let imageBaseUrl = Strings.imageBaseUrl
  
  var didTapPlayButton: ((String) -> Void)?
  
  // MARK: Initialization
  
  init(apiClient: FlickNiteAPIClient, movie: Movie) {
    self.apiClient = apiClient
    self.movie = movie
    
    fetchMovieTrailer()
  }
  
  // MARK: - Public API Properties
  
  var posterPath: String? {
    let posterPath = movie?.posterPath ?? ""
    let movie = imageBaseUrl + posterPath
    return movie
  }
  
  var backdropPath: String? {
    let posterPath = movie?.backdropPath ?? ""
    let movie = imageBaseUrl + posterPath
    return movie
  }
  
  var videoId: String {
    return video.first?.key ?? ""
  }
  
  var title: String {
    return movie?.title ?? ""
  }
  
  var releaseDate: String {
    return String(movie?.releaseDate.prefix(4) ?? "")
  }
  
  var popularityScore: String {
    return String(format: "%.0f", movie?.popularity ?? "") + "%"
  }
  
  var voteCount: String {
    return String(movie?.voteCount ?? 0)
  }
  
  var synopsis: String {
    return movie?.overview ?? ""
  }
  
  // MARK: - Helper Methods
  
  private func fetchMovieTrailer() {
    guard let movie = movie else { return }

    apiClient.fechMovieTrailer(with: movie.id) { [weak self] result in
      guard let strongSelf = self else { return }

      switch result {
      case .success(let movie):
        strongSelf.video.append(contentsOf: movie.results)
      case .failure(let error):
        print(error)
      }
    }
  }
  
  // MARK: - Public API Methods
  
  func showMovieTrailer() {
    didTapPlayButton?(videoId)
  }
}

extension MovieDetailViewModel: MoviePresentable {}
