//
//  MyListCollectionViewCell.swift
//  OrderApp
//
//  Created by Celil Aydın on 11.01.2023.
//

import UIKit
import SDWebImage

class MyListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myListImageView: UIImageView!
    
    static let identifier = String(describing: MyListCollectionViewCell.self)
    
    func setup(_ slide: MyListSlide){
        myListImageView.sd_setImage(with: URL(string: slide.imageUrl))
    }
}
