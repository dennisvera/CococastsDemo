//
//  MoviesCollectionViewController.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 5/28/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesCollectionViewController: UICollectionViewController, Storyboardable {
  
  // MARK: - Storyboardable
  
  static var storyboardName: String {
    return "Movies"
  }
  
  // MARK: - Properties
  
  private let viewTitle = "Movies"
  private let minimumSpacing: CGFloat = 10.0

  var viewModel: MoviesViewModel?
  
  // MARK: - Intialization
  
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewModel()
    setupCollectionView()
    setupTabAndNavigationBar()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Set Navigation Bar Title
    navigationItem.title = viewTitle
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    
    // Remove Navigation Bar Back Button Title
    self.navigationItem.title = ""
  }

  // MARK: - Helper Methods
  
  private func setupCollectionView() {
    // Configure Collection View
    collectionView.prefetchDataSource = self
    collectionView.isPrefetchingEnabled = true
    collectionView.backgroundColor = UIColor.FlickNite.mediumGray
  }
  
  private func setupTabAndNavigationBar() {
    // Set Tab Bar Title
    title = viewTitle
    
    // Configure Tab Bar Controller
    tabBarController?.tabBar.tintColor = UIColor.FlickNite.white
    tabBarController?.tabBar.barTintColor = UIColor.FlickNite.darkGray
    
    // Configure Navigation Bar
    navigationController?.navigationBar.barStyle = .black
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.navigationBar.barTintColor = UIColor.FlickNite.darkGray
    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.FlickNite.white]
  }
  
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

extension MoviesCollectionViewController {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel?.totalCount ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // BUG:
    // Using the presentable helper method crashes the app after the prefetching implementation was set up.
    // Using the movies(at:) method does not crash the app. Need to investigate.
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
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // Notify View Model
    viewModel?.selectMovie(at: indexPath.item)
  }
}

extension MoviesCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let numberOfItemsPerRow: CGFloat = 2
    
    let totalSpacing = (2 * minimumSpacing) + ((numberOfItemsPerRow - 1) * minimumSpacing)
    
    if let collection = self.collectionView {
      let width = (collection.bounds.width - totalSpacing) / numberOfItemsPerRow
      return CGSize(width: width, height: 280)
    } else {
      return CGSize(width: 0, height: 0)
    }
  }
    
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return minimumSpacing + 2
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return minimumSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    
    return .init(top: 12, left: 10, bottom: 10, right: 10)
  }
}

extension MoviesCollectionViewController: MoviesViewModelDelegate {
  
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

extension MoviesCollectionViewController: UICollectionViewDataSourcePrefetching {
  
  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    if indexPaths.contains(where: isLoadingCell) {
      viewModel?.fetchMovies()
    }
  }
}

private extension MoviesCollectionViewController {
  
  func isLoadingCell(for indexPath: IndexPath) -> Bool {
    return indexPath.row >= viewModel?.currentCount ?? 0
  }
  
  func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
    let indexPathsForVisibleRows = collectionView.indexPathsForVisibleItems
    let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
    return Array(indexPathsIntersection)
  }
}
