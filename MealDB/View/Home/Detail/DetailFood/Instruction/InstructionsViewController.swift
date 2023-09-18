//
//  InstructionsViewController.swift
//  MealDB
//
//  Created by Irfanul Arifa on 18/09/23.
//

import UIKit

class InstructionsViewController: UIViewController {
  
  @IBOutlet weak var instructionTableView: UITableView!{
    didSet { register() }
  }
  
  let viewModel = DetailFoodViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.reloadData = {
      DispatchQueue.main.async { [weak self] in
        self?.instructionTableView.reloadData()
      }
    }
    
    viewModel.setupApi(foodData: foodid!)
  }
  
  func configure(_ foodId: String) {
    foodid = foodId
  }
  
  func register() {
    instructionTableView.dataSource = self
    instructionTableView.register(UINib(nibName: "InstructionTableViewCell", bundle: nil), forCellReuseIdentifier: "InstructionTableViewCell")
  }
}

extension InstructionsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numOfInstruction
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numOfInstruction
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row < 1 {
      let data = viewModel.instruction?.meals[indexPath.row]
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionTableViewCell") as? InstructionTableViewCell else { return UITableViewCell() }
      cell.instructionLabel.text = data?.strInstructions
      return cell
    } else {
      return UITableViewCell()
    }
  }
}

extension InstructionsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}
