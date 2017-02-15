//
//  EmotionViewController.swift
//  SwiftForDemo
//
//  Created by LyforMac on 17/1/4.
//  Copyright © 2017年 playTeam. All rights reserved.
//

import UIKit

fileprivate let EmotionCell = "EmotionCell"
class EmotionViewController: UIViewController {

    var emticonCallback : (_ emticon : Emticons) -> ()
    fileprivate lazy var collectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: EmticonCollectionViewLayOut())
    
    fileprivate lazy var toolBar : UIToolbar = UIToolbar()
    fileprivate lazy var manager = EmoticonManager()
    
    //MARK:-自定义函数
    init(emoticonCallback : @escaping (_ emticon : Emticons) -> ()){
        
        self.emticonCallback = emoticonCallback
        
       super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setUpUI()
        
    }

}
//MARK:- 通过VFL进行布局
extension EmotionViewController{
    fileprivate func setUpUI(){
     
        view.addSubview(collectionView)
        view.addSubview(toolBar)
        collectionView.backgroundColor = UIColor.orange
        toolBar.backgroundColor = UIColor.red
        //设置子控件的frame 
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        let views = ["toolBar":toolBar,"collectionView":collectionView] as [String : Any]
        //水平方向
      var cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[toolBar]-0-|", options: [], metrics: nil, views: views)
        
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-0-[toolBar]-0-|", options: [.alignAllLeft,.alignAllRight], metrics: nil, views: views)
        view.addConstraints(cons)
        prepareForCollectionView()
        prepareForToolBar()
    }
    
    fileprivate func prepareForCollectionView() {
        
        collectionView.register(EmoticonCell.self, forCellWithReuseIdentifier: EmotionCell)
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    fileprivate func prepareForToolBar(){
        let titles = ["最近","默认","emoji","浪小花"]
        var index = 0
        var tempItems = [UIBarButtonItem]()
        for title in titles{
            let item = UIBarButtonItem(title: title, style: .plain, target:self, action: #selector(EmotionViewController.itemClick(item:)))
            item.tag = index
            index += 1
            
            tempItems.append(item)
        tempItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        tempItems.removeLast()
        toolBar.items = tempItems
        toolBar.tintColor = UIColor.orange
    }
    
    @objc fileprivate func itemClick(item:UIBarButtonItem){
        
        let tag = item.tag
        let indexpath = NSIndexPath(item: 0, section: tag)
        collectionView.scrollToItem(at: indexpath as IndexPath, at: .left, animated: true)
        
    }
    
}

extension EmotionViewController :UICollectionViewDataSource,UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
      return  manager.pakeages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let pakeage = manager.pakeages[section]
        return pakeage.emticons.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmotionCell, for: indexPath) as! EmoticonCell
        let pakeage = manager.pakeages[indexPath.section]
        let emoticon = pakeage.emticons[indexPath.item]
        cell.emticon = emoticon
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pakeage = manager.pakeages[indexPath.section]
        let emoticon = pakeage.emticons[indexPath.item]
        LYLog(message: emoticon)
        //将点击的表情插入到最近
        insertRecentlyEmoticon(emmticon: emoticon)
        
        emticonCallback(emoticon)
    }
    fileprivate func insertRecentlyEmoticon (emmticon:Emticons){
        //如果是空白表情或者是删除按钮则不需要插入
        if emmticon.isRecently || emmticon.isRemove {
            return
        }
        if manager.pakeages.first!.emticons.contains(emmticon){
            let index = manager.pakeages.first!.emticons.index(of: emmticon)
            manager.pakeages.first!.emticons.remove(at:index!)
        }
        else{
            manager.pakeages.first!.emticons.remove(at: 19)
        }
        manager.pakeages.first?.emticons.insert(emmticon, at: 0)
        
    }
    
}

//MARK:-重写UICollectionViewFlowLayout
class EmticonCollectionViewLayOut: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        let itemWH = UIScreen.main.bounds.width / 7
        itemSize = CGSize(width: itemWH, height: itemWH)
        
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        
        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        let insetMargin = ((collectionView?.bounds.height)! - 3 * itemWH)/2
        collectionView?.contentInset = UIEdgeInsets(top: insetMargin, left: 0, bottom: insetMargin, right: 0)
        
    }
    


}



