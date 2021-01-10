//
//  ProductViewController.swift
//  vcommerce
//
//  Created by JeongU Park on 2021/01/10.
//

import Foundation
import UIKit

class ProductViewController : UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var optionLayout: RoundedBoarderView!
    var baseOptionView: ProductBaseOptionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.baseOptionView = Bundle.main.loadNibNamed("ProductOption", owner: nil)?[1] as! ProductBaseOptionView
        
        self.baseOptionView.frame.origin.y = self.optionLayout.frame.origin.y + self.optionLayout.frame.size.height + 24
        contentView.addSubview(self.baseOptionView)
        contentView.frame.size.height += self.baseOptionView.frame.size.height + 24 + 24
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: contentView.frame.size.height)
        
        
    }
    
    @IBAction func cloaseClick(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}
