//
//  Game.swift
//  p3_Project
//
//  Created by Birkyboy on 13/03/2021.
//

import Foundation

class Game {
    
    
    /// Instantiate 2 players with a player Id
    private let playerOne = Player(playerNumber: 1)
    private let playerTwo = Player(playerNumber: 2)
    
    /// Tracks who is the current player
    private var currentPlayer: Player?
    /// Tracks who is the enemy's
    private var enemyPlayer: Player?
    /// Tracks number of rounds
    private var numberOfRounds = Int()
    
    /// Array of bonus weapons
    let bonusWeapons = [Weapon(name: "🔮 Destro Stone", damages: 100, healingPower: 0),
                        Weapon(name: "🪚 Saw", damages: 70, healingPower: 0),
                        Weapon(name: "🟢 Magic Dust Pouch", damages: 50, healingPower: 0),
                        Weapon(name: "🍬 Candy Of Death", damages: 30, healingPower: 0),
                        Weapon(name: "🧻 Toilet Paper Roll", damages: 10, healingPower: 0),
    ]
    
    /// The game starts
    func start() {
        // Reset number of rounds 
        numberOfRounds = 0
        
        displayIntroMessage()
        
        /// each player create a team
        playerOne.createTeam()
        playerTwo.createTeam()
        
        managePlayerTurns()
        
    }
    
    /// At the beginning of each game  display an intro message
    private func displayIntroMessage() {
        print("""
            Welcome to Fighter's game...
            Before you can defeat your sworn enemy,
            you need to surround yourself
            with companions to fight for you.


            """)
    }
    
    /// This function manages turn by turn current player and ennemy
    /// check if current player is nil  or if current player is playre 2
    /// if nil   assign currentplayer and enemy player
    /// add 1 round to  numberOfRounds
    private func managePlayerTurns() {
        
        if currentPlayer == nil || currentPlayer == playerTwo {
            currentPlayer = playerOne
            enemyPlayer = playerTwo
            
            numberOfRounds += 1
        } else {
            currentPlayer = playerTwo
            enemyPlayer = playerOne
        }
        /// Inform player round number and  which player is current number
        print("\n*** Round \(numberOfRounds) - Player \(currentPlayer?.playerNumber ?? 0) turn ***")
        
        /// start the fight
        startFight()
        
    }
    
    
    private func startFight() {
        
        /// Unwraps currentPlayer optional
        guard let currentPlayer = currentPlayer else { return }
        
        /// Prompt currentPlayer to choose a fighteer from his team
        print("\nPlayer \(currentPlayer.playerNumber) Select who will fight for you:\n")
        
        /// Display player team
        currentPlayer.displayTeam()
        
        /// Await for selection and set companion to local  constant
        let selectedCompanion = currentPlayer.selectFighters(from: currentPlayer.team)
        
        /// if the selected companion  from class Wizzard
        if selectedCompanion is Wizzard {
            
            /// Confirm wizzard selection and prompt player to choose who to heal
            print("You selected \(selectedCompanion.icon)\(selectedCompanion.name) the Wizzard\n💫 Choose who you'd like to heal:\n")
            
            /// display  current player remaining team
            currentPlayer.displayTeam()
            
            /// Await for player selection and set local variable with a companion to heal
            let companionToBeHealed = currentPlayer.selectFighters(from: currentPlayer.team)
            
            /// call for heal func from the selected companion , in this case the wizzard herited from Companion super class
            /// apply function to selected companion to be healed
            selectedCompanion.heal(companion: companionToBeHealed)
            
            /// if selected companion NOT from Wizzard class (eg. from any other companion class)
        } else {
            
            /// after at least 1 round of game
            /// Present  to your fighter randomly a vault with another weapon
            /// uses a random bool to present the vault before choosing the enemy
            if numberOfRounds > 1 {
                let randomBool = Bool.random()
                if randomBool == true {
                    presentBonusVault(to: selectedCompanion)
                }
            }
            
            /// Prompt player to choose who to attack
            print("Ready to defeat the enemy? Choose who you'd like to attack:\n")
            
            /// unwrap enemyPlayer optional
            guard let enemyPlayer = enemyPlayer else {return}
            
            /// Display enemy's team
            enemyPlayer.displayTeam()
            
            /// Await player to choose enemy's team member and assign to local constant
            let enemyToFight = enemyPlayer.selectFighters(from: enemyPlayer.team)
            
            /// Confirm player with selected choice
            print("You're attacking \(enemyToFight.icon) \(enemyToFight.name) with your \(selectedCompanion.weapon.name)")
            /// Call for fight func function from the selected companion class herited from Companion super class
            selectedCompanion.fight(enemy: enemyToFight)
            
            /// check enemy  companion currentLife , if at 0 remove from  enemyteam array
            if enemyToFight.currentLife == 0 {
                
                /// uses name to compare to get the array index to be removed
                if let index = enemyPlayer.team.firstIndex(where: { $0.name == enemyToFight.name }) {
                    enemyPlayer.team.remove(at: index)
                }
            }
        }
        
        /// At the end of the fight cycle check of any of the team array is empty
        verifyTeamsEmpty()
        
    }
    
    
    private func verifyTeamsEmpty() {
        /// Check if player's teams array are empty
        if playerOne.team.count == 0 || playerTwo.team.count == 0 {
            /// If one team is empty then game over , display game stats
            displayGameStats()
        } else {
            /// both team no empty
            managePlayerTurns()
        }
    }
    
    
    /// present a bonus vault randomly
    /// - Parameter companion: pass in the companion receiving the bonus
    private func presentBonusVault(to companion: Companion) {
        
        /// randomly picks a bonusWeapon array index
        let randomIndex = Int(arc4random_uniform(UInt32(bonusWeapons.count)))
        /// set selected companion's weapon with the random bonusweapon
        companion.weapon = bonusWeapons[randomIndex]
        /// Informs the player of the bonus found
        print("""

        ✨----------------------------------------------------------✨
            You found a vault containing a \(companion.weapon.name)
        
            It will give \(companion.weapon.damage)
                points of damage to your enemy!
        ✨----------------------------------------------------------✨

        \(companion.icon) \(companion.name.uppercased()) new weapon: \(companion.weapon.name) \(companion.weapon.damage)
        """)
    }
 
    
    /// At the end of the game
    /// Display  who won the tournament
    /// Display player number and associated team remaining
    private func displayGameStats() {
        
        /// check each team count with this tuple and  shows player number that won the game
        let playerNumber = playerOne.team.count > playerTwo.team.count ? playerOne.playerNumber : playerTwo.playerNumber
         
        /// Display end of game board with
        /// - Which player won the game
        /// - How many rounds played
        /// - Remaining companions for the wining team
        /// - Loser team show all companions are dead
        print("""
            --------------------------------------------

            ⭐️⭐️ ⭐️ Player \(playerNumber) WON ⭐️⭐️⭐️

            """)
        print("Player \(playerOne.playerNumber) Team")
        playerOne.displayTeam()
        print("\nPlayer \(playerTwo.playerNumber) Team")
        playerTwo.displayTeam()
    }
    
}


/// Use this extension if project needs to comply with swift version below 4.2

//
//extension Bool {
//    static func random() -> Bool {
//           return arc4random_uniform(2) == 0
//       }
//}
