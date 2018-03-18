//
//  SectionController.swift
//  StickyHeader
//
//  Created by Marcus Wu on 2018/3/17.
//  Copyright © 2018年 MarcusWu. All rights reserved.
//

import UIKit
import IGListKit

class SectionController: ListSectionController {
    
    var viewModel: ViewModel?
    
    override init() {
        super.init()
        
        self.supplementaryViewSource = self
    }
    
    override func didUpdate(to object: Any) {
        guard let viewModel = object as? ViewModel else {
            return
        }
        
        self.viewModel = viewModel
    }

    override func numberOfItems() -> Int {
        guard let count = self.viewModel?.data.count else {
            return 0
        }
        
        return count
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = self.collectionContext?.dequeueReusableCell(withNibName: "CollectionViewCell", bundle: nil, for: self, at: index) else {
            fatalError()
        }
        
        if let cell = cell as? CollectionViewCell {
            cell.label.text = self.viewModel?.data[index]
        }
        
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = self.collectionContext else {
            return .zero
        }
        
        return CGSize(width: context.containerSize.width, height: 50)
    }
    
}

extension SectionController: ListSupplementaryViewSource {
    
    func supportedElementKinds() -> [String] {
        return [UICollectionElementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        guard let view = self.collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                                  for: self,
                                                                                  nibName: "StickyHeader",
                                                                                  bundle: nil,
                                                                                  at: index) else {
            fatalError()
        }
        
        if let stickyHeader = view as? StickyHeader {
            stickyHeader.delegate = self
            stickyHeader.titleLabel.text = self.viewModel?.sectionTitle
        }
        
        return view
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        guard let context = self.collectionContext else {
            return .zero
        }
        
        return CGSize(width: context.containerSize.width, height: 70)
    }
    
}

extension SectionController: StickyHeaderDelegate {
    
    func addButtonClick() {
        self.viewModel?.append()
    }
    
    func removeButtonClick() {
        self.viewModel?.remove()
    }
    
}
