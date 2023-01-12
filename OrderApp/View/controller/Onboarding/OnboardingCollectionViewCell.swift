//
//  OnboardingCollectionViewCell.swift
//  OrderApp
//
//  Created by Celil Aydın on 12.01.2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var onboardingImageView: UIImageView!
    @IBOutlet weak var onboardingTitleLabel: UILabel!
    @IBOutlet weak var onboardingDescLabel: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        onboardingImageView.image = slide.image
        onboardingTitleLabel.text = slide.title
        onboardingDescLabel.text = slide.description
    }
    
}
