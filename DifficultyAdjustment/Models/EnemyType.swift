//
//  EnemyType.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 23.03.2023.
//

import Foundation

enum EnemyType: CaseIterable {
    case justEnemy
    case chasing
    case tank
    case cannon
    
    // Value in range 0...1 that shows how hard the enemy is to deal with.
    var difficulty: CGFloat {
        switch self {
        case .justEnemy:
            return 0.1
        case .tank:
            return 0.2
        case .cannon:
            return 0.35
        case .chasing:
            return 0.5
        }
    }
    
    static var random: Self {
        allCases.randomElement()!
    }
}
