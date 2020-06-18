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

  @IBOutlet weak var backdropPosterImageView: UIImageView!
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Hide the navigation bar
//    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  // MARK: - Helper Methods
  
  private func setupNavigationBar() {
    // Set Title
    title = viewModel?.title
    
    navigationItem.largeTitleDisplayMode = .never
    navigationController?.navigationBar.tintColor = .white
  }
  
  private func setupView() {
    detailVIewContainer.backgroundColor = UIColor.FlickNite.lightGray
        
    guard let viewModel = viewModel else { return }
    
    backdropPosterImageView.clipsToBounds = true
    backdropPosterImageView.contentMode = .scaleAspectFill
    backdropPosterImageView.sd_setImage(with: URL(string: viewModel.backdropPath ?? ""))
    
    posterImageView.clipsToBounds = true
    posterImageView.layer.cornerRadius = 14
    posterImageView.contentMode = .scaleAspectFit
    posterImageView.sd_setImage(with: URL(string: viewModel.posterPath ?? ""))
    
    
    titleLabel.attributedText = viewModel.title.toTtitle(color: .white, textAlignment: .left)
    
    releaseDateLabel.attributedText = viewModel.releaseDate.toDetail(color: .white, textAlignment: .left)
    
    ratedLabel.attributedText = "PG".toDetail(color: .white, textAlignment: .left)
    
    runTimeLabel.attributedText = "133".toDetail(color: .white, textAlignment: .left)
    
    popularityImageView.image = #imageLiteral(resourceName: "popcorn_Icon")
    
    popularityScoreLabel.attributedText = viewModel.popularityScore.toDetail(color: .white, textAlignment: .left)
    
    voteScoreImageView.image = #imageLiteral(resourceName: "likes_icon")
    
    voteScoreLabel.attributedText = viewModel.voteCount.toDetail(color: .white, textAlignment: .left)
  }
}
