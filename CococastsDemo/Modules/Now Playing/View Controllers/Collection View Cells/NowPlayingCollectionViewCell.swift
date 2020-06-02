//
//  NowPlayingCollectionViewCell.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 6/1/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class NowPlayingCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Outlets
  
  @IBOutlet private var imageView: UIImageView!
  @IBOutlet private var titleLabel: UILabel!
  
  // MARK: - Overrides
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: - Public API
  
  func configure(with presentable: NowPlayingPresentable) {
    titleLabel.text = presentable.title
  }
}
