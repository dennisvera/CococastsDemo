//
//  FeedCoordinator.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 5/29/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class FeedCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var rootViewController: UIViewController {
        return feedViewController
    }
    
    private let feedViewController = FeedViewController.instantiate()
}
