//
//  AppDelegate.swift
//  spacebar
//
//  Created by Bram on 26/12/2022.
//

import Cocoa
import CoreGraphics

class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var statusItem: NSStatusItem!
    
    private let conn = _CGSDefaultConnection()
    
    private let spaceHelper = SpaceHelper()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.setupNotifications()
        self.setupStatusItem()
        self.spaceChanged()
    }
    
    func setupNotifications() {
        NSWorkspace.shared.notificationCenter.addObserver(
            self,
            selector: #selector(self.spaceChanged),
            name: NSWorkspace.activeSpaceDidChangeNotification,
            object: nil)
        
        if (NSScreen.screensHaveSeparateSpaces) {
            //Called often, only needed when using different spaces per monitor
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(self.spaceChanged),
                name: NSApplication.didUpdateNotification,
                object: nil
            )
        }
    }
    
    func setupStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Quit Spacebar", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        statusItem.menu = menu
    }
    
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    
    @objc func spaceChanged() {
        updateIcon(space: self.spaceHelper.activeSpaceNumber())
    }
    
    func updateIcon(space: Int) {
        // If no space number assume we're in fullscreen mode.
        let sfSymbol = space > 0 ? String("\(space).square.fill") : "f.square.fill"
        let description = space > 0 ? String("\(space)") : "Fullscreen"
        DispatchQueue.main.async {
            self.statusItem.button?.image = NSImage(systemSymbolName: sfSymbol, accessibilityDescription: description)
        }
    }
    
}

