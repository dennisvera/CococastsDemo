//
//  NowPlayingCoordinator.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 5/29/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class NowPlayingCoordinator: Coordinator {
  
  // MARK: - Properties
  
  var rootViewController: UIViewController {
    return nowPlayingViewController
  }
  
  private lazy var nowPlayingViewController: NowPlayingViewController = {
     // Initialize API Client
    let apiClient = APIClient()
    
    // Initialize Now Playing View Model
    let viewModel = NowPlayingViewModel(apiClient: apiClient)
    
     // Initialize Now Playing View Controller
    let nowPlayingViewController = NowPlayingViewController.instantiate()
    // Configure Now Playing View Controller
    nowPlayingViewController.viewModel = viewModel
    
    return nowPlayingViewController
  }()
}
