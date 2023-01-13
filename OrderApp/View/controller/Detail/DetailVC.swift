//
//  DetailVC.swift
//  OrderApp
//
//  Created by Celil Aydın on 13.01.2023.
//

import UIKit
import SDWebImage

class DetailVC: UIViewController {
    
    @IBOutlet weak var detailImageVİew: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var detailValue = Detail(username: "", imageUrl: "", title: "", price: "", category: "", desc: "", date: "")
    
    var imageUrl:String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }

}

extension DetailVC {
    
    func setView(){
        detailImageVİew.sd_setImage(with: URL(string: detailValue.imageUrl))
        titleLabel.text = detailValue.title
        priceLabel.text = detailValue.price.currencyInputFormatting()
        categoryLabel.text = detailValue.category
        usernameLabel.text = detailValue.username
        dateLabel.text = detailValue.date
        descLabel.text = detailValue.desc
    }
    
}
