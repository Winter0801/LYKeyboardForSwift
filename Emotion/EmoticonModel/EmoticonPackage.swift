//
//  EmoticonPackage.swift
//  SwiftForDemo
//
//  Created by LyforMac on 17/1/4.
//  Copyright © 2017年 playTeam. All rights reserved.
//

import UIKit

class EmoticonPackage: NSObject {
    
    var emticons : [Emticons] = [Emticons]()
     init(id:String) {
        super.init()
        if id == ""{
            addEmptyEmoji(isRecently: false)

            return
        }
        

       let  plistPath = Bundle.main.path(forResource: "\(id)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")!
    
        let dict = NSDictionary(contentsOfFile: plistPath)!
        let pathArray = dict["emoticons"] as! [[String:String]]
        
        var index = 0
        
        for var emojiDict in pathArray {
            
            if let png = emojiDict["png"] {
                
                emojiDict["png"] = id + "/" + png
            }
            
            emticons.append(Emticons(dict:emojiDict))
            index += 1
            if index == 20 {
                emticons.append(Emticons(isRemove: true))
                index = 0
            }
        }
        addEmptyEmoji(isRecently: false)

         }
    
     private func addEmptyEmoji(isRecently : Bool){
        let count = emticons.count % 21
        if count == 0 && isRecently {
            return
        }
        for _ in count..<20 {
            emticons.append(Emticons(isRecently: true))
        }
        emticons.append(Emticons(isRemove: true))
    }

}
