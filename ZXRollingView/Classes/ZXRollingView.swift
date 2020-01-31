//
//  ZXRollingView.swift
//  ZXRollingControl
//
//  Created by ozx on 2020/1/29.
//  Copyright © 2020 ozx. All rights reserved.
//

import UIKit

class ZXRollingView: UIView {
    
    var collectionView: UICollectionView!
    var collectionDataAry: [Int] = [1,2,3,1,2,3];
    var collectionAry: [UICollectionView] = []
    var itemClickBlock: (() -> Void)?
    
    let cheight = 115
    let minimumLineSpacing = 10
    let cellWidth = 125
    let cellHeight = 115
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        self.init()
    }
    
    func setupUI() -> Void {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumLineSpacing = CGFloat(minimumLineSpacing)
        layout.scrollDirection = .horizontal
        
        for index in 0...2 {
            let d:Double = Double(index)
            let offset:Int = cheight / 2
            collectionView = UICollectionView(frame: CGRect(x: 0 , y: 20 + index * (cheight + 10), width: Int(self.frame.size.width ), height: cheight), collectionViewLayout: layout)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.tag = index
            collectionView.backgroundColor = .clear
            collectionView.showsHorizontalScrollIndicator = false
            //只能自动 拒绝手动
            collectionView.isScrollEnabled = false;
            collectionView.setContentOffset(CGPoint(x: Int(pow(-1.0,d) * Double(offset)), y: 0), animated: false)
            self.addSubview(collectionView)
            collectionAry.append(collectionView)
            collectionView.register(ZXCollectionViewCell.self, forCellWithReuseIdentifier: index.description)
        }
        
        
        let timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .tracking)
    }
    
    @objc func autoScroll() {
        for index in 0...2 {
            let collectionView = collectionAry[index]
            
            var offsetX = collectionView.contentOffset.x
            var widd = collectionView.contentSize.width
            widd = collectionView.contentSize.width - self.frame.size.width + 10
            if offsetX > widd{
                offsetX = CGFloat((cellWidth + minimumLineSpacing) * collectionDataAry.count/2) - self.frame.size.width
                collectionView.setContentOffset(CGPoint(x: offsetX , y: 0), animated: false)
                collectionView.setContentOffset(CGPoint(x: offsetX + 10, y: 0), animated: true)
            }else{
                collectionView.setContentOffset(CGPoint(x: offsetX + 10, y: 0), animated: true)
            }
            
        }
    }
    
}

extension ZXRollingView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.collectionDataAry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ZXCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionView.tag.description, for: indexPath) as! ZXCollectionViewCell
        cell.textLabel.text = collectionDataAry[indexPath.row].description;
        cell.backgroundColor = UIColor.red
        cell.layer.cornerRadius = 10
        return cell
    }
}
