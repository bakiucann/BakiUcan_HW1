//
//  Seat.swift
//  BusBookingApp
//
//  Created by Baki Uçan on 11.04.2023.
//

import Foundation

enum SeatStatus {
    case empty
    case male
    case female
}

struct Seat {
    let number: Int
    var status: SeatStatus
}

