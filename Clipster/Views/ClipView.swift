//
//  ClipBoardView.swift
//  Clipster
//
//  Created by Ethan Jamieson on 8/28/22.
//

import Foundation
import SwiftUI


struct ClipView: View{
    
    @ObservedObject var clips = ClipboardList()
    var body: some View{
        List(clips.clipboardList){
            clip in ListRow(eachClip: clip)
        }
    }
}


struct ListRow: View{
    
    var eachClip: ClipBoardText
    var body: some View{
        HStack{
            Text(eachClip.clipBoard)
                .padding()
            Text(eachClip.date)
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
