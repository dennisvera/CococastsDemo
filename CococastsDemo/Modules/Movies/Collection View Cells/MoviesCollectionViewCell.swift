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
  
  @IBOutlet private var titleLabel: UILabel!
  @IBOutlet private var moviePosterImageView: UIImageView!
  
  // MARK: - Overrides
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: - Public API
  
  func configure(with presentable: MoviePresentable?) {
    // Configure Title Label
    titleLabel.attributedText = presentable?.title.toTtitle(color: UIColor.FlickNite.red)
    
    // Configure Image View
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500/"
    guard let posterPath = presentable?.posterPath else { return }
    moviePosterImageView.sd_setImage(with: URL(string: imageBaseUrl + posterPath))
  }
}
