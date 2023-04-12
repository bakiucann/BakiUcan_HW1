//
//  SeferCollectionViewCell.swift
//  BusBookingApp
//
//  Created by Baki Uçan on 9.04.2023.
//

import UIKit

class SeferCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var fiyat: UILabel!
    @IBOutlet weak var tarih: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var saat: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
        clipsToBounds = true
    }
    
    func setup(main: Sefer) {
        fiyat.text = main.fiyat
        tarih.text = main.tarih
        image.image = main.image
        saat.text = main.saat
    }
}

struct Sefer {
    let fiyat: String
    let tarih: String
    let image: UIImage
    let saat: String
}

