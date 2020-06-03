//
//  APIProtocol.swift
//  CococastsDemo
//
//  Created by Dennis Vera on 6/3/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import Foundation

internal protocol APIProtocol: AnyObject {
  
  func fetchMovies(_ completion: @escaping (Result<MovieResponse, APIError>) -> Void)
}