//
//  DetailViewController.swift
//  MealDB
//
//  Created by Irfanul Arifa on 18/09/23.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var foodTitle: UILabel!
  @IBOutlet weak var foodCollection: UICollectionView!{
    didSet { register() }
  }
  
  let viewModel = DetailViewModel()
  var Category: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tabBarController?.tabBar.isHidden = true
    viewModel.reloadData = { [weak self] in
      DispatchQueue.main.async { self?.foodCollection.reloadData()
        self?.foodTitle.text = self?.Category
      }
    }
    viewModel.setupApi(categoryData: Category!)
  }
  
  func configure(category: String) {
    Category = category
  }
  
  private func register(){
    foodCollection.dataSource = self
    foodCollection.delegate = self
    foodCollection.register(UINib(nibName: "FoodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FoodCollectionViewCell")
  }
  
  private func delegate(_ foodid: String) {
    let storyboard = UIStoryboard(name: "Detail", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailFoodViewController") as? DetailFoodViewController else { return }
    guard let ingredients = storyboard.instantiateViewController(withIdentifier: "IngredientsViewController") as? IngredientsViewController else { return }
    guard let instruction = storyboard.instantiateViewController(withIdentifier: "InstructionsViewController") as? InstructionsViewController else { return }
    guard let video = storyboard.instantiateViewController(withIdentifier: "VideoViewController") as? VideoViewController else { return }
    
    vc.delegate(foodid)
    ingredients.configure(foodid)
    instruction.configure(foodid)
    video.configure(foodid)
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  @IBAction func backButton(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
}

extension DetailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfCell
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let data = viewModel.foodData[indexPath.item]
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCollectionViewCell", for: indexPath) as? FoodCollectionViewCell else { return UICollectionViewCell() }
    cell.foodImage.sd_setImage(with: URL(string: data.strMealThumb))
    cell.foodLabel.text = data.strMeal
    return cell
  }
}

extension DetailViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let data = viewModel.foodData[indexPath.item]
    delegate(data.idMeal)
  }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return viewModel.sizeForItem
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return viewModel.edgeInset
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return viewModel.minimumLineSpacing
  }
}
