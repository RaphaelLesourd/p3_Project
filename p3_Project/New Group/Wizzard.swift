//
//  Wizzard.swift
//  p3_Project
//
//  Created by Birkyboy on 15/03/2021.
//

import Foundation

/// Characters requirements
/// health : High
/// damages: Low
/// healing: yes

class Wizzard: Companion {
    
    /// Character own max life point
    static let maxLife = 100
    /// Character's weapon
    static let wand = Weapon(name: "Magic Wand", damages: 0, healingPower: 30)
    static let icon = "🧙"
    
    /// - Parameter name: name given by the player
    init(name: String) {
        super.init(name: name,
                   icon: Wizzard.icon,
                   maximumLife: Wizzard.maxLife,
                   currentLife: Wizzard.maxLife,
                   weapon: Wizzard.wand)
    }
}
