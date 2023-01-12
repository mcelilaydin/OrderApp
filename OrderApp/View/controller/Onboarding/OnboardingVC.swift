//
//  OnboardingVC.swift
//  OrderApp
//
//  Created by Celil Aydın on 2.01.2023.
//

import UIKit

class OnboardingVC: BaseVC {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.layer.opacity = 1
                nextBtn.setTitle("Get Started", for: .normal)
            }else {
                nextBtn.layer.opacity = 0.5
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        nextBtn.layer.opacity = 0.5
        slides = [
            OnboardingSlide(title: "Recording", description: "The user will be registered.", image:UIImage(named: "record")!), //kayıt işlemi
            OnboardingSlide(title: "Advert", description: "User can post product advertisement.", image:UIImage(named: "advert")!), //ilan
            OnboardingSlide(title: "Filtering", description: "User will be able to filter their own postings.", image:UIImage(named: "filter")!) //Filtreleme
        ]

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if currentPage == slides.count - 1 {
            UserDefaults.standard.set(true, forKey: "openApp")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginNC") as! UINavigationController
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .flipHorizontal
            self.present(vc, animated: true)
        }else {
            DuplicateFuncs.alertMessage(title: "", message: "Please swipe to the right.", vc: self)
        }
    }
}

extension OnboardingVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
    
    
}
