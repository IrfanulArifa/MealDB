//
//  Network.swift
//  MealDB
//
//  Created by Irfanul Arifa on 18/09/23.
//

import Foundation

class Network {
  
  func getMealCategory(completion: @escaping (Welcome?) -> Void) {
    let decoder = JSONDecoder()
    let baseURL = Endpoint.APIAddress() + Endpoint.Path.categories.rawValue
    
    let url = URL(string: baseURL)!
    
    let request = URLRequest(url: url)
    let session = URLSession.shared
    
    let task = session.dataTask(with: request) { data, response, error in
      guard let httpResponse = response as? HTTPURLResponse else { return }
      guard let data = data else {
        print("Tidak ada data yang diterima"); return
      }
      if httpResponse.statusCode != 200 {
        print("Error JSON: ", httpResponse.statusCode)
      } else {
        do {
          let result = try decoder.decode(Welcome.self, from: data)
          completion(result)
        } catch {
          print("Error decoding JSON: ", error)
        }
      }
    }
    task.resume()
  }
  
  func getMealData(category: String, completion: @escaping (Food?) -> Void) {
    let decoder = JSONDecoder()
    let baseURL = Endpoint.APIAddress() + Endpoint.Path.filter.rawValue
    var component = URLComponents(string: baseURL)
    component?.queryItems = [
      URLQueryItem(name: "c", value: category)
    ]
    
    let request = URLRequest(url: (component?.url)!)
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
      guard let httpResponse = response as? HTTPURLResponse else { return }
      guard let data = data else {
        print("Tidak ada data yang diterima"); return
      }
      if httpResponse.statusCode != 200 {
        print("Error JSON: ", httpResponse.statusCode)
      } else {
        do {
          let result = try decoder.decode(Food.self, from: data)
          completion(result)
        } catch {
          print("Error decoding Food JSON: ", error)
        }
      }
    }
    task.resume()
  }
  
  func getMealDetail(category: String, completion: @escaping (Detail?) -> Void?) {
    let decoder = JSONDecoder()
    let baseURL = Endpoint.APIAddress() + Endpoint.Path.lookup.rawValue
    var component = URLComponents(string: baseURL)
    component?.queryItems = [
      URLQueryItem(name: "i", value: category)
    ]
    
    let request = URLRequest(url: (component?.url)!)
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
      guard let httpResponse = response as? HTTPURLResponse else { return }
      guard let data = data else {
        print("Tidak ada data yang diterima"); return
      }
      if httpResponse.statusCode != 200 {
        print("Error JSON: ", httpResponse.statusCode)
      } else {
        do {
          let result = try decoder.decode(Detail.self, from: data)
          completion(result)
        } catch {
          print("Error decoding Food JSON: ", error)
        }
      }
    }
    task.resume()
  }
}
