//
//  RootViewController.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 5/28/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var baseTabBarController: UITabBarController = {
        guard let tabBarController = UIStoryboard(name: "Main",
                                                  bundle: .main).instantiateInitialViewController() as? UITabBarController else {
                                                    fatalError("Unable to Instantiate Tab Bar Controller")
        }
        return tabBarController
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Child View Controllers
        setupChildViewControllers()
    }
    
    // MARK: - Helper Methods
    
    private func setupChildViewControllers() {
        // Add Child View Controller
        addChild(baseTabBarController)
        
        // Add Child View as Subview
        view.addSubview(baseTabBarController.view)

        // Configure Child View
        baseTabBarController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        baseTabBarController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        baseTabBarController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        baseTabBarController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Notify Child View Controller
        baseTabBarController.didMove(toParent: self)
    }
}
