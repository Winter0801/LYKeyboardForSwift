//
//  UITextView-Extension.swift
//  SwiftForDemo
//
//  Created by LyforMac on 17/1/6.
//  Copyright © 2017年 playTeam. All rights reserved.
//

import UIKit
extension UITextView{
    
    //获取表情字符串
    func getEmoticonString() ->String{
        
        let attrMstr = NSMutableAttributedString(attributedString: attributedText)
        let range = NSRange(location: 0, length: attrMstr.length)
        attrMstr.enumerateAttributes(in: range, options: []) { (dict, range, _) in
           
            if let attachment = dict["NSAttachment"] as? EmoticonAttachment{
                attrMstr.replaceCharacters(in: range, with: attachment.chs!)
            }
        }
        return attrMstr.string
        
    }
    
    //插入表情
    func insertEmoticon(emoticon:Emticons){
        
        if emoticon.isRecently{
            return
        }
        //点击删除
        if emoticon.isRemove {
            
            deleteBackward()
            return
            
        }
        //点击emoji表情
        if emoticon.emojiCode != nil{
            //获取光标所在的位置
            let textRange = selectedTextRange!
            replace(textRange, withText: emoticon.emojiCode!)
            return
        }
        
        //普通表情
        //根据图片路径创建属性字符串
        //emoticon.chs
        
        let attachment = EmoticonAttachment()
        
        attachment.chs = emoticon.chs
        attachment.image = UIImage(contentsOfFile: emoticon.pngPath!)
        var font = self.font!
        attachment.bounds = CGRect(x: 0, y: -4, width: (font.lineHeight), height: (font.lineHeight))
        let attrImageStr = NSAttributedString(attachment: attachment)
        
        let attMstr = NSMutableAttributedString(attributedString: attributedText)
        //将图片属性字符串转换到可变的的属性字符串的某一个位置
        let range = selectedRange
        attMstr.replaceCharacters(in: range, with: attrImageStr)
        attributedText = attMstr
        //将文字大小重置
        font = self.font!
        
        selectedRange = _NSRange(location: range.location + 1, length: 0)
        
    }
    
    
    
    
}
