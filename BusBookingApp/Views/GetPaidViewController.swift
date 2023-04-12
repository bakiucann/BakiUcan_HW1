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
        // Ad, soyad ve ID alanlarının boş olup olmadığını kontrol edin.
        guard let name = name.text, !name.isEmpty else {
            showAlert(message: "Lütfen adınızı girin.")
            return
        }
        guard let surname = surname.text, !surname.isEmpty else {
            showAlert(message: "Lütfen soyadınızı girin.")
            return
        }
        guard let id = id.text, !id.isEmpty else {
            showAlert(message: "Lütfen kimlik numaranızı girin.")
            return
        }
        
        // Kredi kartı bilgileri alanlarının boş olup olmadığını kontrol edin.
        guard let ccName = nameSurname.text, !ccName.isEmpty else {
            showAlert(message: "Lütfen kredi kartı üzerindeki ismi girin.")
            return
        }
        guard let ccNumber = ccNumber.text, !ccNumber.isEmpty else {
            showAlert(message: "Lütfen kredi kartı numarasını girin.")
            return
        }
        guard let cvv = CVV.text, !cvv.isEmpty else {
            showAlert(message: "Lütfen CVV kodunu girin.")
            return
        }
        guard let lastDate = lastDate.text, !lastDate.isEmpty else {
            showAlert(message: "Lütfen son kullanma tarihini girin.")
            return
        }

        // Tüm alanlar doluysa yolcu bilgilerini kaydedin.
        Passenger.name = name
        Passenger.surname = surname
        Passenger.Id = id
        
        // Ödeme onay sayfasına git.
        performSegue(withIdentifier: "paymentConfirmed", sender: nil)
    }

    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
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
      
