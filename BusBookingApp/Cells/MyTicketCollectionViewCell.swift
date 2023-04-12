//
//  MyTicketCollectionViewCell.swift
//  BusBookingApp
//
//  Created by Baki Uçan on 9.04.2023.
//

import UIKit

class MyTicketCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gidis: UILabel!
    @IBOutlet weak var varis: UILabel!
    @IBOutlet weak var tarih: UILabel!
    @IBOutlet weak var isimsoyisim: UILabel!
    @IBOutlet weak var saat: UILabel!
    @IBOutlet weak var koltukno: UILabel!
    @IBOutlet weak var idno: UILabel!
    
  
    
}

struct Paid{
   var gidis: String?
   var varis: String?
    var tarih: String?
    var  isimsoyisim: String?
    var saat: String?
     var idno: String?
}

