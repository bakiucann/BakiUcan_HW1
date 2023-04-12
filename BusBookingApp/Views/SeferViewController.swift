//
//  SeferViewController.swift
//  BusBookingApp
//
//  Created by Baki Uçan on 8.04.2023.
//

import UIKit

class SeferViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var trip: [Sefer] = [
        Sefer(fiyat: "400 TL", tarih: Ticket.date!, image: UIImage(named: "aliosmanulusoy")!, saat: Ticket.clock!),
        Sefer(fiyat: "350 TL", tarih: Ticket.date!, image: UIImage(named: "metro")!, saat: Ticket.clock!),
        Sefer(fiyat: "450 TL", tarih: Ticket.date!, image: UIImage(named: "pamukkale")!, saat: Ticket.clock!),
        Sefer(fiyat: "380 TL", tarih: Ticket.date!, image: UIImage(named: "kamilkoc")!, saat: Ticket.clock!),
        Sefer(fiyat: "400 TL", tarih: Ticket.date!, image: UIImage(named: "varan")!, saat: Ticket.clock!),
        Sefer(fiyat: "390 TL", tarih: Ticket.date!, image: UIImage(named: "nilufer")!, saat: Ticket.clock!)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SeferViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trip.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sefercell", for: indexPath) as! SeferCollectionViewCell
        cell.setup(main: trip[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "seferPicked", sender: trip[indexPath.row])
        
    }
    
    
    
}
