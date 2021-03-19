//
//  Bonus.swift
//  p3_Project
//
//  Created by Birkyboy on 19/03/2021.
//

import Foundation


class Bonus {
    
    /// Array of bonus weapons
    private let bonusWeapons = [Weapon(name: "🔮 Destro Stone", damages: 90, healingPower: 0),
                        Weapon(name: "🪚 Saw", damages: 70, healingPower: 0),
                        Weapon(name: "🟢 Magic Dust Pouch", damages: 50, healingPower: 0),
                        Weapon(name: "🍬 Candy Of Death", damages: 30, healingPower: 0),
                        Weapon(name: "🧻 Toilet Paper Roll", damages: 10, healingPower: 0),
    ]
    
    
    
    // MARK: - Bonus vault
    
    /// present a bonus vault randomly
    /// - Parameter round: pass in the round number to check at least one round of game was played
    /// - Returns: optional as there might be a weapon or not depending on ramdomInt
    func presentBonusVault(for roundNumber: Int) -> Weapon? {
        
        /// uses a random Number to present the vault before choosing the enemy
        if roundNumber > 1 {
            let randomInt = Int.random(in: 0...4)
            if randomInt == 0 {
                
                /// randomly picks a bonusWeapon array index
                let randomIndex = Int(arc4random_uniform(UInt32(bonusWeapons.count)))
                /// set selected character's weapon with the random bonusweapon
                let foundWeapon = bonusWeapons[randomIndex]
                print("""

                ✨----------------------------------------------------------✨
                ✨ You found a vault containing a \(foundWeapon.name)
                ✨
                ✨ It will give \(foundWeapon.damage) points of damage to your enemy!
                ✨----------------------------------------------------------✨

                
                """)
                return foundWeapon
            }
        }
        return nil
    }
    
    
    
    
    
}
