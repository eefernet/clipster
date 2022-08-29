//
//  ClipboardList.swift
//  Clipster
//
//  Created by Ethan Jamieson on 8/28/22.
//

import Foundation
import AppKit

class ClipboardList: ObservableObject{
    @Published var clipboardList: [ClipBoardText] = []
    
    private var pasteboard = NSPasteboard.general
    private var changeCount: Int
    let formatter1 = DateFormatter()
    
    init(){
        self.pasteboard = NSPasteboard.general
        self.changeCount = Int()
        self.formatter1.dateFormat = "h:mm d MMM"
        self.startPollingClipBoard()
    }
    
    func addItem(clip: ClipBoardText){
        self.clipboardList.insert(clip, at: 0)
    }
    
    func getItemList()-> [ClipBoardText]{
        return self.clipboardList
    }
    
    func startPollingClipBoard(){
        let timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.clipChanged), userInfo: nil, repeats: true)
    }
    
    @objc func clipChanged(){
        if let copiedString = pasteboard.string(forType: NSPasteboard.PasteboardType.string), pasteboard.changeCount != self.changeCount{
            changeCount = pasteboard.changeCount
            print("\(copiedString)")
            let newClip = ClipBoardText(id: changeCount, date: formatter1.string(from: Date()), clipBoard: copiedString)
            if(!self.clipboardList.contains(where: {$0.clipBoard == newClip.clipBoard})){
                self.addItem(clip: newClip)
            }
        }
    }
}

