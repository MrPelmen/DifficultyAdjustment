//
//  WorldState.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 30.03.2023.
//

import Foundation

struct WorldState: Encodable {
    let health: CGFloat
    let healthToTime: CGFloat
    let timeElapsed: CGFloat
    let damagedLastWave: CGFloat
    let avgWaveDamage: CGFloat
    let factorDifference: CGFloat
}
