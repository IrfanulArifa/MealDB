//
//  ViewController.swift
//  MealDB
//
//  Created by Irfanul Arifa on 18/09/23.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
  
  let viewModel = HomeViewModel()

  @IBOutlet weak var homeLabel: UILabel!{
    didSet { homeLabel.font = viewModel.fontSet() /* Set Font Style  */}
  }
  
  @IBOutlet weak var categoryCollection: UICollectionView!{
    didSet { register() }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.reloadData = { [weak self] in
      DispatchQueue.main.async { self?.categoryCollection.reloadData() }
    }
    viewModel.setupApi()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.tabBar.isHidden = false
  }
  
  private func register() {
    categoryCollection.dataSource = self
    categoryCollection.delegate = self
    categoryCollection.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
  }
  
  private func delegate(_ data: String) {
    let storyboard = UIStoryboard(name: "Detail", bundle: nil)
    guard let vc = storyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
    vc.configure(category: data)
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

extension ViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let data = viewModel.categoryData[indexPath.item]
    delegate(data.strCategory)
  }
}

extension ViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfCell
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let data = viewModel.categoryData[indexPath.item]
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as? CategoriesCollectionViewCell else { return UICollectionViewCell() }
    cell.categoryImage.sd_setImage(with: URL(string: data.strCategoryThumb))
    cell.categoryLabel.text = data.strCategory
    return cell
  }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return viewModel.sizeForItem
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return viewModel.edgeInset
  }
}
