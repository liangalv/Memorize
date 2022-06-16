//  EmojiMemoryGameView.swift
//  Memorize
//  Created by Alvin Liang on 2022-05-06.


import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3){card in
            CardView(card: card)
                .padding(4)
                .onTapGesture{
                    game.choose(card)
                }
        }.foregroundColor(.red).padding(.horizontal)
        
                
                
           
    }
}



struct CardView: View {
    let card: MemoryGame<String>.Card
    
    
    
    var body: some View{
        GeometryReader{ geometry in
            ZStack{
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp{
                    shape.fill()
                        .foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 30)).padding(DrawingConstants.circlePadding).opacity(DrawingConstants.circleOpacity)

                    Text(card.content).font(font(in: geometry.size))
                }else if card.isMatched{
                    shape.opacity(0)
                }
                else{
                    shape
                        .fill()
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
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.75
        static let circlePadding: CGFloat = 5
        static let circleOpacity: CGFloat = 0.5
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
