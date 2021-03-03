//
//  MastermindModel.swift
//  Mastermind
//
//  Created by Perry Sykes on 2/17/21.
//

import Foundation
//  Mastermind game Model
//  Game of type 'Peg', where Peg is identifiable
struct Mastermind<Peg> where Peg: Identifiable{
    
    //  Declare vars
    //  guessesTaken: Int to represent the number of guesses taken so far in the game
    //  codeToBreak: Peg Array to represent the final code
    //  pegs: Peg Array that represents all possible Pegs, the first index must correspond to an empty peg
    //  idOfCurrentSlotToFill: Int id of the current slot that has to be filled
    //  indexOfCurrentGuess: Int index of current guess in array 'guesses'
    //  guesses: Array of Guess structs that represents all guesses
    //  slotsToFill: Array of Slot structs that represents all slots in the game
    @Published var guessesTaken: Int
    var codeToBreak: Array<Peg>
    var pegs: Array<Peg>
    var idOfCurrentSlotToFill: Int
    var indexOfCurrentGuess: Int
    private(set) var guesses: Array<Guess>
    private(set) var slotsToFill: Array<Slot>
    
    //  init Mastermind
    //  pegColors: an Array of all possible pegs that could go in Slots
    //  answer: an Array of type Peg that holds the final code to be figured out
    //  Initialize Model vars
    //  Make a tempSlot to fill an array of Slot structs
    //      Fill the slotsToFill Array with 40 slots, all initialized to the empty peg
    //  Fill 'guesses' with 10 Guess structs, each having 4 distinct slots from 'slotsToFill'
    init(pegColors: Array<Peg>, answer: Array<Peg>) {
        pegs = pegColors
        codeToBreak = answer
        guessesTaken = 0
        idOfCurrentSlotToFill = 0
        indexOfCurrentGuess = 0
        guesses = Array<Guess>()
        slotsToFill = []
        var tempSlot: Slot
        for index in 0..<40 {
            tempSlot = Slot(id: index, peg: pegColors[0])
            slotsToFill.append(tempSlot)
        }
        for guessNum in 0..<10 {
            guesses.append(Guess(id: guessNum, slots: [slotsToFill[guessNum*4], slotsToFill[guessNum*4+1], slotsToFill[guessNum*4+2], slotsToFill[guessNum*4+3]]))
        }
    }
    
    //  check
    //  Help gotten from Ethan York
    //  initialize a bunch of vars to keep track of things
    //  check for correct pegs in correct slots first
    //      if the peg in the codeToBreak at 'index' is equal to the peg in the current guess slots at 'index'
    //          increment 'correctPegAndSpot'
    //  check for correct pegs, not necessarily in the right spot
    //  for each peg in codeToBreak
    //      for each peg already seen
    //          if the current peg in codeToBreak has already been seen
    //              set pegAlreadySeenFlag to true
    //      if the current peg has not been seen before
    //          for each peg in the current guess's slots
    //              if the current peg in codeToBreak is equal to the current peg in the current guess's slots
    //                  increment 'correctPeg'
    //      add the peg from the codeToBreak we just checked to pegsAlreadySeen
    //      set pegAlreadySeenFlag to false
    //  set correctPeg to the difference between correctPeg and correctPegAndSpot, since correctPegAndSpot pegs were counted twice
    //  increment 'indexOfCurrentGuess'
    mutating func check() {
        var correctPegAndSpot: Int = 0
        var correctPeg: Int = 0
        var pegsAlreadySeen: Array<Peg> = []
        var pegAlreadySeenFlag: Bool = false
        
        for index in 0..<4 {
            if codeToBreak[index].id as!Int == guesses[indexOfCurrentGuess].slots[index].id {
                correctPegAndSpot = correctPegAndSpot + 1
            }
        }
        
        for codeToBreakIndex in codeToBreak.indices {
            for alreadySeenIndex in pegsAlreadySeen.indices {
                if pegsAlreadySeen[alreadySeenIndex].id as! Int == codeToBreak[codeToBreakIndex].id as! Int {
                    pegAlreadySeenFlag = true
                }
            }
            //if we havent seen this color in the code before, we can go ahead and check
            if !pegAlreadySeenFlag {
                for currentRowIndex in guesses[indexOfCurrentGuess].slots.indices {
                    if codeToBreak[codeToBreakIndex].id as! Int == guesses[indexOfCurrentGuess].slots[currentRowIndex].id {
                        correctPeg = correctPeg + 1
                    }
                }
            }
            pegsAlreadySeen.append(codeToBreak[codeToBreakIndex])
            pegAlreadySeenFlag = false
        }
        
        correctPeg = correctPeg - correctPegAndSpot
        indexOfCurrentGuess = indexOfCurrentGuess + 1
    }
    
    //  fillSlot
    //  pegID: Int that represents the id of the peg from 'pegs'
    //  if let currentRow represent the index of the current row in Array 'guesses'
    //      if let currentSlot represent the index of the slot being filled in the current Guess struct's slots array
    //          place the Peg from 'pegs' with the pegID sent in into the correct slot in the current Guess
    //          increment the idOfCurrentSlotToFill by one
    mutating func fillSlot(pegID: Int) {
        if let currentRow: Int = guesses.firstIndex(matching: guesses[indexOfCurrentGuess]) {
            if let currentSlot: Int = guesses[currentRow].slots.firstIndex(matching: slotsToFill[idOfCurrentSlotToFill]) {
                guesses[currentRow].slots[currentSlot].peg = pegs[pegID]
                idOfCurrentSlotToFill = idOfCurrentSlotToFill + 1
                print("in row \(currentRow), in slot \(currentSlot), filling with color \(pegID).")
            }
        }
    }
    
    //  delete
    //  if let currentRow represent the index of the current row in Array 'guesses'
    //      if the idOfCurrentSlotToFill is not the first slot in the current row, then continue. Otherwise, can't delete anything
    //          decrement idOfCurrentSlotToFill
    //          if let currentSlot represent the index of the slot being deleted in the current Guess struct's slots array
    //              fill the current Slot with the empty Peg
    mutating func delete() {
        if let currentRow: Int = guesses.firstIndex(matching: guesses[indexOfCurrentGuess]) {
            if idOfCurrentSlotToFill != guesses[currentRow].slots[0].id {
                idOfCurrentSlotToFill = idOfCurrentSlotToFill - 1
                if let currentSlot: Int = guesses[currentRow].slots.firstIndex(matching: slotsToFill[idOfCurrentSlotToFill]) {
                    guesses[currentRow].slots[currentSlot].peg = pegs[0]
                    print("in row \(currentRow), in slot \(currentSlot), deleting.")
                }
            }
        }
    }
    
    struct Guess: Identifiable {
        var id: Int
        var slots: Array<Slot>
    }
    
    struct Slot: Identifiable {
        var id: Int
        var peg: Peg
    }
    
    struct FeedbackPegs: Identifiable {
        var id: Int
        var correctColor: Bool
        var correctSpot: Bool
    }
}
 
