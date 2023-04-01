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
        ZStack{
            Color("background")
            List(clips.clipboardList){
                clip in ListRow(eachClip: clip)
            }.scrollContentBackground(.hidden)
        }
    }
}

struct ListRow: View{
    var eachClip: ClipBoardText
    
    var body: some View{
        ZStack{
            HStack{
                Text(eachClip.clipBoardShort)
                    .padding()
                Text(eachClip.date)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(Color("time"))
                    .padding()
            }
            .background(Color("textBackground"))
            .cornerRadius(10)
            .onTapGesture {
                let pasteBoard = NSPasteboard.general
                pasteBoard.clearContents()
                pasteBoard.writeObjects([eachClip.clipBoard as NSString])
            }
        }
    }
}

struct ClipPreviews: PreviewProvider {
    static var previews: some View {
        ClipView()
    }
}
