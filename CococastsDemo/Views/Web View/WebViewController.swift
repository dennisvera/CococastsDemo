//
//  WebViewController.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 6/22/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, Storyboardable {
  
  // MARK: - Outlets
    
  @IBOutlet weak var webView: WKWebView!
    
  // MARK: - Properties
  
  var videoId: String?
  private let youTubeEmbedString = "https://www.youtube.com/embed/"
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    playMovieTrailer()
  }
  
  // MARK: - Helper Methods
  
  private func setupViews() {
    // Configure View
    view.backgroundColor = UIColor.FlickNite.darkGray
    
    // Configure Web View
    webView.isOpaque = false
    webView.clipsToBounds = true
    webView.contentMode = .scaleAspectFit
    webView.backgroundColor = UIColor.FlickNite.darkGray
  }
  
  func playMovieTrailer() {
    guard let videoId = videoId else { return }
    guard let videoURL = URL(string: youTubeEmbedString + videoId) else { fatalError() }
    webView.load(URLRequest(url: videoURL))
  }
}
