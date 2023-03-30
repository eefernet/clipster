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
                .foregroundColor(Color(red: 0.34, green: 0.139, blue: 0.34, opacity: 1))
                .padding()
        }
        .background(Color.black.opacity(0.25))
        .cornerRadius(10)
        .onTapGesture {
            let pasteBoard = NSPasteboard.general
            pasteBoard.clearContents()
            pasteBoard.writeObjects([eachClip.clipBoard as NSString])
        }
    }
}
