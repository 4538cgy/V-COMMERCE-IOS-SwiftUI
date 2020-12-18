//
//  ReviewViewController.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/12/18.
//

import Foundation
import UIKit
class ReviewViewController : UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad(){
        super.viewDidLoad()

        reviewTableView.delegate = self
        reviewTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 10 == 0{
            return 230
        }else{
            return 76
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 10 == 0{
            let cell:ReviewImageCell = tableView.dequeueReusableCell(withIdentifier: "ReviewImageCell", for: indexPath) as! ReviewImageCell
            cell.selectionStyle = .none
            return cell
        }else{
            let cell:ReviewCell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
            cell.selectionStyle = .none
            return cell
        }
      
    }
    @IBAction func backBtnClick(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
}
