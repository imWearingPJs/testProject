//
//  ViewController.swift
//  testProject
//
//  Created by Michael Kozub on 2/22/19.
//  Copyright © 2019 Michael Kozub. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage
import SVProgressHUD

struct Offer {
    //let id: String
    let url: String?
//    let name: String
//    let description: String
//    let terms: String
//    let currentValue : String
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        readJSONFromFile(fileName: "Offers")
        print(offers.count)
    }
    
    var offers = [Offer]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(offers.count)
        return offers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let imageUrl = URL(string: offers[indexPath.item].url!)!
        print(offers[indexPath.item])
        print(imageUrl)
        cell.offerImage.sd_setImage(with: imageUrl)
        
        return cell
    }
    
    func readJSONFromFile(fileName: String) {
        SVProgressHUD.show()
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl)
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    //print(json!)
                    for item in json! {
                        //print(item["url"]!)
                        let offer = Offer(
                            url: item["url"] as? String
                        )
                        offers.append(offer)
                    }
                    print(offers.count)
                    //collectionView.reloadData()
                    SVProgressHUD.dismiss()
                }
                
            } catch {
                
            }
        }
    }

}

