//
//  MainMenuViewController.swift
//  BusBookingApp
//
//  Created by Baki Uçan on 10.04.2023.
//

import UIKit
import Foundation

class MainMenuViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
 
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var clockPicker: UIDatePicker!
    
    @IBOutlet weak var whereFrom: UITextField!
    @IBOutlet weak var whereGo: UITextField!
    
    
    @IBOutlet weak var dateText: UITextField!
    @IBOutlet weak var clockText: UITextField!
   
   
 
  
    @IBOutlet weak var collectionView: UICollectionView!
    
    let pickerView = UIPickerView()

    var cityPicker: UIPickerView!
    var citySearchBar: UISearchBar!
    let cities: [String] = {
        guard let url = Bundle.main.url(forResource: "TurkiyeSehirler", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let jsonArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: String]]
        else { return [] }

        return jsonArray.compactMap { $0["city"] }
    }()

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.addTarget(self, action: #selector(MainMenuViewController.dateChanged(datePicker :)), for: .valueChanged)
        clockPicker.addTarget(self, action: #selector(MainMenuViewController.clockChanged(datePicker :)), for: .valueChanged)
       
        dateSegmentedControl.selectedSegmentIndex = 0
        dateText.text = formatDate(Date())
       



    }
    
    // whereFrom text field'ı için
    @IBAction func whereFromTextFieldTapped(_ sender: Any) {
        showCityPicker { [weak self] selectedCity in
            self?.whereFrom.text = selectedCity
        }
    }

    // whereGo text field'ı için
    @IBAction func whereGoTextFieldTapped(_ sender: Any) {
        showCityPicker { [weak self] selectedCity in
            self?.whereGo.text = selectedCity
        }
    }

    // Şehir picker'ını göstermek için yardımcı fonksiyon
    func showCityPicker(completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        
    
        
        let container = UIView(frame: CGRect(x: 30, y: 0, width: alertController.view.bounds.width * 0.8, height: 250))
        container.addSubview(pickerView)
        
        alertController.view.addSubview(container)
        
        let confirmAction = UIAlertAction(title: "Tamam", style: .default) { _ in
            let selectedRow = pickerView.selectedRow(inComponent: 0)
            completion(self.cities[selectedRow])
        }
        alertController.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "Vazgeç", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }



    

    
    @IBAction func TicketViewButton(_ sender: Any) {
        guard let whereFromText = whereFrom.text, !whereFromText.isEmpty else {
                showAlert(message: "Lütfen nereden kalkacağınızı seçin.")
                return
            }
            guard let whereGoText = whereGo.text, !whereGoText.isEmpty else {
                showAlert(message: "Lütfen nereye gideceğinizi seçin.")
                return
            }
            guard let dateText = dateText.text, !dateText.isEmpty else {
                showAlert(message: "Lütfen bir tarih seçin.")
                return
            }
            guard let clockText = clockText.text, !clockText.isEmpty else {
                showAlert(message: "Lütfen bir saat seçin.")
                return
            }
            
            Ticket.whereFrom = whereFromText
        Ticket.whereGo = whereGoText
        Ticket.date = dateText
        Ticket.clock = clockText
        
        performSegue(withIdentifier: "togoVC", sender:nil)
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    


@objc func dateChanged(datePicker:UIDatePicker){
    
    datePicker.datePickerMode = .date
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MM yyyy"

    dateText.text = dateFormatter.string(from: datePicker.date)
    
    view.endEditing(true)
}

@objc func clockChanged(datePicker:UIDatePicker){
    
    clockPicker.datePickerMode = .time
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    dateFormatter.timeStyle = .short
    
    dateFormatter.locale = Locale(identifier: "tr")
    
    clockText.text = dateFormatter.string(from: clockPicker.date)
    
    view.endEditing(true)
}

@IBOutlet weak var dateSegmentedControl: UISegmentedControl!

@IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
    let date = Date().addingTimeInterval(86400 * Double(sender.selectedSegmentIndex))
    dateText.text = formatDate(date)
}

func formatDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MM yyyy"
    return dateFormatter.string(from: date)
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 50, height: 50)
   }
}

