//
//  Endpoint.swift
//  MealDB
//
//  Created by Irfanul Arifa on 18/09/23.
//

import Foundation

class Endpoint {
  static func APIAddress() -> String {
    let baseURL = "https://www.themealdb.com/api/json/v1/1/"
    return baseURL
  }
  
  enum Path: String {
    case categories = "categories.php"
    case filter = "filter.php"
    case lookup = "lookup.php"
  }
}
