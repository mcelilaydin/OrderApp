//
//  AdvertCollectionViewCell.swift
//  OrderApp
//
//  Created by Celil Aydın on 5.01.2023.
//

import UIKit

class AdvertCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var slideImageView: UIImageView!
    
    static let identifier = String(describing: AdvertCollectionViewCell.self)
    
    func setup(_ slide: AdvertSlide) {
        slideImageView.image = slide.image
    }
    
}
