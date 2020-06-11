//
//  MoviesViewController.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 5/28/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesViewController: UIViewController, Storyboardable {
  
  // MARK: - Storyboardable
  
  static var storyboardName: String {
    return "Movies"
  }
  
  @IBOutlet var collectionView: UICollectionView! {
    didSet {
      // Configure Collection View
      collectionView.delegate = self
      collectionView.dataSource = self
      collectionView.prefetchDataSource = self
      collectionView.isPrefetchingEnabled = true
      collectionView.collectionViewLayout = UICollectionViewFlowLayout()
      
      // Register Movie Collection View Cell
      let xib = UINib(nibName: MoviesCollectionViewCell.nibName, bundle: .main)
      collectionView.register(xib, forCellWithReuseIdentifier: MoviesCollectionViewCell.reuseIdentifier)
    }
  }
  
  // MARK: - Properties
  
  var viewModel: MoviesViewModel?
  
  // MARK: - Initialization
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    // Set Title
    title = "Movies"
  }
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
          
    setupViewModel()
  }
  
  // MARK: - Helper Methods
  
  private func setupViewModel() {
    viewModel?.delegate = self

    // Install Handler
    viewModel?.moviesDidChange = { [weak self] in
      // Update Collection View
      guard let strongSelf = self else { return }
      strongSelf.collectionView.reloadData()
    }
  }
}

extension MoviesViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel?.totalCount ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // BUG: - the presentable func crashes the app when called on the cell for row at.
    // This started happening after the prefetching implementation.
    // Fetch Presentable
    //    guard let presentable = viewModel?.presentable(for: indexPath.item) else { fatalError("No Movies Available.") }
    
    // Dequeue Movie Collection View Cell
    let cell: MoviesCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    
    if isLoadingCell(for: indexPath) {
      cell.configure(with: .none)
    } else {
      // Configure Cell
      cell.configure(with: viewModel?.movies(at: indexPath.item))
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // Notify View Model
    viewModel?.selectMovie(at: indexPath.item)
  }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
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

extension MoviesViewController: MoviesViewModelDelegate {
  
  func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
    guard let newIndexPathsToReload = newIndexPathsToReload else {
      collectionView.reloadData()
      return
    }
    
    let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
    collectionView.reloadItems(at: indexPathsToReload)
  }
  
  func onFetchFailed(with reason: String) {
    // TO DO: Implement Alert Toast
  }
}

extension MoviesViewController: UICollectionViewDataSourcePrefetching {
  
  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    if indexPaths.contains(where: isLoadingCell) {
      viewModel?.fetchMovies()
    }
  }
}

private extension MoviesViewController {
  
  func isLoadingCell(for indexPath: IndexPath) -> Bool {
    return indexPath.row >= viewModel?.currentCount ?? 0
  }
  
  func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
    let indexPathsForVisibleRows = collectionView.indexPathsForVisibleItems
    let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
    return Array(indexPathsIntersection)
  }
}
