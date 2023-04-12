//
//  PaymentConfirmedViewController.swift
//  BusBookingApp
//
//  Created by Baki Uçan on 12.04.2023.
//

import UIKit
import Lottie
import QRCode


class PaymentConfirmedViewController: UIViewController {
    
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var qrCodeImageView: UIImageView!
    
    var animation: LottieAnimationView?
    var selectedSeats: [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAnimation()
        generateQRCode()
    }
    
    func setupAnimation() {
        animation = LottieAnimationView(name: "payment")
        animation?.frame = animationView.bounds
        animation?.contentMode = .scaleAspectFit
        animation?.loopMode = .loop
        animationView.addSubview(animation!)
        animation?.play()
    }
    
    func generateQRCode() {
        let ticketInfo = """
        Passenger Name: \(Passenger.name ?? "")
        Passenger Surname: \(Passenger.surname ?? "")
        Passenger ID: \(Passenger.Id ?? "")
        Departure: \(Ticket.whereFrom)
        Destination: \(Ticket.whereGo)
        Date: \(Ticket.date)
        Time: \(Ticket.clock)
        Seats: \(selectedSeats.map { String($0) }.joined(separator: ", "))
        """
        let qrCode = QRCode(string: ticketInfo, size: CGSize(width: 130, height: 130))
        qrCodeImageView.image = try? qrCode?.image()
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "allDone", sender: nil)
    }

    }

    
    


