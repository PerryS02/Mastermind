//
//  ContentView.swift
//  Mastermind
//
//  Created by Perry Sykes on 2/13/21.
//
//  Optimized for iPhone 8

import SwiftUI

//A very hand-wavey version of the view of my mastermind game
//Basic Structure is an HStack of 2 VStacks:
//  VStack 1 contains the code to be revealed, the guess rows, and the peg select
//  VStack 2 contains the new game button, feedback for each guess, and the delete button
//The guiding principle here is to have a GeometryReader for the view of the entire screen, and nowhere else,
//which allows each view to be thought of in terms of the amount of space it takes up in the entire screen.
struct ContentView: View {
    var body: some View {
        GeometryReader(content: { geometry in
            HStack() {
                VStack() {
                    CodeView().frame(maxHeight: geometry.size.height * 0.1)
                    AllRowsView()
                    SelectPegsView().frame(maxHeight: geometry.size.height * 0.1)
                }
                VStack() {
                    NewGameView().frame(minHeight: geometry.size.height * 0.1)
                    AllFeedbacksView()
                    DeleteView().frame(minHeight: geometry.size.height * 0.1)
                }.frame(maxWidth: geometry.size.width * 0.13)
            }.padding()
            .foregroundColor(Color.init(.sRGB, red: 0.3, green: 0.3, blue: 0.3, opacity: 1.0))
            .background(Color.init(.sRGB, red: 0.6, green: 0.6, blue: 0.6, opacity: 1.0))
        })
    }
}

//The view for the code to be revealed
//The idea here is that if the game is not over, there will be a rectangle covering the code,
//but the code will always be displayed under the rectangle, only to be revealed when the cover rectangle doesn't display
struct CodeView: View {
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
            HStack() {
                Circle().stroke(lineWidth: 2)
                Circle().stroke(lineWidth: 2)
                Circle().stroke(lineWidth: 2)
                Circle().stroke(lineWidth: 2)
            }.padding(5)
            RoundedRectangle(cornerRadius: 10)
            Text("mastermind").font(Font.largeTitle).foregroundColor(Color.white)
        }
    }
}

//Demo view of the revealed code
struct RevealedCodeView: View {
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 10).foregroundColor(Color.white)
            RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
            HStack() {
                RedSelectView()
                YellowSelectView()
                PurpleSelectView()
                OrangeSelectView()
            }.padding(5)
        }
    }
}

//The new game button
struct NewGameView: View {
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 10).fill(Color.white)
            RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
            Text("new").padding(1)
        }
    }
}

//View for every guess row
//Contains 10 RowViews
struct AllRowsView: View {
    var body: some View {
        GeometryReader(content: { geometry in
            VStack() {
                RowView()
                RowView()
                RowView()
                RowView()
                RowView()
                RowView()
                RowView()
                RowView()
                RowView()
                ActiveRowView()
            }
        })
    }
}

//View for one guess row
//The idea here is that as the game is played, the circles within the row will take the color
//of the guessed color. When the row is the current guess, it will be highlighted in green
struct RowView: View {
    var body: some View {
        GeometryReader(content: { geometry in
            HStack() {
                ZStack() {
                    RoundedRectangle(cornerRadius: 10).fill(Color.white)
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                    HStack() {
                        Circle().stroke(lineWidth: 2)
                        Circle().stroke(lineWidth: 2)
                        Circle().stroke(lineWidth: 2)
                        Circle().stroke(lineWidth: 2)
                    }.padding(5)
                }
            }
        })
    }
}

//Demo for active guess row
struct ActiveRowView: View {
    var body: some View {
        GeometryReader(content: { geometry in
            HStack() {
                ZStack() {
                    RoundedRectangle(cornerRadius: 10).fill(Color.init(.sRGB, red: 0.8, green: 0.9, blue: 0.8, opacity: 1.0))
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                    HStack() {
                        Circle().stroke(lineWidth: 2)
                        Circle().stroke(lineWidth: 2)
                        Circle().stroke(lineWidth: 2)
                        Circle().stroke(lineWidth: 2)
                    }.padding(5)
                }
            }
        })
    }
}

