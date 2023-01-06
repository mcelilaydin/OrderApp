//
//  AdvertCell.swift
//  OrderApp
//
//  Created by Celil Aydın on 6.01.2023.
//

import UIKit

class AdvertCell: UITableViewCell {
    
    @IBOutlet weak var advertİmageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static var identifier = "AdvertCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
