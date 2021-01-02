//
//  CartCell.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/12/18.
//

import Foundation
import UIKit

class CartCell : UITableViewCell {
    
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var cellTopView: UIView!
    @IBOutlet weak var cellCheckBox: CheckBox!
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var productOptionView: UIStackView!
    @IBOutlet weak var numberOfProductLabel: UILabel!
    @IBOutlet weak var shippingFeeLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    
    func setCartItem(){
        
    }
}
