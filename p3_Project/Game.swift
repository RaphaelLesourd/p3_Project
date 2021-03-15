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
    
    /// The game starts
    func start() {
        displayIntroMessage()
        /// each player create a team
        playerOne.createTeam()
        playerTwo.createTeam()
     
        teamStatusBoard()
    }
    
   
    
    private func displayIntroMessage() {
        print("""
            Welcome to Fighter's game...
            Before you can defeat your sworn enemy,
            you need to surround yourself
            with companions to fight for you.


            """)
    }
    
    
    
   private func teamStatusBoard() {
        
        print("\nTeams current status\n")
        print("PLAYER 1")
        playerOne.displayCompanionList()
        
        print("\nPLAYER 2")
        playerTwo.displayCompanionList()
    }
    
    
    
}
