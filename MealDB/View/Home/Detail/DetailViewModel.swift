//
//  DetailViewModel.swift
//  MealDB
//
//  Created by Irfanul Arifa on 18/09/23.
//

import UIKit

class DetailViewModel {
  let network = Network()
  var foodData: [Foods] = []
  var reloadData: (()-> Void)?
  
  func fontSet() -> UIFont {
    return UIFont(name: "Poppins-SemiBold", size: 28)!
  }
  
  func setupApi(categoryData: String) {
    network.getMealData(category: categoryData) { [self] data in
      guard let data = data else { return }
      foodData = data.meals
      reloadData?()
    }
  }
  
  var numberOfCell: Int {
    return foodData.count
  }
  
  var minimumLineSpacing: CGFloat {
    return 20
  }
  
  var edgeInset: UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
  }
  
  var sizeForItem: CGSize {
    return CGSize(width: 165, height: 200)
  }
}
