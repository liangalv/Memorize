//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Alvin Liang on 2022-06-15.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable{
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    // now we need to start using these elements in order to generate our view combiner
    var body: some View {
        let width: CGFloat = 100
        LazyVGrid(columns: [GridItem(.adaptive(minimum: width))]){
            ForEach(items) {item in
                content(item).aspectRatio(aspectRatio, contentMode: .fit)
            }
        }
    }
    
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
////}
