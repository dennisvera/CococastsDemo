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
  
  @IBOutlet weak var backdropPosterImageView: UIImageView! {
    didSet {
      backdropPosterImageView.clipsToBounds = true
      backdropPosterImageView.contentMode = .scaleAspectFill
    }
  }
  
  @IBOutlet weak var playButton: UIButton! {
    didSet {
      let playButtonImage = #imageLiteral(resourceName: "play_button_icon").withRenderingMode(.alwaysTemplate)
      playButton.setImage(playButtonImage, for: .normal)
      playButton.tintColor = UIColor.FlickNite.white
    }
  }
  
  @IBOutlet weak var detailViewContainer: UIView! {
    didSet {
      detailViewContainer.backgroundColor = UIColor.FlickNite.mediumGray
    }
  }
  
  @IBOutlet weak var posterImageView: UIImageView! {
    didSet {
      posterImageView.clipsToBounds = true
      posterImageView.layer.cornerRadius = 14
      posterImageView.contentMode = .scaleAspectFit
    }
  }
  
  @IBOutlet weak var titleLabel: UILabel! {
    didSet {
      titleLabel.numberOfLines = 2
    }
  }
  
  @IBOutlet weak var heartImageView: UIImageView! {
    didSet {
      heartImageView.image = #imageLiteral(resourceName: "heart_icon").withRenderingMode(.alwaysTemplate)
      heartImageView.tintColor = UIColor.FlickNite.white
    }
  }
  
  @IBOutlet weak var popularityImageView: UIImageView! {
    didSet {
      popularityImageView.image = #imageLiteral(resourceName: "popcorn_Icon")
    }
  }
  
  @IBOutlet weak var voteScoreImageView: UIImageView! {
    didSet {
      voteScoreImageView.image = #imageLiteral(resourceName: "likes_icon")
    }
  }
  
  @IBOutlet weak var releaseDateLabel: UILabel!
  @IBOutlet weak var ratedLabel: UILabel!
  @IBOutlet weak var runTimeLabel: UILabel!
  @IBOutlet weak var popularityScoreLabel: UILabel!
  @IBOutlet weak var voteScoreLabel: UILabel!
  @IBOutlet weak var synopsisTextView: UITextView!
  @IBOutlet weak var synopsisTitleLabel: UILabel!
  
  // MARK: - Properties
  
  private let synopsisTitle = Strings.synopsisTitle
  
  var viewModel: MovieDetailViewModel?
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    setupNavigationBar()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    setNavigationBarToClear()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    
    // Remove Navigation Bar Back Button Title
    self.navigationItem.title = ""
    
    navigationController?.navigationBar.isTranslucent = false
  }
  
  // MARK: - Helper Methods
  
  private func setupNavigationBar() {
    navigationItem.largeTitleDisplayMode = .never
    navigationController?.navigationBar.tintColor = UIColor.FlickNite.white
  }
  
  private func setNavigationBarToClear() {
    // Make the navigation bar background clear
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
  }
  
  private func setupViews() {
    guard let viewModel = viewModel else { return }
    
    backdropPosterImageView.sd_setImage(with: URL(string: viewModel.backdropPath ?? ""))
    
    posterImageView.sd_setImage(with: URL(string: viewModel.posterPath ?? ""))
    
    titleLabel.attributedText = viewModel.title.toTtitle(color: UIColor.FlickNite.white,
                                                         textAlignment: .left)
    
    releaseDateLabel.attributedText = viewModel.releaseDate.toSubtitle(color: UIColor.FlickNite.lightGray,
                                                                       textAlignment: .left)
    
    ratedLabel.attributedText = "PG".toSubtitle(color: UIColor.FlickNite.lightGray,
                                                textAlignment: .left)
    
    runTimeLabel.attributedText = "133".toSubtitle(color: UIColor.FlickNite.lightGray,
                                                   textAlignment: .left)
        
    popularityScoreLabel.attributedText = viewModel.popularityScore.toDetail(color: UIColor.FlickNite.white,
                                                                             textAlignment: .left)
        
    voteScoreLabel.attributedText = viewModel.voteCount.toDetail(color: UIColor.FlickNite.white,
                                                                 textAlignment: .left)
    
    synopsisTitleLabel.attributedText? = synopsisTitle.toSubtitleBold(color: UIColor.FlickNite.white,
                                                                      textAlignment: .left)
    
    synopsisTextView.backgroundColor = UIColor.FlickNite.darkGray
    synopsisTextView.attributedText = viewModel.synopsis.toSubtitle(color: UIColor.FlickNite.lightGray,
                                                                    textAlignment: .left)
  }
  
  // MARK: - Actions
  
  @IBAction func playButton(_ sender: Any) {
    playButton.tintColor = UIColor.FlickNite.white

    // Notify View Model
    viewModel?.showMovieTrailer()
  }
}
