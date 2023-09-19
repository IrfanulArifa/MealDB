//
//  DetailFoodViewModel.swift
//  MealDB
//
//  Created by Irfanul Arifa on 18/09/23.
//

import UIKit

class DetailFoodViewModel {
  let network = Network()
  
  var detailData: [DetailData] = []
  var instruction: Detail?
  var ingredientsData: [String] = []
  var measureData: [String] = []
  var setData: (() -> Void)?
  var reloadData: (() -> Void)?
  
  func subFontSet() -> UIFont {
    return UIFont(name: "Poppins-Regular", size: 15)!
  }
  
  var numOfIngredients: Int {
    return ingredientsData.count
  }
  
  var numOfInstruction: Int {
    return 1
  }
  
  func setupApi(foodData: String) {
    network.getMealDetail(category: foodData) { [self] data in
      guard let data = data else { return }
      self.detailData = data.meals
      self.instruction = data
      setData?()
      
      ingredientsData = [
        data.meals[0].strIngredient1,
        data.meals[0].strIngredient2,
        data.meals[0].strIngredient3,
        data.meals[0].strIngredient4,
        data.meals[0].strIngredient5,
        data.meals[0].strIngredient6,
        data.meals[0].strIngredient7,
        data.meals[0].strIngredient8,
        data.meals[0].strIngredient9,
        data.meals[0].strIngredient10,
        data.meals[0].strIngredient11,
        data.meals[0].strIngredient12,
        data.meals[0].strIngredient13,
        data.meals[0].strIngredient14,
        data.meals[0].strIngredient15,
        data.meals[0].strIngredient16,
        data.meals[0].strIngredient17,
        data.meals[0].strIngredient18,
        data.meals[0].strIngredient19,
        data.meals[0].strIngredient20
      ]
      
      ingredientsData = ingredientsData.compactMap { $0 }.filter { !$0.isEmpty }
      
      measureData = [
        data.meals[0].strMeasure1,
        data.meals[0].strMeasure2,
        data.meals[0].strMeasure3,
        data.meals[0].strMeasure4,
        data.meals[0].strMeasure5,
        data.meals[0].strMeasure6,
        data.meals[0].strMeasure7,
        data.meals[0].strMeasure8,
        data.meals[0].strMeasure9,
        data.meals[0].strMeasure10,
        data.meals[0].strMeasure11,
        data.meals[0].strMeasure12,
        data.meals[0].strMeasure13,
        data.meals[0].strMeasure14,
        data.meals[0].strMeasure15,
        data.meals[0].strMeasure16,
        data.meals[0].strMeasure17,
        data.meals[0].strMeasure18,
        data.meals[0].strMeasure19,
        data.meals[0].strMeasure20
      ]
      measureData = measureData.compactMap { $0 }.filter { !$0.isEmpty }
      
      reloadData?()
    }
  }
}
