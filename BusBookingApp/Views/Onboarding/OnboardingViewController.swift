//
//  OnboardingViewController.swift
//  BusBookingApp
//
//  Created by Baki Uçan on 6.04.2023.
//

import UIKit
import Lottie


struct Slide {
    let title: String
    let animationName: String
    let buttonColor: UIColor
    let buttonTitle: String
    
    static let collection: [Slide] = [
        .init(title: "Yolculuk zamanı geldi! Hazır mısın? Otobüslerimizle her an her yere seyahat edebilirsin.", animationName: "bus", buttonColor: .systemIndigo, buttonTitle: "İleri"),

        .init(title: "Hiçbir şey sana yolculuk kadar özgürlük hissi veremez! Biz de bu özgürlük hissini biletlerimizle sana sunuyoruz.", animationName: "ticket2", buttonColor: .systemIndigo, buttonTitle: "Şimdi Satın Al!")
    ]
}

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    private let slides: [Slide] = Slide.collection

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        setupCollectionView()
        
      
        
    }
    
    private func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true

}
    
    private func handleActionButtonTap(at indexPath: IndexPath) {
        if indexPath.item == slides.count - 1 {
           showTabBar() // we are on the last slide
        } else {
            let nextItem = indexPath.item + 1
            let nextIndexPath = IndexPath(item: nextItem, section: 0)
            collectionView.scrollToItem(at: nextIndexPath, at: .top, animated: true)
        }
    }
    
    private func showTabBar() {
        
        let tabBarViewController = UIStoryboard(name: "Main", bundle:
                                                    nil).instantiateViewController(identifier: "TabBarViewController")
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
            let window = sceneDelegate.window {
            window.rootViewController = tabBarViewController
            UIView.transition(with: window,
                              duration: 0.25,
                              animations: nil)
        }
    }

}


extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! OnboardingCollectionViewCell
        let slide = slides[indexPath.item]
        cell.configure(with: slide)
        cell.actionButtonDidTap = { [weak self] in
            self?.handleActionButtonTap(at: indexPath)
            print(indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        
        return CGSize(width: itemWidth, height: itemHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    

}

class OnboardingCollectionViewCell: UICollectionViewCell {
    
 
    @IBOutlet var animationView: LottieAnimationView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    var actionButtonDidTap: (() -> Void)?
    
    
    func configure(with slide: Slide) {
           // 1. Create the LottieAnimationView
        animationView = LottieAnimationView(name: slide.animationName)
           animationView?.frame = contentView.bounds
           animationView?.contentMode = .scaleAspectFit
           animationView?.loopMode = .loop
           animationView?.animationSpeed = 1.0 // Set animation speed here
           
           // Add animationView to the cell's content view
           contentView.addSubview(animationView!)
           
           // 2. Play animation
           animationView?.play()
           
           // Configure the rest of the cell's UI
           titleLabel.text = slide.title
           actionButton.backgroundColor = slide.buttonColor
           actionButton.setTitle(slide.buttonTitle, for: .normal)
        
       
      
    

        
    }
    
    @IBAction func actionButtonTapped() {
        actionButtonDidTap?()
    }
    
    
}


