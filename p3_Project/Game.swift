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
        /// each player create a team
        playerOne.createTeam()
        playerTwo.createTeam()
     
        teamStatusBoard()
    }
    
    
    func teamStatusBoard() {
        
        print("\nTeams current status\n")
        print("PLAYER 1")
        playerOne.displayTeamMembers()
        
        print("\nPLAYER 2")
        playerTwo.displayTeamMembers()
    }
    
}
