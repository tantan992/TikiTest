//
//  CollectionViewCustomCell.swift
//  TikiTest
//
//  Created by Tan Tan on 3/2/19.
//  Copyright © 2019 Tan Tan. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCustomCell : UICollectionViewCell {
    
    var icon : UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blue
        
        return imageView
    }()
    
    var descriptionView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5.0
        view.clipsToBounds = true
        return view
    }()
    
    var title : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byTruncatingMiddle
        label.adjustsFontSizeToFitWidth = false
        label.textColor = .white
        return label
    }()
    
    var product:Product?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    func customInit() {
        addSubview(icon)
        
        addSubview(descriptionView)
        
        descriptionView.addSubview(title)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0(96)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":icon]))
        addConstraint(NSLayoutConstraint(item: icon, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":descriptionView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":title]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0(96)]-8-[v1(80)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":icon,"v1":descriptionView]))
    
        addConstraint(NSLayoutConstraint(item: title, attribute: .centerY, relatedBy: .equal, toItem: descriptionView, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
    func configCell(product : Product?) {
        guard let obj = product else { return }
        self.product = obj
        let str = obj.keyword.trimmingCharacters(in: .whitespacesAndNewlines)
        let space = str.filter{$0 == " "}.count
        
        title.numberOfLines = space == 0 ? 1 : 2
        title.text = str

        guard let url = obj.icon else { return }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: URL(string: url)!)
            let image = UIImage(data: data!)
            DispatchQueue.main.async(execute: {
                self.icon.image = image
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
