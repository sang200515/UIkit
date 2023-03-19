//
//  ReportFFriendCollectionViewLayout.swift
//  mSM
//
//  Created by Apple on 3/14/19.
//  Copyright © 2019 fptshop.com.vn. All rights reserved.
//

import UIKit

//class ReportFFriendCollectionViewLayout: UICollectionViewLayout


class ReportFFriendCollectionViewLayout: UICollectionViewLayout {
    
    var numberOfColumns = 0;
    var shouldPinFirstColumn = true
    var shouldPinFirstRow = true
    var titleArray: [String] = [];
    
    var itemAttributes = [[UICollectionViewLayoutAttributes]]();
    var itemsSize = [CGSize]()
    var contentSize: CGSize = .zero
    
    override func prepare() {
        guard let collectionView = collectionView else {
            return
        }
        
        if collectionView.numberOfSections == 0 {
            return
        }
        
        if itemAttributes.count != collectionView.numberOfSections {
            generateItemAttributes(collectionView: collectionView)
            return
        }
        
        for section in 0..<collectionView.numberOfSections {
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                                if section != 0 {
                                    continue
                                }
                
//                if section != 0 && item > 1 {
//                    continue
//                }
                
                let attributes = layoutAttributesForItem(at: IndexPath(item: item, section: section))!
                if section == 0 {
                    var frame = attributes.frame
                    frame.origin.y = collectionView.contentOffset.y
                    attributes.frame = frame
                }
//
//                if item == 0 {
//                    var frame = attributes.frame
//                    frame.origin.x = collectionView.contentOffset.x
//                    attributes.frame = frame
//                }
//                // column2 co dinh
//                if(item == 1){
//                    var frame = attributes.frame;
//                    let item0Size = (self.itemsSize[0] as AnyObject).cgSizeValue
//                    frame.origin.x = self.collectionView!.contentOffset.x + item0Size!.width;
//                    attributes.frame = frame;
//                }
            }
        }
        
    }
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return itemAttributes[indexPath.section][indexPath.row]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        for section in itemAttributes {
            let filteredArray = section.filter { obj -> Bool in
                return rect.intersects(obj.frame)
            }
            
            attributes.append(contentsOf: filteredArray)
        }
        
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}

// MARK: - Helpers
extension ReportFFriendCollectionViewLayout {
    
    func generateItemAttributes(collectionView: UICollectionView) {
        if itemsSize.count != numberOfColumns {
            calculateItemSizes()
        }
        
        var column = 0
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        var contentWidth: CGFloat = 0
        
        itemAttributes = []
        
        for section in 0..<collectionView.numberOfSections {
            var sectionAttributes: [UICollectionViewLayoutAttributes] = []
            
            for index in 0..<numberOfColumns {
                let itemSize = itemsSize[index]
                let indexPath = IndexPath(item: index, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height).integral
                
                
                /////----column fixed------
//                if section == 0 && index <= 1 {
//                    // First cell should be on top
//                    attributes.zIndex = 1024
//                } else if section == 0 || index <= 1 {
//                    // First row/column should be above other cells
//                    attributes.zIndex = 1023
//                }
//
//                if section == 0 {
//                    var frame = attributes.frame
//                    frame.origin.y = collectionView.contentOffset.y
//                    attributes.frame = frame
//                }
//                if index == 0 {
//                    var frame = attributes.frame
//                    frame.origin.x = collectionView.contentOffset.x
//                    attributes.frame = frame
//                }
//                //column2 co dinh
//                if(index == 1){
//                    var frame = attributes.frame
//                    frame.origin.x = xOffset;
//                    attributes.frame = frame
//                }
                
                if section == 0 {
                    attributes.zIndex = 1024
                }
                
                sectionAttributes.append(attributes)
                
                xOffset += itemSize.width
                column += 1
                
                if column == numberOfColumns {
                    if xOffset > contentWidth {
                        contentWidth = xOffset
                    }
                    
                    column = 0
                    xOffset = 0
                    yOffset += itemSize.height
                }
            }
            
            itemAttributes.append(sectionAttributes)
        }
        
        if let attributes = itemAttributes.last?.last {
            contentSize = CGSize(width: contentWidth, height: attributes.frame.maxY)
        }
    }
    
    func calculateItemSizes() {
        itemsSize = []
        //var headerWidth:CGFloat = 0
        
        for index in 0..<numberOfColumns {
            itemsSize.append(sizeForItemWithColumnIndex(index))
        }
    }
    
    func sizeForItemWithColumnIndex(_ columnIndex: Int) -> CGSize {
        var text: String;
        
        text = titleArray[columnIndex];
        let size : CGSize = (text as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Common.Size(s:10))])
        //        let width: CGFloat = size.width + 18;
        let width: CGFloat = size.width + 10;
        return CGSize(width: width, height: 25);
    }
}
