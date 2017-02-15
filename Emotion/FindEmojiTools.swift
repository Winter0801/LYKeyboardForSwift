//
//  FindEmojiTools.swift
//  SwiftForDemo
//
//  Created by LyforMac on 17/1/9.
//  Copyright © 2017年 playTeam. All rights reserved.
//

import UIKit

class FindEmojiTools: NSObject {

    static let  shareInstance : FindEmojiTools = FindEmojiTools()
    
    fileprivate var manager : EmoticonManager = EmoticonManager()
    
    func findAttrString (statusText : String?, font : UIFont) -> NSMutableAttributedString?{
        
        guard let statusText = statusText else{
            return nil
        }
        
        let pattern = "\\[.*?\\]"
        guard  let regex = try? NSRegularExpression(pattern: pattern, options: [])else{
            return nil
        }
        let results = regex.matches(in: statusText, options: [], range:NSRange(location: 0, length: statusText.characters.count))
        
        
        let attrMstr = NSMutableAttributedString(string: statusText)
        
        for result in results.reversed(){
            
            let chs = (statusText as NSString ).substring(with: result.range)
            
            guard let pngPath = findPngPath(chs: chs) else {
                return nil
            }
            
            //创建属性字符串
            let attachment = NSTextAttachment()
            attachment.image = UIImage(contentsOfFile: pngPath)
            attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
            let attachmentStr = NSAttributedString(attachment: attachment)
            attrMstr.replaceCharacters(in: result.range, with: attachmentStr)
            
        }
        
        return attrMstr
    }
    
    fileprivate func findPngPath (chs:String) ->String?{
        
        for pakeage in manager.pakeages{
            for emoticon in pakeage.emticons{
                if emoticon.chs == chs{
                    return emoticon.pngPath
                }
            }
        }
        return nil
    }
}
