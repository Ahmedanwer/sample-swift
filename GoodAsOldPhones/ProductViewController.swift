//
//  ViewController.swift
//  GoodAsOldPhones
//
//  Copyright © 2016 Code School. All rights reserved.
//

import UIKit
import Instabug

class ProductViewController: UIViewController {

  @IBOutlet var productImageView: UIImageView!
  @IBOutlet var productNameLabel: UILabel!
  
  var product: Product?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    productNameLabel.text = product?.name
    
    if let imageName = product?.fullscreenImageName {
      productImageView.image = UIImage(named: imageName)
    }
  }

  @IBAction func addToCartButtonDidTap(_ sender: AnyObject) {
    print("Add to cart successfully")
    productImageView.alpha = 0
    
    Instabug.logUserEvent(withName: "Add to cart")

    
    let url = URL(string: "https://github.com/api/getallpages")
    
    let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
        
        if let data = data {
            do {
                // Convert the data to JSON
                let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                
                if let json = jsonSerialized, let url = json["url"], let explanation = json["explanation"] {
                    print(url)
                    print(explanation)
                }
            }  catch let error as NSError {
                print(error.localizedDescription)
            }
        } else if let error = error {
            print(error.localizedDescription)
        }
    }
    
    task.resume()
  }
}
