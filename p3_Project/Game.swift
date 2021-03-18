//
//  Game.swift
//  p3_Project
//
//  Created by Birkyboy on 13/03/2021.
//

import Foundation

/// Class manages all functions for  the game, turns , fight , check team status and  displays winner with stats

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
        print("\n****\n*** ROUND \(numberOfRounds) - PLAYER \(currentPlayer?.playerNumber ?? 0) TURN ***\n****")
        
        /// start the fight
        startFight()
        
    }
        
    private func startFight() {
        
        /// Local variable to store  randomly found weapon
        var foundBonusWeapon: Weapon?
        
        /// after at least 1 round of game
        /// Present  to your fighter randomly a vault with another weapon
        /// uses a random Number to present the vault before choosing the enemy
        if numberOfRounds > 1 {
            let randomNumber = Int.random(in: 0...4)
            if randomNumber == 0 {
                foundBonusWeapon = presentBonusVault()
            }
        }
        
        /// Unwraps currentPlayer optional
        guard let currentPlayer = currentPlayer else { return }
        
        /// Prompt currentPlayer to choose a fighteer from his team
        /// if foundBonusWeapon not nil (bonus found) prompt the player to apply the wepon to a companion and fight
        if foundBonusWeapon == nil {
            print("\nSelect a companion to attack your enemy:\n")
        } else {
            print("\nSelect a companion to give this bonus and to attack your enemy:\n")
        }
       
        
        /// Display player team
        currentPlayer.displayTeam()
        
        /// Await for selection and set companion to local  constant
        let selectedCompanion = currentPlayer.selectFighters(from: currentPlayer.team)
    
        let selectedCompanionInfos = "\(selectedCompanion.icon) \(selectedCompanion.name.uppercased())"

        
        /// if the selected companion  from class Wizzard
        if selectedCompanion is Wizzard {
            
            /// Confirm wizzard selection and prompt player to choose who to heal
            print("\(selectedCompanionInfos) the Wizzard, choose who you'd like to heal:\n")
            
            /// display  current player remaining team
            currentPlayer.displayTeam()
            
            /// Await for player selection and set local variable with a companion to heal
            let companionToBeHealed = currentPlayer.selectFighters(from: currentPlayer.team)
            
            /// call for heal func from the selected companion , in this case the wizzard herited from Companion super class
            /// apply function to selected companion to be healed
            selectedCompanion.heal(companion: companionToBeHealed)
            
        /// if selected companion NOT from Wizzard class (eg. from any other companion class)
        } else {
            
            /// display found bonus weapon to non wizzard companion
            if let foundBonusWeapon = foundBonusWeapon {
                /// Unwraps optional , if not nil weapon is changed for foundbonusweapon
                selectedCompanion.weapon = foundBonusWeapon
                /// infor player  the new weapon is in use for this companion
                print("You're now using \(selectedCompanion.weapon.name), causing \(selectedCompanion.weapon.damage) points damages!\n")
            }
            
            /// Prompt player to choose who to attack
            print("\(selectedCompanionInfos), choose who you'd like to attack:\n")
            
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
        
        /// At the end of the fight cycle, check of any of the team array is empty
        verifyTeamStatus()
        
    }
    
    /// func to check 3 possible end of fight scenarios checks:
    /// - one team has no companion left : game ends with a winner
    /// - both teams have only wizzard left : game ends no winner
    /// - none of the above cases are true , the game continue with another round
    private func verifyTeamStatus() {
        
        /// Check if player's teams array are empty
        if playerOne.team.isEmpty || playerTwo.team.isEmpty {
            /// If one team is empty then game over , display game stats
            displayEndGameStats()
            
            /// check if both players's team have only a wizzard let
        } else if playerOne.onlyWizzardInTeamCheck() == true && playerTwo.onlyWizzardInTeamCheck() == true {
           
            displayEndGameMessageNoWinner()
            
        } else {
            /// go to next round, swap current player and enemy
            managePlayerTurns()
        }
    }
    
    
    // MARK: - Bonus vault
    
    /// present a bonus vault randomly
    private func presentBonusVault() -> Weapon {
        
        /// randomly picks a bonusWeapon array index
        let randomIndex = Int(arc4random_uniform(UInt32(bonusWeapons.count)))
        /// set selected companion's weapon with the random bonusweapon
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
 
    
    // MARK: - End of game
   
    /// At the end of the game
    /// Display  who won the tournament
    /// Display player number and associated team remaining
    private func displayEndGameStats() {
        
        /// check each team count with this tuple and  shows player number that won the game
        let playerNumber = playerOne.team.count > playerTwo.team.count ? playerOne.playerNumber : playerTwo.playerNumber
         
        /// Display end of game board with
        /// - Which player won the game
        /// - How many rounds played
        /// - Remaining companions for the wining team
        /// - Loser team show all companions are dead
        print("\n\n⭐️⭐️⭐️ Player \(playerNumber) WON in \(numberOfRounds) rounds ⭐️⭐️⭐️\n")
        print("Player \(playerOne.playerNumber) Team")
        playerOne.displayTeam()
        print("\nPlayer \(playerTwo.playerNumber) Team")
        playerTwo.displayTeam()
       
    }
    
    private func displayEndGameMessageNoWinner() {
            print("""

            ------------------------------------------------------------------
              No winners, only wizzards remains and they can't kill each other
            ------------------------------------------------------------------

            """)
    }
}
