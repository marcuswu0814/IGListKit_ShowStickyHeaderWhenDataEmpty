    //
//  ViewController.swift
//  StickyHeader
//
//  Created by Marcus Wu on 2018/3/17.
//  Copyright © 2018年 MarcusWu. All rights reserved.
//

import UIKit
import IGListKit

class ViewController: UIViewController {
    
    var leftBarButton: UIBarButtonItem?
    
    lazy var layout: ListCollectionViewLayout = {
        let layout = ListCollectionViewLayout(stickyHeaders: true,
                                              topContentInset: 0,
                                              stretchToEdge: true)
        
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: self.layout)
        
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                  viewController: self)
        adapter.dataSource = self
        adapter.collectionView = self.collectionView
        
        return adapter
    }()
    
    lazy var section0 = ViewModel(with: self, sectionTitle: "Section 0")
    lazy var section1 = ViewModel(with: self, sectionTitle: "Section 1")
    lazy var section2 = ViewModel(with: self, sectionTitle: "Section 2")
    lazy var section3 = ViewModel(with: self, sectionTitle: "Section 3")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.collectionView)
        self.adapter.performUpdates(animated: true, completion: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(reload))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.collectionView.frame = self.view.safeAreaLayoutGuide.layoutFrame
    }
    
    @objc func reload() {
        self.section0 = ViewModel(with: self, sectionTitle: "Section 0")
        self.section1 = ViewModel(with: self, sectionTitle: "Section 1")
        self.section2 = ViewModel(with: self, sectionTitle: "Section 2")
        self.section3 = ViewModel(with: self, sectionTitle: "Section 3")
        self.adapter.reloadData(completion: nil)
    }
    
}

extension ViewController: ViewModelDelegate {
    
    func dataDidChanged(_ viewModel: ViewModel) {
        self.adapter.reloadData { (finished) in
            guard let sectionController = self.adapter.sectionController(for: viewModel) else { return }
            
            sectionController.collectionContext?.invalidateLayout(for: sectionController, completion: nil)
            
            self.adapter.visibleObjects().forEach({ (viewModel) in
                if let viewModel = viewModel as? ViewModel {
                    print("\(String(describing: viewModel.sectionTitle)) is visable")
                }
            })
            
            self.adapter.visibleSectionControllers().forEach({ (sectionController) in
                if let sectionController = sectionController as? SectionController {
                    print("\(String(describing: sectionController.viewModel?.sectionTitle)) sectionController is visable")
                }
            })
            
            
        }
    }
    
}

extension ViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [self.section0,
                self.section1,
                self.section2,
//                self.section3
                ]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return SectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}
