//
//  NowPlayingViewController.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 5/28/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController, Storyboardable {
    
     // MARK: - Storyboardable
    
    static var storyboardName: String {
        return "NowPlaying"
    }
    
    // MARK: - Initialization
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // Set Title
        title = "Now Playing"
    }
}
