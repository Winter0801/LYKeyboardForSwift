# LYKeyboardForSwift
一款自定义的表情键盘，可以拖动项目里面直接使用在项目中直接
lazy var emoticonVC : EmotionViewController = EmotionViewController { (emoticon) in
        
        self.textView.insertEmoticon(emoticon: emoticon)
        self.textViewDidChange(self.textView)
    }
这样就可以调用键盘, 支持自定义表情
