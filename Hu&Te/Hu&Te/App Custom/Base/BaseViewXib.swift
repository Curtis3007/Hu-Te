//
//  BaseViewXib.swift
//  NovelBooks
//
//  Created by BigSur on 10/05/2021.
//

import UIKit

class BaseViewXib: UIView {
    
    var view : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    func loadViewFromNib() {
        let nibName     = String(describing: type(of: self))
        let nib         = UINib(nibName: nibName, bundle: Bundle.main)
        view        =   nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        view?.frame      = bounds
//        print("nib name: \(nibName)")
        addSubview(view ?? UIView())
        view?.fillVerticalSuperview()
        view?.fillHorizontalSuperview()
        setUpViews()
    }
    
    func setUpViews() {
        
    }
}

