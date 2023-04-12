//
//  SeatView.swift
//  BusBookingApp
//
//  Created by Baki Uçan on 11.04.2023.
//

import UIKit

class SeatView: UIButton {
    var seat: Seat {
        didSet {
            updateUI()
        }
    }
    
    private let seatNumberLabel = UILabel()

    init(seat: Seat) {
        self.seat = seat
        super.init(frame: .zero)
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateUI() {
        layer.cornerRadius = 4
        setTitleColor(.white, for: .normal)
        switch seat.status {
        case .empty:
            backgroundColor = .gray
        case .male:
            backgroundColor = .blue
        case .female:
            backgroundColor = .red
        }
        
        // Seat number label
           seatNumberLabel.text = "\(seat.number)"
           seatNumberLabel.font = UIFont.systemFont(ofSize: 10)
           seatNumberLabel.textColor = .white
           seatNumberLabel.textAlignment = .center
           seatNumberLabel.sizeToFit()
        seatNumberLabel.center = CGPoint(x: bounds.width/2 + 12, y: bounds.height/2 + 12)

           addSubview(seatNumberLabel)
       }
}



