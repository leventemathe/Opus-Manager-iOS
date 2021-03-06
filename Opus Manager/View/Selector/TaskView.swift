//
//  TaskView.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 02..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class TaskView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageViewWithOpacityView: ImageViewWithOpacityView!
    @IBOutlet weak var label: LargeLabel!
    @IBOutlet weak var sublabel: SmallLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("TaskView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    func setLabelText(_ text: String) {
        label.text = text
    }
    
    func setImage(_ image: UIImage) {
        imageViewWithOpacityView.image = image
    }
    
    func setSublabelText(_ text: String) {
        sublabel.text = text
    }
}
