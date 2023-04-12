//
//  SeatSelectionViewController.swift
//  BusBookingApp
//
//  Created by Baki Uçan on 11.04.2023.
//

import UIKit

class SeatSelectionViewController: UIViewController {
    @IBOutlet weak var selectedSeatsLabel: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    private var seats: [Seat] = []
   var selectedSeats: [Int] = [] {
        didSet {
            updateSelectedSeatsLabel()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UIScrollView otomatik olarak kaydırılacak şekilde ayarlanıyor
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        
        
        // Örnek verilerle koltukları oluşturun ve düzenleyin.
        createSeats()
        layoutSeats()
        
    }
    
    private func createSeats() {
        for i in 1...45 {
            let seat = Seat(number: i, status: .empty)
            seats.append(seat)
        }
        
    }
    
    private func layoutSeats() {
        let rowCount = 10
        let columnCount = 10
        let seatSize: CGFloat = 25
        let seatSpacing: CGFloat = 5
        
        let xOffset = (scrollView.frame.width - seatSize * CGFloat(columnCount) - seatSpacing * CGFloat(columnCount - 1)) / 2
        let yOffset = (scrollView.frame.height - seatSize * CGFloat(rowCount) - seatSpacing * CGFloat(rowCount - 1)) / 2
        
        for (index, seat) in seats.enumerated() {
            let seatView = SeatView(seat: seat)
            seatView.addTarget(self, action: #selector(seatTapped), for: .touchUpInside)
            let row = index / columnCount
            let column = index % columnCount
            let x = xOffset + CGFloat(column) * (seatSize + seatSpacing)
            let y = yOffset + CGFloat(row) * (seatSize + seatSpacing)
            seatView.frame = CGRect(x: x, y: y, width: seatSize, height: seatSize)
            scrollView.addSubview(seatView)
        }
    }
    
    
    
    @objc private func seatTapped(_ sender: SeatView) {
        if selectedSeats.count >= 5 {
            let alertController = UIAlertController(title: "Seçim Sınırı Aşıldı", message: "En fazla 5 koltuk seçebilirsiniz.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil

            )
            return // koltuk seçimi yapılmadan fonksiyondan çıkılıyor
        }
        
        let alertController = UIAlertController(title: "Koltuk Seçimi", message: "Lütfen cinsiyet seçin:", preferredStyle: .actionSheet)
        let maleAction = UIAlertAction(title: "Erkek", style: .default) { _ in
            sender.seat.status = .male
            self.selectedSeats.append(sender.seat.number)
        }
        let femaleAction = UIAlertAction(title: "Kadın", style: .default) { _ in
            sender.seat.status = .female
            self.selectedSeats.append(sender.seat.number)
        }
        let cancelAction = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
        alertController.addAction(maleAction)
        alertController.addAction(femaleAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    private func updateSelectedSeatsLabel() {
        let sortedSeats = selectedSeats.sorted()
        let seatNumbers = sortedSeats.map { String($0) }.joined(separator: ", ")
        selectedSeatsLabel.text = "Seçilen Koltuklar: \(seatNumbers)"
        
        if selectedSeats.count > 5 {
            let alertController = UIAlertController(title: "Uyarı", message: "5 koltuktan fazla seçemezsiniz.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
        let defaults = UserDefaults.standard
        defaults.set(selectedSeats, forKey: "selectedSeats")
        defaults.synchronize()

    }
    
    
    
    @IBAction private func purchaseButtonTapped(_ sender: UIButton) {
        // Ad, soyad ve ID alanlarının boş olup olmadığını kontrol edin.
            guard let name = nameTextField.text, !name.isEmpty else {
                showAlert(message: "Lütfen adınızı girin.")
                return
            }
            guard let surname = surnameTextField.text, !surname.isEmpty else {
                showAlert(message: "Lütfen soyadınızı girin.")
                return
            }
            guard let id = idTextField.text, !id.isEmpty else {
                showAlert(message: "Lütfen kimlik numaranızı girin.")
                return
            }
            
            // Seçilen koltuk yoksa uyarı verin.
            guard selectedSeats.count > 0 else {
                showAlert(message: "Lütfen bir veya daha fazla koltuk seçin.")
                return
            }
            
            // Ödeme sayfasına yönlendirin.
        let senderVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "getPaidVC") as! GetPaidViewController
        let defaults = UserDefaults.standard
        defaults.set(selectedSeats, forKey: "selectedSeats")
        defaults.synchronize()
         present(senderVC, animated: true, completion: nil)
    }

    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

