//
//  DGIndexLabel.swift
//  AnimationSample
//
//  Created by Innofied on 08/12/17.
//  Copyright © 2017 Innofied. All rights reserved.
//

import UIKit
@IBDesignable
class DGIndexLabel: UILabel {
    @IBInspectable
    var index: Int = 1 {
        didSet {
            setUp()
        }
    }
    @IBInspectable
    var numberOfItems: Int = 1 {
        didSet {
            setUp()
        }
    }
    @IBInspectable
    var formatOfIndex: String = "%d/%d" {
        didSet {
            setUp()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
         setUp()
    }
    
    func setUp() {
        setUp(format: formatOfIndex, index: index, totalItems: numberOfItems)
    }
    
    func setUp(format:String,index:Int,totalItems:Int) {
        self.textAlignment = .center
        self.text = String(format: format,index,totalItems)
        
    }
    
    func setUp(index:Int,totalItems:Int) {
        self.textAlignment = .center
        self.text = String(format: formatOfIndex,index,totalItems)
        
    }

}
