//
//  CoreDataManager.swift
//  MealDB
//
//  Created by Irfanul Arifa on 18/09/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
  
  var presentAlertSucces: (() -> Void)?
  var presentAlertFailed: (() -> Void)?
  let appDelegate = UIApplication.shared.delegate as? AppDelegate
  
  func create(_ foodModel: FavoriteModel) {
    guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
    let userEntity = NSEntityDescription.entity(forEntityName: "MealDB", in: managedContext)
    let insert = NSManagedObject(entity: userEntity!, insertInto: managedContext)
    insert.setValue(foodModel.foodid, forKey: "foodid")
    insert.setValue(foodModel.foodimage, forKey: "foodimage")
    insert.setValue(foodModel.foodname, forKey: "foodname")
    
    do {
      try managedContext.save()
        presentAlertSucces?()
      } catch let error {
        print("Failed to create data", error)
        presentAlertFailed?()
    }
  }
  
  func retrieve(completion: @escaping ([FavoriteModel]) -> Void) {
    var foodData = [FavoriteModel]() // Mulai dengan array kosong
    
    let managedContext = appDelegate?.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MealDB")
    
    do {
      let result = try managedContext?.fetch(fetchRequest)
      result?.forEach { allFoodData in
        let food = FavoriteModel(
          foodid: allFoodData.value(forKey: "foodid") as! String,
          foodimage: allFoodData.value(forKey: "foodimage") as! String,
          foodname: allFoodData.value(forKey: "foodname") as! String
        )
        foodData.append(food)
      }
      completion(foodData) // Mengirimkan data yang ditemukan
    } catch let error {
      print("Failed to fetch data", error)
    }
  }
  
  func delete(_ foodModel: FavoriteModel, completion: @escaping () -> Void) {
    guard let managedContext = appDelegate?.persistentContainer.viewContext else {
      return }
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "MealDB")
    fetchRequest.predicate = NSPredicate(format: "foodid = %@", foodModel.foodid)
    
    do {
      let result = try managedContext.fetch(fetchRequest)
      
      for dataToDelete in result {
        managedContext.delete(dataToDelete as! NSManagedObject)
      }
      try managedContext.save()
      completion()
    } catch let error {
      print("Unable to delete data", error)
    }
  }
}
