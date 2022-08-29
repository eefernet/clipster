//
//  ContentView.swift
//  Clipster
//
//  Created by Ethan Jamieson on 8/27/22.
//

import SwiftUI
import CoreData

struct Main: View {

    @State public var tableViewSelection = 0
    
    var body: some View{
        VStack{
            
            TabView(selection: $tableViewSelection) {
                ClipView().tabItem { Text("Clipboard") }.tag(1)
                AboutView().tabItem { Text("About") }.tag(2)
            }
            .padding()
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
