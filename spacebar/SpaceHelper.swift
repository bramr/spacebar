//
//  SpaceHelper.swift
//
//  Determine currently active space number.
//

import Foundation

class SpaceHelper {
    private let conn = _CGSDefaultConnection()
    
    
    func activeSpaceNumber() -> Int {
        let displays = CGSCopyManagedDisplaySpaces(conn) as! [NSDictionary]
        let activeDisplay = CGSCopyActiveMenuBarDisplayIdentifier(conn) as! String
        
        let allSpaces: NSMutableArray = []
        var activeSpaceID = 0
        
        for d in displays {
            guard
                let current = d["Current Space"] as? [String: Any],
                let spaces = d["Spaces"] as? [[String: Any]],
                let displayID = d["Display Identifier"] as? String
            else {
                continue
            }
            
            switch displayID {
            case "Main", activeDisplay:
                activeSpaceID = current["ManagedSpaceID"] as! Int
            default:
                break
            }
            
            for s in spaces {
                let isFullscreen = s["TileLayoutManager"] as? [String: Any] != nil
                if isFullscreen {
                    continue
                }
                allSpaces.add(s)
            }
        }
        
        if activeSpaceID == 0 {
            return 0
        }
        
        for (index, space) in allSpaces.enumerated() {
            let spaceID = (space as! NSDictionary)["ManagedSpaceID"] as! Int
            if spaceID == activeSpaceID {
                return index + 1
            }
        }
        
        return 0
    }
    
}
