//
//  SelectOptionViewController.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/12/27.
//

import Foundation
import UIKit

class SelectOptionViewController : UIViewController , UICollectionViewDelegate, UICollectionViewDataSource{
    @IBOutlet weak var fristOptionCollectionView: UICollectionView!
    @IBOutlet weak var secondOptionCollectionView: UICollectionView!
    @IBOutlet weak var thirdOptionCollectionView: UICollectionView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize =  CGSize(width:UIScreen.main.bounds.width, height: 1200)
        fristOptionCollectionView.delegate = self
        fristOptionCollectionView.dataSource = self
        secondOptionCollectionView.delegate = self
        secondOptionCollectionView.dataSource = self
        thirdOptionCollectionView.delegate = self
        thirdOptionCollectionView.dataSource = self
        
    }
    @IBAction func cloaseBtnAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.secondOptionCollectionView {
            let secondOptionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondOptionCell", for: indexPath) as! SecondOptionCell

            return secondOptionCell
        }

        else if collectionView == self.thirdOptionCollectionView{
            let ThirdOptionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdOptionCell", for: indexPath) as! ThirdOptionCell

            return ThirdOptionCell
        }
        else {
            let fristOptionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FristOptionCell", for: indexPath) as! FristOptionCell
            return fristOptionCell
        }
        
    }
    
}
