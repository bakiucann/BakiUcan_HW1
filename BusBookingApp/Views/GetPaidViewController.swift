//
//  GetPaidViewController.swift
//  BusBookingApp
//
//  Created by Baki Uçan on 9.04.2023.
//

import UIKit

class GetPaidViewController: UIViewController {
    
    @IBOutlet weak var getPaid: UIView!
    @IBOutlet weak var locationWhereGo: UILabel!
    @IBOutlet weak var locationwherefrom: UILabel!
    @IBOutlet weak var clock: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var selectedSeatsLabel: UILabel!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var nameSurname: UITextField!
    @IBOutlet weak var ccNumber: UITextField!
    @IBOutlet weak var CVV: UITextField!
    @IBOutlet weak var lastDate: UITextField!
    var selectedSeats: [Int] = []
    var selectedSeferPrice: String?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
                 
        locationwherefrom.text = Ticket.whereFrom
        locationWhereGo.text = Ticket.whereGo
        date.text = Ticket.date
        clock.text = Ticket.clock
        let sortedSeats = selectedSeats.sorted()
                let seatNumbers = sortedSeats.map { String($0) }.joined(separator: ", ")
                selectedSeatsLabel.text = "Seçilen Koltuklar: \(seatNumbers)"
            }
  
    @IBAction func getPaidOnayla(_ sender: Any) {
        Passenger.name = name.text
        Passenger.surname = surname.text
        Passenger.Id = id.text
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "paymentConfirmed",
               let paymentConfirmedVC = segue.destination as? PaymentConfirmedViewController {
                paymentConfirmedVC.selectedSeats = selectedSeats
            }
        if let selectedSeats = UserDefaults.standard.array(forKey: "selectedSeats") as? [Int] {
           self.selectedSeats = selectedSeats
           let sortedSeats = selectedSeats.sorted()
           let seatNumbers = sortedSeats.map { String($0) }.joined(separator: ", ")
           selectedSeatsLabel.text = "Seçilen Koltuklar: \(seatNumbers)"
        }

        }

    
}
      
