//
//  Emticons.swift
//  SwiftForDemo
//
//  Created by LyforMac on 17/1/4.
//  Copyright © 2017年 playTeam. All rights reserved.
//

import UIKit

class Emticons: NSObject {
/*
    code :emoji 对应的code
    png  : 普通表情对应的图片名称
    chs  : 普通表情对应的文字
*/
    
    var code : String?{
        didSet{
            guard let code = code else {
                return
            }
            //创建一个扫描器
            let scanner = Scanner(string: code)
           //调用方法扫描code的值
            var value : UInt32 = 0
            scanner.scanHexInt32(&value)
            //将value转换成字符串
            let c = Character(UnicodeScalar(value)!)
            
            emojiCode = String(c)
        }
    }
    var png : String?{
        didSet{
            guard let png  = png else {
                return
            }
            //获取表情的全路径
            pngPath = Bundle.main.bundlePath + "/Emoticons.bundle/"  + png
        }
    }
    var chs :String?
    
    //MARK:-数据处理
    var pngPath : String?
    var emojiCode :String?
    var isRemove :Bool = false
    var isRecently : Bool = false
    init(dict : [String : String]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    init(isRemove : Bool) {
        
        self.isRemove = isRemove
    }
    
    init(isRecently : Bool) {
        //super.init()
        self.isRecently = isRecently
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
