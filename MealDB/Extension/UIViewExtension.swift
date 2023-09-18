//
//  UIViewExtension.swift
//  MealDB
//
//  Created by Irfanul Arifa on 18/09/23.
//

import UIKit

extension UIView {
  // MARK: set cornerRadius into View Setting
  @IBInspectable var cornerRadius: CGFloat {
    get { return self.cornerRadius }
    set { self.layer.cornerRadius = newValue}
  }
}