//Demo for completed guess row
struct CompletedRowView: View {
    var body: some View {
        GeometryReader(content: { geometry in
            HStack() {
                ZStack() {
                    RoundedRectangle(cornerRadius: 10).fill(Color.white)
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                    HStack() {
                        BlueSelectView()
                        YellowSelectView()
                        YellowSelectView()
                        PurpleSelectView()
                    }.padding(5)
                }
            }
        })
    }
}

//View for every feedback box
//contains 10 feedback boxes
struct AllFeedbacksView: View {
    var body: some View {
        FeedbackView()
        FeedbackView()
        FeedbackView()
        FeedbackView()
        FeedbackView()
        FeedbackView()
        FeedbackView()
        FeedbackView()
        FeedbackView()
        ActiveFeedbackView()
    }
}

//View for feedback box
//The idea here is that when this guess corresponds to the active row, it will be the check button, highlighted green.
//Before the row has been guessed, it just shows 4 gray circles. After the guess is made, the circles will either
//remain gray, turn green for correct color in correct spot, or yellow for correct color in incorrect spot
struct FeedbackView: View {
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack() {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                VStack() {
                    HStack() {
                        Circle()
                        Circle()
                    }
                    HStack() {
                        Circle()
                        Circle()
                    }
                }.padding(3)
            }
        })
    }
}

//Demo for active feedback box
struct ActiveFeedbackView: View {
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack() {
                RoundedRectangle(cornerRadius: 10).fill(Color.init(.sRGB, red: 0.8, green: 0.9, blue: 0.8, opacity: 1.0))
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                Text("enter")
            }
        })
    }
}

//Demo for completed guess box
struct CompletedFeedbackView: View {
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack() {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                VStack() {
                    HStack() {
                        Circle().foregroundColor(Color.green)
                        Circle().foregroundColor(Color.yellow)
                    }
                    HStack() {
                        Circle()
                        Circle()
                    }
                }.padding(3)
            }
        })
    }
}

//View for selecting peg
//The idea here is that when one of the SelectViews is tapped, that color peg will be placed in the active
//guess row in the leftmost, unguessed slot.
struct SelectPegsView: View {
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack() {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                HStack() {
                    RedSelectView()
                    OrangeSelectView()
                    YellowSelectView()
                    GreenSelectView()
                    BlueSelectView()
                    PurpleSelectView()
                }.padding(5)
            }
        })
    }
}

//Views for the 6 possible colors of pegs
struct RedSelectView: View {
    var body: some View {
        ZStack() {
            Circle().foregroundColor(Color.red)
            Circle().strokeBorder(lineWidth: 2, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/).foregroundColor(Color.black).opacity(0.5)
        }
    }
}

struct OrangeSelectView: View {
    var body: some View {
        ZStack() {
            Circle().foregroundColor(Color.orange)
            Circle().strokeBorder(lineWidth: 2, antialiased: true).foregroundColor(Color.black).opacity(0.5)
        }
    }
}

struct YellowSelectView: View {
    var body: some View {
        ZStack() {
            Circle().foregroundColor(Color.yellow)
            Circle().strokeBorder(lineWidth: 2, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/).foregroundColor(Color.black).opacity(0.5)
        }
    }
}

struct GreenSelectView: View {
    var body: some View {
        ZStack() {
            Circle().foregroundColor(Color.green)
            Circle().strokeBorder(lineWidth: 2, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/).foregroundColor(Color.black).opacity(0.5)
        }
    }
}

struct BlueSelectView: View {
    var body: some View {
        ZStack() {
            Circle().foregroundColor(Color.blue)
            Circle().strokeBorder(lineWidth: 2, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/).foregroundColor(Color.black).opacity(0.5)
        }
    }
}

struct PurpleSelectView: View {
    var body: some View {
        ZStack() {
            Circle().foregroundColor(Color.purple)
            Circle().strokeBorder(lineWidth: 2, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/).foregroundColor(Color.black).opacity(0.5)
        }
    }
}

//View for delete button
//When the DeleteView is tapped, the rightmost filled guess slot in the active guess row will be unfilled
struct DeleteView: View {
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 10).fill(Color.white)
            RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
            Text("del")
        }
    }
}


















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
