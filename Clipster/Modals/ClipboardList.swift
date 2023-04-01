//
//  ClipboardList.swift
//  Clipster
//
//  Created by Ethan Jamieson on 8/28/22.
//

import Foundation
import AppKit
import SwiftUI

class ClipboardList: ObservableObject{
    @Published var clipboardList: [ClipBoardText] = []
    
    @AppStorage("previewLength") var maxPreviewLength: Double = 300
    
    private var pasteboard = NSPasteboard.general
    private var changeCount: Int
    let formatter1 = DateFormatter()
    
    init(){
        self.changeCount = pasteboard.changeCount
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
        _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.clipChanged), userInfo: nil, repeats: true)
    }
    
    /**
     When the clipboard changes after a pulling, check to see if
     its the same as one already saved, if not create a new one
     and add it to the top
     */
    @objc func clipChanged(){
        if let copiedString = pasteboard.string(forType: NSPasteboard.PasteboardType.string), pasteboard.changeCount != self.changeCount{
            changeCount = pasteboard.changeCount
            let newClip = createNewClipBoardText(from: copiedString)
            if(!self.clipboardList.contains(where: {$0.clipBoard == newClip.clipBoard})){
                self.addItem(clip: newClip)
            }
        }
    }
    
    /*
     Creates a new 'ClipBoardText' object and returns it.
        - Parameter copiedString: String varible that you want to pass in
     
        - Returns: A 'ClipBoardText' object
     */
    private func createNewClipBoardText(from copiedString: String) -> ClipBoardText {
           let shortClip = copiedString.maxLength(length: Int(maxPreviewLength))
           let newClip = ClipBoardText(
               id: changeCount,
               date: formatter1.string(from: Date()),
               clipBoard: copiedString,
               clipBoardShort: shortClip
           )
           return newClip
       }
}

extension String {
   func maxLength(length: Int) -> String {
       var str = self
       let nsString = str as NSString
       if nsString.length >= length {
           str = nsString.substring(with:
               NSRange(
                location: 0,
                length: nsString.length > length ? length : nsString.length)
           )
       }
       return  str
   }
}

