//
//  CartViewController.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/12/18.
//


import Foundation
import UIKit

class CartViewController : UIViewController , UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.cartTableView.delegate = self
        self.cartTableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CartCell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
        cell.selectionStyle = .none
        return cell
    }
    @IBAction func backBtnClick(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
