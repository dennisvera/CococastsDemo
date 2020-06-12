//
//  MoviesCollectionViewCell.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 6/1/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Outlets
  
  @IBOutlet private var movieImageView: UIImageView!
  
  // MARK: - Overrides
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: - Public API
  
  func configure(with presentable: MoviePresentable?) {
    // Configure Image View
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500/"
    guard let posterPath = presentable?.posterPath else { return }
    let url = URL(string: imageBaseUrl + posterPath)
    let thumbnailSize = CGSize(width: 400, height: 400)
    movieImageView.sd_setImage(with: url, placeholderImage: nil, context: [.imageThumbnailPixelSize : thumbnailSize])
  }
}
