//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Alvin Liang on 2022-05-06.
//
// High level ideas
//


import SwiftUI
//we're just importing the SwiftUI library
// this is here cause we're actually doing UI in this file


//it's creating a data structure here, structs are essentially collections of variables
// not only can we have varibles inside our structs, we can also have functions in our structs
//swift has support for both OOP and functional programming, we will be using the functional framework in order to build our UI
//we use the OOP model in order to hook up our model(Logic) to our UI
struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    //EmojiMemoryGameView is just the name of our data structure
    // :View this is indicating to swift that this struct that we are building behaves like a "View" because this is functional programming, the behaviour of things is crucial
    //when we declare something as behaving like a view, it's really a double edge sword, the moment that you declare that something behaves like a view you get all the SwiftUI functionality, this also implies that there are respoinsiblities, when you want something to behave like a view and really that just requires for you to have the "body" variable below
    var body: some View {
        ScrollView{
            LazyVGrid(columns:[GridItem(.adaptive(minimum: 65))]){ // the lazy in the name lazy V grid means that the views will only get accessed when aboslutely necessary as to not take computational power
                // you must prespecify the values here if it is the case that the value has no intial value
                ForEach(game.cards){card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture{
                            game.choose(card)
                        }
                        
                }
                
            }.padding(.horizontal).foregroundColor(.red)
        }
        
        
//placing modifiers on view combiners
        // there are really two types of things that you'll see in a Zstack
        // you'll see that the items inherit the color from its container, really just depends if the modifier draws a new shape, this is only the default color, you can still override the color
        
        

        // this must be implemented
        // "body" is the name of the variable
        //some View is a non-specific way to descrive the behaviour of this var
//        Text("Hello, world!")
            
        // Text("Hello, world!") is really just a function, in swift functions are first class citizens
        //this is a function with no name, and in this case returns a text "hello world!"(where the return statement is hiddden)
        //this variable "body" is therefore not stored in memory, but rather is executed each time someone asks this EmojiMemoryGameView struct what the value is
        //A text is another struct that behavevs like a view
        //So you have a function here that returns something that behaves like a view
        // "some View" therefore indicates to the complier that the resulting value from the function will be some view, and to go figure out what that is
        //the really useful views are those that combine these primitive views into more complicated views
        
    }
}


//creating these views is the heart of SwiftUI programming

//Zstacks, stack the views such that they are facing towards the user
    // you as the programmer is also at liberty to remove the content parameter label as long as it sits as the last parameter, and as long as the value that is being passed in is an argument
    // you can also pass in the alignment parameter into the Zstack container
struct CardView: View {
     let card: MemoryGame<String>.Card
    
//    init (_ card: MemoryGame<String>.Card){
//        self.card = card
//    }
    // you could place this init here 
    
    var body: some View{ // this view is a variable, as it's calculated everytime someone asks for it
        ZStack{
            // in order to avoid all the boilerplate that we use to generate all these rectangles, we can use a var
            let shape = RoundedRectangle(cornerRadius: 20) // we didn't need to specifiy this type here
                // 2 reasons 1. assigning "shape" a value will allow swift to engage type inference
                //2. if we declared the type and decided to change the shape later on, we would have to redeclare the variable type
            if card.isFaceUp{
                shape
                    .strokeBorder(lineWidth: 3)
                shape
                    .foregroundColor(.white)
                Text(card.content)// in order to avoid all the boilerplate that we use to generate all these rectangles, we can use a var)
                }else if card.isMatched{
                shape.opacity(0)
            }
            else{
                shape
                    .foregroundColor(.red)
            }
        }
    }
}























        


// this code is the code that glues the EmojiMemoryGameView to the previewer
// we generally do not even touch this code
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)

    }
}
