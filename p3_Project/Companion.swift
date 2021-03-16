//
//  Character.swift
//  p3_Project
//
//  Created by Birkyboy on 14/03/2021.
//

import Foundation


/// This class defines the companions properties and abilities

class Companion {

    var name: String
    var icon: String
    var maxLife: Int
    var currentLife: Int
    var weapon: Weapon
    
    
    /// Character's properties
    /// - Parameters:
    ///   - name: companion's name given by the player
    ///   - maximumLife: Life point at start of each game
    ///   - currentLife: tracks current Life of the companions
    ///   - weapon: default weapon carried by the companion
    init(name: String, icon: String, maximumLife: Int, currentLife: Int, weapon: Weapon) {
        self.name = name
        self.icon = icon
        self.maxLife = maximumLife
        self.currentLife = currentLife
        self.weapon = weapon
    }
    
    // MARK: - Characters abilities
    
    
    /// attacks enemies
    /// reduces eneny's currentLifeby weapon damage point
    /// - Parameter enemy: pass in oponent companion
    func fight(enemy: Companion) {
        enemy.currentLife -= self.weapon.damage
        
        /// if enemy's current Life equate 0 or less
        /// set currentLife at 0
        /// inform player companions dead
        if enemy.currentLife <= 0 {
            enemy.currentLife = 0
            print("\(enemy.icon) \(enemy.name) is DEAD !")
        }
    }
    
    /// heal team members
    /// add wizzard weapon (magic wand) healing points
    /// - Parameter teamPlayer: pass in templayer companion
    func heal(companion: Companion) {
        if self.weapon.healingPower > 0 {
            companion.currentLife += self.weapon.healingPower
            
            /// if reaches max Life then current Life equate to max Life
            if companion.currentLife > companion.maxLife {
                companion.currentLife = companion.maxLife
                print("Your Life is back to full!")
            }
        }
    }
    
   
}
