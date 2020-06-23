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
  
  let youTubeEmbedString = "https://www.youtube.com/embed/"
      
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.FlickNite.darkGray
    
    playVideo()
  }
  
  // MARK: - Helper Methods
  
  func playVideo() {
    guard let videoURL = URL(string: youTubeEmbedString + "M6E8gPmz7n4") else { fatalError() }
    webView.load(URLRequest(url: videoURL))
  }
}
