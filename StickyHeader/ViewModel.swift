//
//  ViewModel.swift
//  StickyHeader
//
//  Created by Marcus Wu on 2018/3/17.
//  Copyright © 2018年 MarcusWu. All rights reserved.
//

import UIKit
import IGListKit

protocol ViewModelDelegate: NSObjectProtocol {
    
    func dataDidChanged(_ viewModel: ViewModel)
    
}

class ViewModel: NSObject {

    weak var delegate: ViewModelDelegate?
    
    var sectionTitle: String?
    
    lazy var data: [String] = {
        var data = [String]()
        
        for index in 0...0 {
            data.append("\(index)")
        }
        
        return data
    }()
    
    init(with delegate: ViewModelDelegate?, sectionTitle: String?) {
        super.init()
        
        self.delegate = delegate
        self.sectionTitle = sectionTitle
    }
    
    func append() {
        self.data.append("\(self.data.count)")
        self.delegate?.dataDidChanged(self)
    }
    
    func remove() {
        guard self.data.count > 0 else { return }
        
        self.data.removeLast()
        self.delegate?.dataDidChanged(self)
    }
    
}

extension ViewModel: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? ViewModel else {
            return false
        }
        
        return self == object
    }
    
}
