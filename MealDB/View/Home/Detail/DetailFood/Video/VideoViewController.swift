//
//  VideoViewController.swift
//  MealDB
//
//  Created by Irfanul Arifa on 18/09/23.
//

import UIKit
import SafariServices
import SDWebImage


class VideoViewController: UIViewController {
  
  @IBOutlet weak var videoImage: UIImageView!
  let viewModel = DetailFoodViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.setData = {
      DispatchQueue.main.async { [weak self] in
        self?.videoImage.sd_setImage(with: URL(string: (self?.viewModel.instruction?.meals[0].strMealThumb)!))
      }
    }
    
    viewModel.setupApi(foodData: foodid!)
  }
  
  func configure(_ foodId: String) {
    foodid = foodId
  }
  
  @IBAction func playTutorial(_ sender: UIButton) {
    guard let url = URL(string: (viewModel.instruction?.meals[0].strYoutube)!) else { return }
    let safariViewController = SFSafariViewController(url: url)
    present(safariViewController, animated: true, completion: nil)
  }
  
}
