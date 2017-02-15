//
//  EmoticonCell.swift
//  SwiftForDemo
//
//  Created by LyforMac on 17/1/4.
//  Copyright © 2017年 playTeam. All rights reserved.
//

import UIKit

class EmoticonCell: UICollectionViewCell {
    
    var emticon : Emticons?
    {
        didSet{
            guard let emticon = emticon else {
                return
            }
            let image = UIImage(contentsOfFile: emticon.pngPath ?? "" )
            emoticonBtn.setImage(image , for: .normal)
            emoticonBtn.setTitle(emticon.emojiCode, for: .normal)
            
            //设置删除按钮
            if emticon.isRemove{
                emoticonBtn.setImage(UIImage(named:"compose_emotion_delete"), for: .normal)
            }
        }
    }
    fileprivate lazy var emoticonBtn : UIButton = UIButton()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmoticonCell{
    
    fileprivate func setUpUI(){
        contentView.addSubview(emoticonBtn)
        emoticonBtn.frame = contentView.frame
        emoticonBtn.isUserInteractionEnabled = false
        emoticonBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
    }
    
    
}
