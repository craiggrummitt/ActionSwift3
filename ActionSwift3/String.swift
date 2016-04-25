//
//  String.swift
//  ActionSwift
//
//  Created by Craig Grummitt on 22/09/2015.
//  Copyright © 2015 Interactive Coconut. All rights reserved.
//

import Foundation
/**
Add subscripts to String
*/
extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]   //advance(self.startIndex, i)
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        get {
            
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = self.startIndex.advancedBy(r.endIndex - r.startIndex)
            
            return self[startIndex..<endIndex]
        }
    }
    func lastCharacter()->String {
        return self[self.length()-1]
    }
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    func length()->Int {
        return self.characters.count
    }
    func getFirstWord()->String {
        return self.componentsSeparatedByString(" ")[0]
    }
    //resolve path extension
    var pathExtension: String? {
        return NSString(string: self).pathExtension
    }
    var stringByDeletingPathExtension: String {
        return NSString(string: self).stringByDeletingPathExtension
    }
}
