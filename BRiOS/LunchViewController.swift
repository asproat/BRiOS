//
//  LunchViewController.swift
//  BRiOS
//
//  Created by BR Test on 4/24/21.
//

import Foundation
import UIKit

class LunchViewController : UIViewController {
    
    // MARK: - Properties
        
    private var restaurants = [Restaurant]()
    private let fileManager = FileManager.default
    private let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    private var currentWidth = CGFloat(0.0)
    private var selectedRestaurant : Restaurant? = nil
    
    // MARK: - IBOutlets
    
    @IBOutlet var restaurantCollection: UICollectionView!
    
    // MARK: - Lifecycle
        
    override
    func viewDidLoad() {
        super.viewDidLoad()
        
        currentWidth = view.frame.width
    }
    
    override
    func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadRestaurants()
        setUpCollectionView()
    }
    
    override
    func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        currentWidth = size.width
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            restaurantCollection.reloadData()
        }
    }
    
    override
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let detailController = segue.destination as? RestaurantDetailViewController {
                if let cell = sender as? RestaurantCell {
                    detailController.detailRestaurant = restaurants[cell.row]
                }
            }
        }
        else if segue.identifier == "map" {
            if let detailController = segue.destination as? MapViewController {
                detailController.restaurants = restaurants
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func mapButtonTapped(_ sender: UIButton) {
    }
    
    // MARK: - Private
    
    private func setUpCollectionView() {
        restaurantCollection.dataSource = self
        restaurantCollection.delegate = self
    }
    
    private func showError(errorType: String) {
        let alert = UIAlertController.init(title: "Error", message: errorType, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        alert.show(self, sender: nil)
        
    }
    
    private func loadRestaurants() {
        guard let restaurantURL = URL(string: "https://s3.amazonaws.com/br-codingexams/restaurants.json") else { return }
        
        let restaurantSessionTask = URLSession.shared.dataTask(with: restaurantURL) {
            data, response, error in
            if let error = error {
                self.showError(errorType: "Could Not Fetch Restaurants")
            }
            if let myResponse = response {
                if let mimeType = myResponse.mimeType, mimeType == "application/json",
                   let data = data  {
                    let decoder = JSONDecoder()
                    do {
                        let downloadedRestaurants = try decoder.decode(Restaurants.self, from: data)
                        
                        self.restaurants = downloadedRestaurants.restaurants
                        
                        DispatchQueue.main.async() {
                            self.restaurantCollection.reloadData()
                        }
                    }
                    catch {
                        self.showError(errorType: "Error Parsing Data")
                    }
                }
            }
            
        }
        restaurantSessionTask.resume()
    }
    
    private func loadBackgroundImage(imageURL: String, filePath: String, cell: RestaurantCell) {
        guard let image = URL(string: imageURL) else { return }
        
        let restaurantSessionTask = URLSession.shared.dataTask(with: image) {
            data, response, error in
            if let error = error {
                return
            }
            if let myResponse = response {
                if myResponse.mimeType?.hasPrefix("image") == true,
                   let data = data {
                    self.fileManager.createFile(atPath: filePath, contents: data, attributes: nil)
                    
                    DispatchQueue.main.async() {
                        cell.backgroundImage.image = UIImage(data: data)
                    }
                }
            }
            
        }
        restaurantSessionTask.resume()
    }
    
}

extension LunchViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! RestaurantCell
        
        let restaurant = restaurants[indexPath.row]
        
        cell.name.text = restaurant.name
        cell.category.text = restaurant.category
        cell.backgroundImage.image = nil
        cell.row = indexPath.row
        
        // get image, try cache first
        if let fileName = URL(string: restaurant.backgroundImageURL)?.lastPathComponent {
            let fileLocation = documentDirectory.appendingPathComponent(fileName).absoluteString
            if fileManager.fileExists(atPath: fileLocation) {
                cell.backgroundImage.image = UIImage(contentsOfFile: fileLocation)
            }
            else {
                // load from web and save
                loadBackgroundImage(imageURL: restaurant.backgroundImageURL,
                                    filePath: fileLocation, cell: cell)
            }
        }
        return cell
    }
    
}

extension LunchViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        var cellWidth = currentWidth
        if UIDevice.current.userInterfaceIdiom  == .pad {
            cellWidth = currentWidth / 2.0 - 10.0
        }
        
        return CGSize(width: cellWidth, height: 180)
    }
}
