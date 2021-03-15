//
//  Weapon.swift
//  p3_Project
//
//  Created by Birkyboy on 14/03/2021.
//

import Foundation

/// Weapon class contains all caracteristics for a weapon
class Weapon {
    
    var name: String
    var damage: Int
    
    /// This paramater in only for the companions with healing powers (Wizzard) all other companions its set to 0
    var healingPower: Int
    
    /// Initialize a weapon
    /// - Parameters:
    ///   - name: weapon's given name for each companions
    ///   - damages: number of points to be substracted for enemy's life
    ///   - healingPower: number of point add to team companion's health points
    init(name: String, damages: Int, healingPower: Int) {
        self.name = name
        self.damage = damages
        self.healingPower = healingPower
    }
    
}
