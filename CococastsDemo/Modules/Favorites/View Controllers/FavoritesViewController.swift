//
//  FavoritesViewController.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 5/28/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, Storyboardable {
  
  // MARK: - Storyboardable
  
  static var storyboardName: String {
    return "Favorites"
  }
  
  // MARK: - Initialization
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    // Set Title
    title = "Favorites"
  }
}
