//
//  IngredientsViewController.swift
//  MealDB
//
//  Created by Irfanul Arifa on 18/09/23.
//

import UIKit

var foodid: String?

class IngredientsViewController: UIViewController {
  
  @IBOutlet weak var ingredientTableView: UITableView! {
    didSet { register() }
  }
  
  let viewModel = DetailFoodViewModel()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.reloadData = { [weak self] in
      DispatchQueue.main.async { self?.ingredientTableView.reloadData() }
    }
    
    viewModel.setupApi(foodData: foodid!)
  }
  
  func configure(_ foodId: String) {
    foodid = foodId
  }
  
  private func register() {
    ingredientTableView.dataSource = self
    ingredientTableView.register(UINib(nibName: "IngredientsTableViewCell", bundle: nil), forCellReuseIdentifier: "IngredientsTableViewCell")
  }
}

extension IngredientsViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numOfIngredients
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let dataIngredients = viewModel.ingredientsData[indexPath.row]
    let dataMeasure = viewModel.measureData[indexPath.row]
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsTableViewCell") as? IngredientsTableViewCell else { return UITableViewCell() }
    cell.ingredientLabel.text = dataIngredients.capitalized
    cell.measureLabel.text = dataMeasure.capitalized
    return cell
  }
}
