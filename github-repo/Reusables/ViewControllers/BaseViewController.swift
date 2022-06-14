//
//  BaseViewController.swift
//  github-repo
//
//  Created by Michael Michael on 15.06.22.
//

import UIKit

class BaseViewController: UIViewController {
    
    init() {
        
        let bundle = Bundle(for: type(of: self))
        let nibName = String(describing: type(of: self))
        
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
