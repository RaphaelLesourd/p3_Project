//
//  Game.swift
//  p3_Project
//
//  Created by Birkyboy on 13/03/2021.
//

import Foundation

class Game {

 
    /// Instantiate 2 player with a player Id
    let playerOne = Player(playerNumber: 1)
    let playerTwo = Player(playerNumber: 2)
    
    /// Tracks who is the current player
    var currentPlayer: Player?
    /// Tracks who is the enemy's
    var enemyPlayer: Player?
    /// Tracks number of rounds
    var numberOfRounds = 0
 
    
    /// The game starts
    func start() {
        displayIntroMessage()
        /// each player create a team
        playerOne.createTeam()
        playerTwo.createTeam()
       
        manageTurns()
       
    }
    
    /// This function manages turn by turn current player and ennemy
    /// check if current player is nil  or if current player is playre 2
    /// if nil   assign currentplayer and enemy player
    /// add 1 round to  numberOfRounds
   private func manageTurns() {
        
        if currentPlayer == nil || currentPlayer == playerTwo {
            currentPlayer = playerOne
            enemyPlayer = playerTwo
            
            numberOfRounds += 1
        } else {
            currentPlayer = playerTwo
            enemyPlayer = playerOne
            
        }
           
        /// Inform player round number and  which player is current number
        print("\nRound \(numberOfRounds) - Player \(currentPlayer?.playerNumber ?? 0) turn")
        
        /// start the fight
        startFight()

    }
    
    
    
    private func displayIntroMessage() {
        print("""
            Welcome to Fighter's game...
            Before you can defeat your sworn enemy,
            you need to surround yourself
            with companions to fight for you.


            """)
    }
   
 
    
    func startFight() {
        
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
       
        /// Check if player's teams is empty
        if playerOne.team.count == 0 || playerTwo.team.count == 0 {
            /// If one team is empty then game over , display game stats
            displayGameStats()
        } else {
            /// both team no empty
            manageTurns()
        }
    
        
    }
    
  
     
    /// At the end of the game
    /// Display  who won the tournament
    /// Display player number and associated team remaining
    private func displayGameStats() {
        let playerNumber = playerOne.team.count > playerTwo.team.count ? playerOne.playerNumber : playerTwo.playerNumber
        print("""
            --------------------------------------------

            ⭐️⭐️ ⭐️ Player \(playerNumber) WON ⭐️⭐️⭐️

            """)
        
        
        print("Player \(playerOne.playerNumber) Team")
        playerOne.displayTeam()
        print("Player \(playerTwo.playerNumber) Team")
        playerTwo.displayTeam()
    }
 
    
}
