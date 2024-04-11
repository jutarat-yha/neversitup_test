//
//  ProductListCollectionViewCell.swift
//  Departments
//
//  Created by Jutarat Yothasilarak on 9/4/2567 BE.
//

import UIKit

class ProductListCollectionViewCell: UICollectionViewCell {
    
    typealias ButtonPressed = ((ProductListData) -> ())
    private var productPressed: ButtonPressed?
    private var productData: ProductListData?
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var pricesLabel: UILabel!
    @IBOutlet weak var buttonView: UIButton!
    @IBAction private func productPressed(_ sender: UIButton) {
        guard let productPressed = productPressed, let productData = productData else { return }
        productPressed(productData)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        mainView.layer.borderWidth = 1.5
        mainView.layer.borderColor = UIColor.lightGray.cgColor
        mainView.layer.cornerRadius = 8
        imageView.layer.cornerRadius = 8
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setupData(data: ProductListData) {
        productData = data
        nameLabel.text = data.name
        descLabel.text = data.desc
        guard let imageUrl = URL(string: data.imageUrl) else { return }
        self.imageView.downloadImage(from: imageUrl)
    }
    
    // MARK: - Closure
    func productPressed(_ productPressed: @escaping ButtonPressed) {
        self.productPressed = productPressed
    }
}
