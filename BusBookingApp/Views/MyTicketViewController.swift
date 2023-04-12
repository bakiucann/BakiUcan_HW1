//
//  MyTicketViewController.swift
//  BusBookingApp
//
//  Created by Baki Uçan on 8.04.2023.
//

import UIKit

class MyTicketViewController: UIViewController {
    
    var ticket:[Paid] = []
    var selectedSeats: [Int] = []
   
  

    @IBOutlet weak var collectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.dataSource = self
        collectionview.delegate = self
        
        if let selectedSeats = UserDefaults.standard.array(forKey: "selectedSeats") as? [Int] {
            Array.array = selectedSeats.map { String($0) }.joined(separator: ", ")
        }
        
        guard let whereFrom = Ticket.whereFrom,
              let whereGo = Ticket.whereGo,
              let date = Ticket.date,
              let name = Passenger.name,
              let clock = Ticket.clock,
              let id = Passenger.Id else {
                  let alert = UIAlertController(title: "Hata", message: "Henüz bilet almadınız :')", preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                  self.present(alert, animated: true, completion: nil)
                  return
            
          

              }
        
        ticket = [Paid(gidis: whereFrom, varis: whereGo, tarih: date, isimsoyisim: name, saat: clock, idno: id)]
    }

    
}

extension MyTicketViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ticket.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "ticket", for: indexPath) as! MyTicketCollectionViewCell
           cell.saat.text = Ticket.clock
           cell.gidis.text = Ticket.whereFrom!
           cell.varis.text = Ticket.whereGo!
           cell.idno.text = Passenger.Id
        cell.koltukno.text = selectedSeats.map { String($0) }.joined(separator: ", ")

           
           if let selectedSeats = UserDefaults.standard.array(forKey: "selectedSeats") as? [Int] {
               let sortedSeats = selectedSeats.sorted()
               let seatNumbers = sortedSeats.map { String($0) }.joined(separator: ", ")
               cell.koltukno.text = seatNumbers
           }
           
           cell.isimsoyisim.text = "\(Passenger.name ?? "") \(Passenger.surname ?? "")"
           cell.tarih.text = Ticket.date
           return cell
    }
        
}
