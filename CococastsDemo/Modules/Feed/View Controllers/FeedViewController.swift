//
//  FeedViewController.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 5/28/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, Storyboardable {
    
     // MARK: - Storyboardable
    
    static var storyboardName: String {
        return "Feed"
    }
    
    // MARK: - Initialization
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // Set Title
        title = "Feed"
    }
}
