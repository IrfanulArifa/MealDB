//
//  IngredientsTableViewCell.swift
//  MealDB
//
//  Created by Irfanul Arifa on 18/09/23.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
  
  @IBOutlet weak var ingredientLabel: UILabel!{
    didSet { ingredientLabel.font = DetailFoodViewModel().subFontSet() }
  }
  
  @IBOutlet weak var measureLabel: UILabel!{
    didSet { measureLabel.font = DetailFoodViewModel().subFontSet() }
  }
    
}
