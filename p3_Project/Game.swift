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
        
        managePlayerTurns()
        
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
        print("\n****\n*******  ROUND \(numberOfRounds) - PLAYER \(currentPlayer?.name ?? "") TURN\n****")
        
        /// start the fight
        startFight()
        
    }
        
    private func startFight() {
        
        /// Local variable to store  randomly found weapon
        let bonus = Bonus()
        let randomBonusWeapon = bonus.presentBonusVault(for: numberOfRounds)
      
        
        /// Unwraps currentPlayer optional
        guard let currentPlayer = currentPlayer else { return }
        
        /// Prompt currentPlayer to choose a fighteer from his team
        /// if foundBonusWeapon not nil (bonus found) prompt the player to apply the wepon to a character and fight
        if randomBonusWeapon == nil {
            print("\nSelect a character to attack your enemy")
            print("Wizzads can only heal!\n")
        } else {
            print("\nSelect a character to give this bonus and to attack your enemy:\n")
        }
       
        
        /// Display player team
        currentPlayer.displayTeam()
        
        /// Await for selection and set character to local  constant
        let selectedCharacter = currentPlayer.selectAttacker(from: currentPlayer.team)
    
        let selectedCharacterInfos = "\(selectedCharacter.icon) \(selectedCharacter.name)"

        
        /// if the selected character  from class Wizzard
        if selectedCharacter is Wizzard {
            
            /// Confirm wizzard selection and prompt player to choose who to heal
            print("\(selectedCharacterInfos) the Wizzard, choose who you'd like to heal:\n")
            
            /// display  current player remaining team
            currentPlayer.displayTeam()
            
            /// Await for player selection and set local variable with a character to heal
            let characterToBeHealed = currentPlayer.selectAttacker(from: currentPlayer.team)
            
            /// call for heal func from the selected character , in this case the wizzard herited from character super class
            /// apply function to selected character to be healed
            selectedCharacter.heal(character: characterToBeHealed)
            
        /// if selected character NOT from Wizzard class (eg. from any other character class)
        } else {
            
            /// display found bonus weapon to non wizzard character
            if let foundBonusWeapon = randomBonusWeapon {
                /// Unwraps optional , if not nil weapon is changed for foundbonusweapon
                selectedCharacter.weapon = foundBonusWeapon
                /// infor player  the new weapon is in use for this character
                print("\(selectedCharacter.weapon.name.uppercased()) is yours\n")
            }
            
            /// Prompt player to choose who to attack
            print("\(selectedCharacterInfos) you have \(selectedCharacter.life) life points left, you're carrying \(selectedCharacter.weapon.name.uppercased()), causing \(selectedCharacter.weapon.damage) points damages!\nWho you'd like to attack ?\n")
            
            /// unwrap enemyPlayer optional
            guard let enemyPlayer = enemyPlayer else {return}
            
            /// Display enemy's team
            enemyPlayer.displayTeam()
            
            /// Await player to choose enemy's team member and assign to local constant
            let enemyToFight = enemyPlayer.selectAttacker(from: enemyPlayer.team)
            
            /// Confirm player with selected choice
            print("\(enemyToFight.icon) \(enemyToFight.name) was hurt by your \(selectedCharacter.weapon.name)")
            /// Call for fight func function from the selected character class herited from character super class
            selectedCharacter.fight(character: enemyToFight)
            
            /// check enemy  character currentLife , if at 0 remove from  enemyteam array
            if enemyToFight.life == 0 {
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
    /// - one team has no character left : game ends with a winner
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
    
    
  
    // MARK: - End of game
   
    /// At the end of the game
    /// Display  who won the tournament
    /// Display player number and associated team remaining
    private func displayEndGameStats() {
        
        /// check each team count with this tuple and  shows player number that won the game
        let playerNumber = playerOne.team.count > playerTwo.team.count ? playerOne.name : playerTwo.name
         
        /// Display end of game board with
        /// - Which player won the game
        /// - How many rounds played
        /// - Remaining characters for the wining team
        /// - Loser team show all characters are dead
        print("\n\n⭐️⭐️⭐️ Player \(playerNumber) WON in \(numberOfRounds) rounds ⭐️⭐️⭐️\n")
        print("Player \(playerOne.name) Team")
        playerOne.displayTeam()
        print("\nPlayer \(playerTwo.name) Team")
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
