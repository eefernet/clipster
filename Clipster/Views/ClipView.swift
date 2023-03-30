//
//  ClipBoardView.swift
//  Clipster
//
//  Created by Ethan Jamieson on 8/28/22.
//

import Foundation
import SwiftUI


struct ClipView: View{
    //@State var verify: Bool
    
    //@State var lengthOfPreview
    
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
            Text(eachClip.clipBoardShort)
                //.padding()
                //Spacer()
            Text(eachClip.date)
                .foregroundColor(.green)
                .padding()
        }
        .background(Color.black.opacity(0.2))
        .onTapGesture {
            let pasteBoard = NSPasteboard.general
            pasteBoard.clearContents()
            pasteBoard.writeObjects([eachClip.clipBoard as NSString])
        }
    }
}
