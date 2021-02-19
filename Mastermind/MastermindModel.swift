//
//  MastermindModel.swift
//  Mastermind
//
//  Created by Perry Sykes on 2/17/21.
//

import Foundation

struct Mastermind {
    
    var guessesTaken: Int
    private(set) var guesses: Array<Guess>
    
    init() {
        guessesTaken = 0
        guesses = Array<Guess>()
        var currentSlot1: Slot
        var currentSlot2: Slot
        var currentSlot3: Slot
        var currentSlot4: Slot
        for guessNum in 0..<10 {
            currentSlot1 = Slot(id: guessNum*4, isFilled: false, fillColor: [])
            currentSlot2 = Slot(id: guessNum*4+1, isFilled: false, fillColor: [])
            currentSlot3 = Slot(id: guessNum*4+2, isFilled: false, fillColor: [])
            currentSlot4 = Slot(id: guessNum*4+3, isFilled: false, fillColor: [])
            guesses.append(Guess(id: guessNum, slot1: currentSlot1, slot2: currentSlot2, slot3: currentSlot3, slot4: currentSlot4))
        }
    }
    
    struct CodeToBreak {
         
    }
    
    struct Guess: Identifiable {
        var id: Int
        var slot1: Slot
        var slot2: Slot
        var slot3: Slot
        var slot4: Slot
    }
    
    struct Slot: Identifiable {
        var id: Int
        var isFilled: Bool
        var fillColor: Array<Double>
    }
    
    struct Peg: Identifiable {
        var id: Int
        var Color: Int
    }
    
    struct FeedbackPegs: Identifiable {
        var id: Int
        var correctColor: Bool
        var correctSpot: Bool
    }
}
