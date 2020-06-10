//
//  MovieDetailCollectionViewController.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 6/10/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailCollectionViewController: UIViewController, Storyboardable {
  
  // MARK: - Outlets
  @IBOutlet weak var moviePosterImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  
  // MARK: - Properties
  
  var movie: Movie?
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  // MARK: - Helper Methods
  
  private func setupView() {
    guard let movie = movie else { return }
    
    // Set Title
    title = movie.title
    
    // Set Background Color
    view.backgroundColor = .white
    
//    titleLabel.text = movie.title
    
    // Configure Image View
//    let imageBaseUrl = "https://image.tmdb.org/t/p/w200/"
//    guard let posterPath = movie?.posterPath else { return }
//    moviePosterImageView.sd_setImage(with: URL(string: imageBaseUrl + posterPath))
  }
}
