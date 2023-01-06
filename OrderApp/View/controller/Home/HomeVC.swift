//
//  HomeVC.swift
//  OrderApp
//
//  Created by Celil Aydın on 3.01.2023.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var advertCollectionView: UICollectionView!
    
    var advertSlide: [HomeSlide] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        advertCollectionView.delegate = self
        advertCollectionView.dataSource = self
        advertSlide = [
            HomeSlide(image:UIImage(named: "ball")!), //phone
            HomeSlide(image:UIImage(named: "ball")!),
            HomeSlide(image:UIImage(named: "ball")!),
            HomeSlide(image:UIImage(named: "ball")!)
        ]

        // Do any additional setup after loading the view.
    }
    
    @IBAction func profileButtonClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "profile") as? ProfileVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension HomeVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return advertSlide.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvertCollectionViewCell.identifier, for: indexPath) as! AdvertCollectionViewCell
        cell.setup(advertSlide[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "advert") as? AdvertVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}



/*
collectiondaki resimlerin boyutlarını ayarla
multiply image seçmek için framework araştır.
https://stackoverflow.com/questions/20756899/how-to-select-multiple-images-from-uiimagepickercontroller
kullanıcı para mevzusu
sepete ekleme
 */
