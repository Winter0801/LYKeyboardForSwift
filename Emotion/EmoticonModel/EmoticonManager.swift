//
//  EmoticonManager.swift
//  SwiftForDemo
//
//  Created by LyforMac on 17/1/4.
//  Copyright © 2017年 playTeam. All rights reserved.
//

import UIKit

class EmoticonManager: NSObject {

    var pakeages : [EmoticonPackage] = [EmoticonPackage]()
    
    override init() {
        //最近
        pakeages.append(EmoticonPackage(id:""))
        //系统
        pakeages.append(EmoticonPackage(id:"com.sina.default"))
        //emoji
        pakeages.append(EmoticonPackage(id:"com.apple.emoji"))
        //浪小花
        pakeages.append(EmoticonPackage(id:"com.sina.lxh"))
    }
}
