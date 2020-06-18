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

  @IBOutlet weak var detailVIewContainer: UIView!
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var releaseDateLabel: UILabel!
  @IBOutlet weak var ratedLabel: UILabel!
  @IBOutlet weak var runTimeLabel: UILabel!
  @IBOutlet weak var popularityImageView: UIImageView!
  @IBOutlet weak var popularityScoreLabel: UILabel!
  
  @IBOutlet weak var voteScoreLabel: UILabel!
  @IBOutlet weak var voteScoreImageView: UIImageView!
  
  // MARK: - Properties
  
  var viewModel: MovieViewModel?
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupNavigationBar()
  }
  
  // MARK: - Helper Methods
  
  private func setupNavigationBar() {
    // Set Title
    title = viewModel?.title
    
    navigationItem.largeTitleDisplayMode = .never
    navigationController?.navigationBar.tintColor = .white
  }
  
  private func setupView() {
    detailVIewContainer.backgroundColor = UIColor.darkGray
    
    guard let viewModel = viewModel else { return }
    
    posterImageView.clipsToBounds = true
    posterImageView.layer.cornerRadius = 8
    posterImageView.sd_setImage(with: URL(string: viewModel.posterPath ?? ""))
    
    titleLabel.textColor = .white
    titleLabel.text = viewModel.title
    
    releaseDateLabel.textColor = .white
    releaseDateLabel.text = "2020"
    
    ratedLabel.textColor = .white
    ratedLabel.text = "PG"
    
    runTimeLabel.textColor = .white
    runTimeLabel.text = "133"
    
    popularityImageView.backgroundColor = .white
    
    popularityScoreLabel.textColor = .white
    popularityScoreLabel.text = viewModel.popularityScore
    
    voteScoreImageView.backgroundColor = .white
    
    voteScoreLabel.text = viewModel.voteCount
    voteScoreLabel.textColor = .white
    
  }
}
