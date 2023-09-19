//
//  InstructionTableViewCell.swift
//  MealDB
//
//  Created by Irfanul Arifa on 18/09/23.
//

import UIKit

class InstructionTableViewCell: UITableViewCell {

  @IBOutlet weak var instructionLabel: UILabel!{
    didSet { instructionLabel.font = DetailFoodViewModel().subFontSet() }
  }
    
}
