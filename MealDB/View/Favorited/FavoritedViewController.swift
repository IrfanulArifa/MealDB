//
//  FavoritedViewController.swift
//  MealDB
//
//  Created by Irfanul Arifa on 18/09/23.
//

import UIKit
import SDWebImage

class FavoritedViewController: UIViewController {
  
  @IBOutlet weak var favoriteKosong: UILabel!{
    didSet { favoriteKosong.isHidden = true }
  }
  @IBOutlet weak var favoriteLabel: UILabel!
  @IBOutlet weak var favoriteCollection: UICollectionView!{
    didSet { register() }
  }
  
  let coreData = CoreDataManager()
  let viewModel = DetailViewModel()
  var favoriteData: [FavoriteModel] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tabBarController?.tabBar.isHidden = false
    setup()
  }
  
  func setup() {
    coreData.retrieve { [weak self] data in
      if data.isEmpty {
        self?.favoriteKosong.isHidden = false
      } else {
        self?.favoriteKosong.isHidden = true
      }
      self?.favoriteData = data
      self?.favoriteCollection.reloadData()
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.tabBar.isHidden = false
    setup()
  }
  
  private func register() {
    favoriteCollection.dataSource = self
    favoriteCollection.delegate = self
    favoriteCollection.register(UINib(nibName: "FoodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FoodCollectionViewCell")
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
}

extension FavoritedViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let data = favoriteData[indexPath.item]
    delegate(data.foodid)
  }
}

extension FavoritedViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return favoriteData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let data = favoriteData[indexPath.item]
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCollectionViewCell", for: indexPath) as? FoodCollectionViewCell else { return UICollectionViewCell() }
    cell.foodImage.sd_setImage(with: URL(string: data.foodimage))
    cell.foodLabel.text = data.foodname.capitalized
    return cell
  }
}

extension FavoritedViewController: UICollectionViewDelegateFlowLayout {
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
