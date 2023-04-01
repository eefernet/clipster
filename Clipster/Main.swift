//
//  ContentView.swift
//  Clipster
//
//  Created by Ethan Jamieson on 8/27/22.
//

import SwiftUI
import CoreData

struct ClipBoardView: View {

    @State public var tableViewSelection = 0
    
    var body: some View{
        
        ZStack {
            Color("background")
            
            TabView(selection: $tableViewSelection) {
                ClipView().tabItem {
                    Text("Clipboard")
                        
                }.tag(1)
                
                AboutView(verify: false).tabItem {
                    Text("About")
                }.tag(2)
            }
        }
        
    }
}

func toggleVisibility() {
    NSApp.isActive ? NSApp.hide(nil) : NSApp.unhide(nil)
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        ClipBoardView()
    }
}
