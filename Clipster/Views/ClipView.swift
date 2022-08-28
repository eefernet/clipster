//
//  ClipBoardView.swift
//  Clipster
//
//  Created by Ethan Jamieson on 8/28/22.
//

import Foundation
import SwiftUI


struct ClipView: View{
    
    @State var clips = [ClipBoardText]()
    var body: some View{
        List(clipBoardText){
            clip in ListRow(eachClip: clip)
        }
    }
}


struct ListRow: View{
    
    var eachClip: ClipBoardText
    var body: some View{
        HStack{
            Text(eachClip.clipBoard)
            Spacer()
                .padding()
        }
        .background(Color.gray.opacity(0.2))
        .onTapGesture {
            let pasteBoard = NSPasteboard.general
            pasteBoard.clearContents()
            pasteBoard.writeObjects([eachClip.clipBoard as NSString])
        }
    }
}


var clipBoardText = [
    ClipBoardText(id: 1, date: NSDate(), clipBoard: "this is a test string"),
    ClipBoardText(id: 2, date: NSDate(), clipBoard: "this is another a test string")
]

struct ClipView_Previews: PreviewProvider {
    static var previews: some View {
        ClipView(clips: clipBoardText)
    }
}
