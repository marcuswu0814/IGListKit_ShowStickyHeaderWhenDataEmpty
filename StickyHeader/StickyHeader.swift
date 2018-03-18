//
//  StickyHeader.swift
//  StickyHeader
//
//  Created by Marcus Wu on 2018/3/17.
//  Copyright © 2018年 MarcusWu. All rights reserved.
//

import UIKit

protocol StickyHeaderDelegate: NSObjectProtocol {
    
    func addButtonClick()
    
    func removeButtonClick()
    
}

class StickyHeader: UICollectionReusableView {

    weak var delegate: StickyHeaderDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func addButtonClick( sender: Any) {
        self.delegate?.addButtonClick()
    }
    
    @IBAction func removeButtonClick(_ sender: Any) {
        self.delegate?.removeButtonClick()
    }
    
}
