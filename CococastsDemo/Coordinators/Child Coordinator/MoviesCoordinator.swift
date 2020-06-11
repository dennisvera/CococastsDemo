//
//  MoviesCoordinator.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 5/29/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class MoviesCoordinator: Coordinator {
  
  // MARK: - Properties
  
  private let navigationController = UINavigationController()
  
  // MARK: - Public API
  
  var rootViewController: UIViewController {
    return navigationController
  }
  
  // MARK: - Overrides
  
  override func start() {
    // Set Navigation Controller Delegate
    navigationController.delegate = self
    
    // Show Photos
    showMovies()
  }
  
  // MARK: -
  
  override func navigationController(_ navigationController: UINavigationController,
                                     willShow viewController: UIViewController,
                                     animated: Bool) {
    childCoordinators.forEach { (childCoordinator) in
      childCoordinator.navigationController(navigationController, willShow: viewController, animated: animated)
    }
  }
  
  override func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                     animated: Bool) {
    childCoordinators.forEach { (childCoordinator) in
      childCoordinator.navigationController(navigationController, didShow: viewController, animated: animated)
    }
  }
  
  // MARK: - Helper Methods
  
  private func showMovies() {
    // Initialize API Client
    let apiClient = FlickNiteAPIClient()
    
    // Initialize Now Playing View Model
    let viewModel = MoviesViewModel(apiClient: apiClient)
    
    // Initialize Now Playing View Controller
    let moviesViewController = MoviesViewController.instantiate()
    // Configure Now Playing View Controller
    moviesViewController.viewModel = viewModel
    
    // Install Handlers
    viewModel.didSelectMovie = { [weak self] movie in
      guard let strongSelf = self else { return }
      strongSelf.showMovie(movie)
    }
    
    // Push Photos View Controller Onto Navigation Stack
    navigationController.pushViewController(moviesViewController, animated: true)
  }
  
  private func showMovie(_ movie: Movie) {
    // Initialize Movie Detail View Controller
    let movieViewController = MovieDetailCollectionViewController()
    
    // Configure Movie Detail View Controller
    movieViewController.movie = movie
    
    // Push Movie Detail View Controller Onto Navigation Stack
    navigationController.pushViewController(movieViewController, animated: true)
  }
}
