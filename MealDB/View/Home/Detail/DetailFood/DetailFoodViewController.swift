//
//  DetailFoodViewController.swift
//  MealDB
//
//  Created by Irfanul Arifa on 18/09/23.
//

import UIKit
import SDWebImage

class DetailFoodViewController: UIViewController {
  
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  @IBOutlet weak var foodDetailImage: UIImageView!
  @IBOutlet weak var ingredientsSegmentView: UIView!
  @IBOutlet weak var instructionSegmentView: UIView!
  @IBOutlet weak var videoSegmentView: UIView!
  
  @IBOutlet weak var foodDetailName: UILabel!{
    didSet { foodDetailName.font = viewModel.subFontSet() }
  }
  
  @IBOutlet weak var foodDetailCategory: UILabel!{
    didSet { foodDetailCategory.font = viewModel.subFontSet() }
  }
  
  @IBOutlet weak var foodDetailArea: UILabel!{
    didSet { foodDetailArea.font = viewModel.subFontSet() }
  }
  
  @IBOutlet weak var favoriteBtn: UIButton!{
    didSet { favoriteBtn.setImage(UIImage(systemName: "heart"), for: .normal)}
  }
  
  var foodId: String?
  let viewModel = DetailFoodViewModel()
  let coreData = CoreDataManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tabBarController?.tabBar.isHidden = true
    viewModel.setData = { [weak self] in
      DispatchQueue.main.async { [weak self] in
        self?.foodDetailImage.sd_setImage(with: URL(string: (self?.viewModel.detailData[0].strMealThumb)!))
        self?.foodDetailArea.text = self?.viewModel.detailData[0].strArea
        self?.foodDetailCategory.text = self?.viewModel.detailData[0].strCategory
        self?.foodDetailName.text = self?.viewModel.detailData[0].strMeal
      }
    }
    
    viewModel.setupApi(foodData: foodId!)
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.tabBarController?.tabBar.isHidden = true
    setup()
  }
  
  func delegate(_ food: String) {
    foodId = food
  }
  
  func setup() {
    coreData.retrieve { [weak self] data in
      for datum in data {
        if datum.foodid == self?.foodId {
          self?.favoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
          self?.favoriteBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
      }
    }
  }
  
  @IBAction func backButton(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func loveClicked(_ sender: UIButton) {
    let foodData = FavoriteModel(foodid: foodId!, foodimage: viewModel.detailData[0].strMealThumb, foodname: viewModel.detailData[0].strMeal)
    
    if favoriteBtn.currentImage == UIImage(systemName: "heart") {
      coreData.presentAlertFailed = {
        DispatchQueue.main.async { [weak self] in
          invalidSnackBar.make(in: self!.view, message: "Failed add to Favorite Meal", duration: .lengthLong).show()
        }
      }
      
      coreData.presentAlertSucces = {
        DispatchQueue.main.async { [weak self] in
          validSnackBar.make(in: self!.view, message: "Add to Favorite Meal", duration: .lengthLong).show()
          self?.favoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
      }
      
      coreData.create(foodData)
    } else if favoriteBtn.currentImage == UIImage(systemName: "heart.fill"){
      self.coreData.delete(foodData) { [weak self] in
        self?.favoriteBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        DispatchQueue.main.async {
          invalidSnackBar.make(in: self!.view, message: "Delete Meal", duration: .lengthLong).show()
        }
      }
    }
  }
  
  @IBAction func segmentedControl(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex{
    case 0:
      ingredientsSegmentView.isHidden = false
      instructionSegmentView.isHidden = true
      videoSegmentView.isHidden = true
    case 1:
      ingredientsSegmentView.isHidden = true
      instructionSegmentView.isHidden = false
      videoSegmentView.isHidden = true
    case 2:
      ingredientsSegmentView.isHidden = true
      instructionSegmentView.isHidden = true
      videoSegmentView.isHidden = false
    default:
      break
    }
  }
}
