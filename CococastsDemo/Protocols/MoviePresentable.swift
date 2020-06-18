//
//  MoviePresentable.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 6/2/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

protocol MoviePresentable {
  
  // MARK: - Properties
  
  var title: String { get }
  var posterPath: String? { get }
  var backdropPath: String? { get }
}

extension Movie: MoviePresentable {}
