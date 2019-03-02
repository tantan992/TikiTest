//
//  ViewController.swift
//  TikiTest
//
//  Created by Tan Tan on 3/2/19.
//  Copyright © 2019 Tan Tan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    var products: [ Product ]?
    let colors = [UIColor.init(hex: "#16702e"), UIColor.init(hex: "#005a51"), UIColor.init(hex: "#996c00"), UIColor.init(hex: "#5c0a6b"), UIColor.init(hex: "#006d90"), UIColor.init(hex: "#974e06"), UIColor.init(hex: "#99272e"), UIColor.init(hex: "#89221f"), UIColor.init(hex: "#00345d")]
    
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        products = [Product]()
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
//            layout.estimatedItemSize = CGSize(width: 112, height: collectionView.bounds.size.height)
            layout.minimumLineSpacing = 16
        }
        collectionView.delegate = self
        collectionView.register(CollectionViewCustomCell.self, forCellWithReuseIdentifier: cellID)
        
        TManager.sharedInstance.dataService.loadListProduct { [weak self ] (products, error) in
            self?.products = products
            self?.collectionView.dataSource = self
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (products?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let product = products![indexPath.row]
        let width = product.keyword.size(withAttributes: [.font : UIFont.systemFont(ofSize: 14)]).width + 32
        
        return CGSize(width: width, height: collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CollectionViewCustomCell
        if let product = products?[indexPath.row]{
            let colorIndex = indexPath.row%colors.count
            cell.configCell(product: product)
            cell.descriptionView.backgroundColor = colors[colorIndex]
        }
        
        return cell
    }
    
    


}

