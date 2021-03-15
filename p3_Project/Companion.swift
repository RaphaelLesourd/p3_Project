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
    var maximumHealth: Int
    var currentHealth: Int
    var weapon: Weapon
    
    
    /// Character's properties
    /// - Parameters:
    ///   - name: companion's name given by the player
    ///   - maximumHealth: health point at start of each game
    ///   - currentHealth: tracks current health of the companions
    ///   - weapon: default weapon carried by the companion
    init(name: String, icon: String, maximumHealth: Int, currentHealth: Int, weapon: Weapon) {
        self.name = name
        self.icon = icon
        self.maximumHealth = maximumHealth
        self.currentHealth = currentHealth
        self.weapon = weapon
    }
    
    // MARK: - Characters abilities
    
    
    /// attacks enemies
    /// reduces eneny's currentHealth by weapon damage point
    /// - Parameter enemy: pass in oponent companion
    func fight(enemy: Companion) {
        enemy.currentHealth -= self.weapon.damage
        
        /// if enemy's current health equate 0 or less
        /// set currentHealth at 0
        /// inform player companions dead
        if enemy.currentHealth <= 0 {
            enemy.currentHealth = 0
            print("\(enemy.icon) \(enemy.name) is DEAD !")
        }
    }
    
    /// heal team members
    /// add wizzard weapon (magic wand) healing points
    /// - Parameter teamPlayer: pass in templayer companion
    func heal(companion: Companion) {
        if self.weapon.healingPower > 0 {
            companion.currentHealth += self.weapon.healingPower
            
            /// if reaches max Heath then current health equate to max health
            if companion.currentHealth > companion.maximumHealth {
                companion.currentHealth = companion.maximumHealth
                print("Your health is back to full!")
            }
        }
    }
    
   
}
