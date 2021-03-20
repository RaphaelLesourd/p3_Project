//
//  Game.swift
//  p3_Project
//
//  Created by Birkyboy on 13/03/2021.
//

import Foundation

/// Class manages all functions for  the game, turns , fight , check team status and  displays winner with stats
class Game: Bonus {
    
    /// Instantiate 2 players with a player Id
    private let playerOne = Player(playerNumber: 1)
    private let playerTwo = Player(playerNumber: 2)
    
    /// Tracks who is the current player
    private var currentPlayer: Player?
    /// Tracks who is the enemy's
    private var enemyPlayer: Player?
    /// Tracks number of rounds
    private var numberOfRounds = Int()
    
  
    /// The game starts
    func start() {
        // Reset number of rounds 
        numberOfRounds = 0
        
        displayIntroMessage()
        
        /// Each player choose a name and create a team
        playerOne.setName()
        playerOne.createTeam()
        
        playerTwo.setName()
        playerTwo.createTeam()
        
        /// Assign turn
        assignPlayerTurns()
        
    }
    
    /// At the beginning of each game  display an intro message
    private func displayIntroMessage() {
        print("""
            ----------------------------------------
            Welcome to Fighter's game...
            Before you can defeat your sworn enemy,
            you need to surround yourself
            with characters to fight for you.
            ----------------------------------------

            """)
    }
    
    
    /// This function manages turn by turn current player and ennemy
    /// check if current player is nil  or if current player is playerTwo
    /// add 1 round 
    private func assignPlayerTurns() {
        numberOfRounds += 1
        if currentPlayer == nil || currentPlayer == playerTwo {
            currentPlayer = playerOne
            enemyPlayer = playerTwo
        } else {
            currentPlayer = playerTwo
            enemyPlayer = playerOne
        }
        /// Inform player round number and  which player is current number
        print("\n****\n*******  ROUND \(numberOfRounds) - \(currentPlayer?.name ?? "")'S TURN'\n****")
        
        /// start the fight
        startFight()
        
    }
        
    private func startFight() {
        
        /// Local constant to store  randomly found weapon
        let randomBonusWeapon = presentBonusVault(for: numberOfRounds)
     
        /// Prompt currentPlayer to choose a character from his team
        /// if foundBonusWeapon not nil  prompt the player to apply the wepon to a character and fight
        if randomBonusWeapon == nil {
            print("\nSelect an attacker:")
            print("(Wizzads can only heal!)\n")
        } else {
            print("\nSelect a character to give this bonus and to attack your enemy:\n")
        }
       
        
        /// Unwraps currentPlayer optional
        guard let currentPlayer = currentPlayer else { return }
        /// Display player team
        currentPlayer.displayTeam()
        
        /// Await for selection and set character to local  constant
        let selectedCharacter = currentPlayer.selectCharacter(from: currentPlayer.team)
    
        let selectedCharacterInfos = "\(selectedCharacter.icon) \(selectedCharacter.name)"

        
        /// check if character can heal
        if selectedCharacter.canHeal {
            
            /// Confirm wizzard selection and prompt player to choose who to heal
            print("\(selectedCharacterInfos), choose who you'd like to heal:\n")
            
            /// display  current player remaining team
            currentPlayer.displayTeam()
            
            /// Await for player selection and set local variable with a character to heal
            let characterToBeHealed = currentPlayer.selectCharacter(from: currentPlayer.team)
            
            /// call for heal func from the selected character , in this case the wizzard herited from character super class
            /// apply function to selected character to be healed
            selectedCharacter.heal(characterToBeHealed)
            
        } else {
            
            /// display found bonus weapon to non wizzard character
            if let randomBonusWeapon = randomBonusWeapon {
                /// Unwraps optional , if not nil weapon is changed for foundbonusweapon
                selectedCharacter.weapon = randomBonusWeapon
                /// infor player  the new weapon is in use for this character
                print("\(selectedCharacter.weapon.name.uppercased()) is yours\n")
            }
            
            /// Prompt player to choose who to attack
            print("\(selectedCharacterInfos)  ❤️ \(selectedCharacter.life) uses \(selectedCharacter.weapon.name.uppercased()) (\(selectedCharacter.weapon.damagePower))\n*** Who you'd like to attack ? \n")
            
            /// unwrap enemyPlayer optional
            guard let enemyPlayer = enemyPlayer else {return}
            
            /// Display enemy's team
            enemyPlayer.displayTeam()
            
            /// Await player to choose enemy's team member and assign to local constant
            let enemy = enemyPlayer.selectCharacter(from: enemyPlayer.team)
            
            /// Confirm player with selected choice
            print("\(enemy.icon) \(enemy.name) was hurt by your \(selectedCharacter.weapon.name)")
            /// Call for fight func function from the selected character class herited from character super class
            selectedCharacter.fight(enemy)

        }
        /// At the end of the fight cycle, check of any of the team array is empty
        verifyTeamStatus()
    }
    
    /// Round possible ending:
    /// playerOne team all dead  - playerTwo wins
    /// playerTwo team all dead - playerOne vins
    /// both team only have wizzard that cant kill one another - No winner
    /// none of the other cases are valid - play another round
    private func verifyTeamStatus() {
        
        if playerOne.allCharactersDead() {
           displayWinner(as: playerTwo)
            
        } else if playerTwo.allCharactersDead() {
           displayWinner(as: playerOne)
            
        } else if playerOne.onlyWizzardInTeamCheck() == true && playerTwo.onlyWizzardInTeamCheck() == true {
            displayEndGameMessageNoWinner()
            
        } else {
            assignPlayerTurns()
        }
    }
    
    
  
    // MARK: - End of game
   
    /// At the end of the game
    /// Display  who won the tournament
    /// Display player number and associated team remaining
    private func displayWinner(as player: Player) {
        
        /// Display end of game board with
        /// - Which player won the game
        /// - How many rounds played
        /// - Remaining characters for the wining team
        /// - Loser team show all characters are dead
        print("\n\n⭐️⭐️⭐️ \(player.name) WON IN \(numberOfRounds) ROUNDS ⭐️⭐️⭐️\n")
        print("\(playerOne.name) Team")
        playerOne.displayTeam(gameOver: true)
        print("\(playerTwo.name) Team")
        playerTwo.displayTeam(gameOver: true)
       
    }
    
    private func displayEndGameMessageNoWinner() {
            print("""

            ------------------------------------------------------------------
              No winners, only wizzards remains and they can't kill each other
            ------------------------------------------------------------------

            """)
     
    }
}
