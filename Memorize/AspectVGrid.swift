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
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder   content: @escaping (Item) -> ItemView){
        //notice that we have to add @escaping here, as the closure that gets passed into the the INIT function gets passed to variable and held onto meaning that it "escapes" this context
        //this is important as Structs and Enums are value types meaning that they just get passed around, but classes and functions are reference types meaning there is memory allocation in the heap for them
        // and will really determine whether this function is "in-lined" or held onto
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    var body: some View {
        VStack{
            GeometryReader{geometry in
            let width: CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio)
            LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0){
                ForEach(items) {item in
                    content(item).aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
        Spacer(minLength: 0)
        }
        
    }
    private func adaptiveGridItem(width: CGFloat) -> GridItem{
        var griditem = GridItem(.adaptive(minimum: width))
        griditem.spacing = 0
        return griditem
    }
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
            
        }while columnCount < itemCount
        if columnCount > itemCount{
            columnCount = itemCount
        }
        return floor(size.width / CGFloat(columnCount))
    }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
////}
