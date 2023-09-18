//
//  SnackBar.swift
//  MealDB
//
//  Created by Irfanul Arifa on 18/09/23.
//

import SnackBar

class validSnackBar: SnackBar {
  
  override var style: SnackBarStyle {
    var style = SnackBarStyle()
    style.background = .green
    style.textColor = .black
    return style
  }
}

class invalidSnackBar: SnackBar {
  
  override var style: SnackBarStyle {
    var style = SnackBarStyle()
    style.background = .red
    style.textColor = .white
    return style
  }
}
