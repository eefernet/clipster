//
//  ClipBoardListener.swift
//  Clipster
//
//  Created by Ethan Jamieson on 8/28/22.
//

import Foundation
import SwiftUI

class ClipBoardListener{
    private let pasteboard:NSPasteboard
    private var changeCount: Int
    
    init(){
        self.pasteboard = NSPasteboard.general
        self.changeCount = Int()
        self.startPollingClipBoard()
    }
    
    func startPollingClipBoard(){
        let timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: Selector("clipChanged"), userInfo: nil, repeats: true)
    }
    
    @objc private func clipChanged(notif: Notification){
        print("shits different man")
        if let copiedString = pasteboard.string(forType: NSPasteboard.PasteboardType.string), pasteboard.changeCount != self.changeCount{
            changeCount = pasteboard.changeCount
            print("\(copiedString)")
            
        }
    }
}
