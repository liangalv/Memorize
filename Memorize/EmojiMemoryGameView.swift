//  EmojiMemoryGameView.swift
//  Memorize
//  Created by Alvin Liang on 2022-05-06.


import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3){card in
            CardView(card: card)
            
                .aspectRatio(2/3, contentMode: .fit)
                .onTapGesture{
                    game.choose(card)
                }
        }
        
                
                
           
    }
}



struct CardView: View {
    let card: MemoryGame<String>.Card
    
    
    
    var body: some View{
        GeometryReader{ geometry in
            ZStack{
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp{
                    shape
                        .strokeBorder(lineWidth: DrawingConstants.cornerRadius)
                    shape
                        .foregroundColor(.white)
                    Text(card.content).font(font(in: geometry.size))
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
    private func font(in size: CGSize) -> Font{
        Font.system(size:min(size.width,size.height)*DrawingConstants.fontScale)
    }
    // This is how we do constants in SWIFT
    private struct DrawingConstants{
        // we're never going to create any of these structs
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
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
