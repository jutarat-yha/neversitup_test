//
//  DialogView.swift
//  Departments
//
//  Created by Jutarat Yothasilarak on 9/4/2567 BE.
//

import UIKit

class DialogView: UIViewController {
    var descText: String = ""

    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func closePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Product Description"
        closeLabel.text = "Close"
        dialogView.layer.cornerRadius = 14
        self.setupView()
    }
    
    func setupView() {
        descLabel.text = descText
    }
}
