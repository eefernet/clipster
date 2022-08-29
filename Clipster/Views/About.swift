//
//  About.swift
//  Clipster
//
//  Created by Ethan Jamieson on 8/28/22.
//

import Foundation
import SwiftUI
struct AboutView: View{
    let version = "1.0"
    var description = "Clipster is a simple and easy to use app that keeps track of all of that copying and pasting. It keeps a clipboard history for you so you dont loose that one coppied item. Simply click on the item and it will be put back into your clipboard"
    
    var body: some View{
        VStack{
            Spacer()
            Text("Clipster, a clipboard manager 📎").font(.largeTitle)
            Text("Version : \(version)").fontWeight(.light).foregroundColor(.green)
            Text(description).multilineTextAlignment(.center)
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
            HStack{
                Link("Github Link 🖥️", destination: URL(string: "https://github.com/TacoCatDev/clipster.git")!)
                    .padding()
                
                Link("Email Me 📧", destination: URL(string: "mailto:ethan@eefernet.com")!)
            }
            
            
            
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
