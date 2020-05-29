//
//  LibraryCoordinator.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 5/29/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class LibraryCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var rootViewController: UIViewController {
        return libraryViewController
    }
    
    private let libraryViewController = LibraryViewController.instantiate()
}
