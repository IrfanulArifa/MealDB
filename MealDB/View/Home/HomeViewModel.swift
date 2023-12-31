//
//  HomeViewModel.swift
//  MealDB
//
//  Created by Irfanul Arifa on 18/09/23.
//

import UIKit

class HomeViewModel {
  
  let network = Network()
  var categoryData: [Category] = []
  var reloadData: (()-> Void)?
  
  func setupApi() {
    network.getMealCategory { [self] data in
      guard let data = data else { return }
      categoryData = data.categories
      reloadData?()
    }
  }
  
  var numberOfCell: Int {
    return categoryData.count
  }
  
  var sizeForItem: CGSize {
    return CGSize(width: 165, height: 200)
  }
  
  var edgeInset: UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
  }
  
}
