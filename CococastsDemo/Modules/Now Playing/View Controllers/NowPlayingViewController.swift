//
//  NowPlayingViewController.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 5/28/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController, Storyboardable {
  
  // MARK: - Storyboardable
  
  static var storyboardName: String {
    return "NowPlaying"
  }
  
  @IBOutlet var collectionView: UICollectionView! {
    didSet {
      // Configure Collection View
      collectionView.delegate = self
      collectionView.dataSource = self
      
      // Register Movie Collection View Cell
      let xib = UINib(nibName: MovieCollectionViewCell.nibName, bundle: .main)
      collectionView.register(xib, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
    }
  }
  
  // MARK: - Properties
  
  var viewModel: NowPlayingViewModel?
  
  // MARK: - Initialization
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    // Set Title
    title = "Now Playing"
  }
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewModel()
  }
  
  // MARK: - Helper Methods
  
  private func setupViewModel() {
    // Install Handler
    viewModel?.moviesDidChange = { [weak self] in
      // Update Collection View
      guard let strongSelf = self else { return }
      strongSelf.collectionView.reloadData()
    }
  }
}

extension NowPlayingViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel?.numberOfMovies ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // Fetch Movies
    guard let movies = viewModel?.movies(at: indexPath.item) else { fatalError("No Movies Available.") }
    
    // Dequeue Movie Collection View Cell
    let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    
    // Configure Cell
    cell.titleLabel.text = movies.title
    
    return cell
  }
}

extension NowPlayingViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return .init(width: collectionView.bounds.width, height: 340.0)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 20.0
  }
  
}
