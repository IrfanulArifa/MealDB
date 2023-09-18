//
//  IngredientsTableViewCell.swift
//  MealDB
//
//  Created by Irfanul Arifa on 18/09/23.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
  
  @IBOutlet weak var ingredientLabel: UILabel!
  @IBOutlet weak var measureLabel: UILabel!
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
