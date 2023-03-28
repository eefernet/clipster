//
//  ClipsterApp.swift
//  Clipster
//
//  Created by Ethan Jamieson on 8/27/22.
//

import SwiftUI
import AppKit

@main
struct ClipsterApp: App {
    
    let persistenceController = PersistenceController.shared
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    //Set up the embedded view controller, listen for events
    var body: some Scene {
        WindowGroup {
            ClipBoardView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(ClipboardList())
        }
    }  
}

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var popover = NSPopover.init()
    var statusBarItem: NSStatusItem!
    static var shared : AppDelegate!
    
    //Mark : Run shit here when the app finishes launching
    func applicationDidFinishLaunching(_ notification: Notification) {
        //Grab the first window in the application stack
        let window = NSApplication.shared.windows.first
        //Close the default macOS app window if it presents
        window?.close()
        
        //Initialize the contentView that contains the clipboard
        //By using the global var
        let contentView = ClipBoardView()
        NSApp.setActivationPolicy(.accessory)
        //set the style/size of the icon in the menu bar
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
            
            // Set the status bar item's properties here
            // Set the SwiftUI's ContentView to the Popover's ContentViewController
            popover.behavior = .transient
            popover.animates = false
            popover.contentViewController = NSViewController()
            popover.contentViewController?.view = NSHostingView(rootView: contentView)
            popover.contentViewController?.view.window?.makeKey()
            popover.contentSize = NSSize(width: 450, height: 300)
            statusBarItem.button?.title = "📎"
            statusBarItem.button?.action = #selector(AppDelegate.togglePopover(_:))
    }
    //When the app icon is clicked, show the popover from the bounds we set earlier
    //with the statusBarItem
    @objc func showPopover(_ sender: AnyObject?) {
        if let button = statusBarItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        }
    }
    //Close the pop over if the user requests to close the application
    @objc func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
    }
    //Technically not needed to send an argument to close popover, however nice to have
    //for future stuff and it works so why fix it?
    @objc func togglePopover(_ sender: AnyObject?) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
}

