//
//  About.swift
//  Clipster
//
//  Created by Ethan Jamieson on 8/28/22.
//

import Foundation
import SwiftUI
struct AboutView: View{
    
    //Mark: Global Vars
    @State var verify: Bool
    @ObservedObject var clips = ClipboardList()
    //Get version number
    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    
    var description = "Clipster is a simple and easy to use app that keeps track of all of that copying and pasting. It keeps a clipboard history for you so you dont loose that one coppied item. Simply click on the item and it will be put back into your clipboard"
    
    //Mark: Begining of swiftUI view controller
    var body: some View{
        VStack{
            Text("Clipster, a clipboard manager 📎").font(.largeTitle)
            
            Text("Version : \(version)").fontWeight(.light).foregroundColor(.green)
            Spacer()
            Text(description)
                .multilineTextAlignment(.center)
                .padding(.all)
                .layoutPriority(1)
                
            Spacer()
            HStack{
                VStack{
                    Text("Preview Length")
                    Text("Current : \(Int(clips.maxPreviewLength)) characters")
                    Slider(
                        value: clips.$maxPreviewLength,
                            in: 80...450
                        ) {

                        } minimumValueLabel: {
                            Text("80")
                        } maximumValueLabel: {
                            Text("450")
                        } onEditingChanged: { editing in
                            self.verify = editing
                        }.frame(width: 150, height: 10, alignment: .center)
                    
                    Spacer()
                    
                    HStack{
                        Link("Github Link 🖥️", destination: URL(string: "https://github.com/TacoCatDev/clipster.git")!)
                            //.padding()
                        
                        Link("Email Me 📧", destination: URL(string: "mailto:ethan@eefernet.com")!)
                            //.padding()
                        Button(action: {NSApplication.shared.terminate(nil)
                            
                        }, label: {
                            Text("Quit App ❌")
                                .foregroundColor(.red)
                        }).buttonStyle(.plain)
                    }
                    Spacer()
                }
            }
         /* TODO: Add a delete all button and start from scratch
            Button {
                self.clips.clipboardList.removeAll()
            } label: {
                Text("Delete history 🗑️")
            }*/
        }
    }
}
//Needed for the preview within Xcode
struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(verify: false)
    }
}
