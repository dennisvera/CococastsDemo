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
  
  @IBOutlet private var movieImageView: UIImageView! {
    didSet {
      movieImageView.clipsToBounds = true
      movieImageView.layer.cornerRadius = 12
      movieImageView.contentMode = .scaleAspectFit
    }
  }
  
  // MARK: - Overrides
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func prepareForReuse() {
    movieImageView.image = nil
  }
  
  // MARK: - Public API
  
  func configure(with presentable: MoviePresentable?) {
    // Configure Image View
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500/"
    guard let posterPath = presentable?.posterPath else { return }
    guard let posterUrl = URL(string: imageBaseUrl + posterPath) else { return }
    let thumbnailSize = CGSize(width: 300, height: 300)
    movieImageView.sd_setImage(with: posterUrl, placeholderImage: nil,
                               context: [.imageThumbnailPixelSize : thumbnailSize])
  }
}
