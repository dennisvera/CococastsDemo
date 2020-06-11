//
//  MovieDetailViewController.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 6/10/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController, Storyboardable {
  
  // MARK: - Outlets
  
  @IBOutlet var moviePosterImageView: UIImageView! {
    didSet {
      // Configure Image View
      moviePosterImageView.contentMode = .scaleAspectFit
    }
  }
  
  // MARK: - Properties
  
  var viewModel: MovieViewModel?
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup View
    setupView()
    
    // Set Title
    title = viewModel?.title
  }
  
  // MARK: - Helper Methods
  
  private func setupView() {
    guard let viewModel = viewModel else { return }
    
    // Configure Image View
    moviePosterImageView.sd_setImage(with: URL(string: viewModel.posterPath ?? ""))
  }
}
