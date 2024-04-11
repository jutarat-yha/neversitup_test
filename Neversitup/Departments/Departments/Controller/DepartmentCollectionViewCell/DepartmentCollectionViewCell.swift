//
//  DepartmentCollectionViewCell.swift
//  Departments
//
//  Created by Jutarat Yothasilarak on 9/4/2567 BE.
//

import UIKit

class DepartmentCollectionViewCell: UICollectionViewCell {
    
    typealias ButtonPressed = ((DepartmentData) -> ())
    private var departmentPressed: ButtonPressed?
    private var departmentData: DepartmentData?
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var buttonView: UIButton!
    @IBAction private func departmentPressed(_ sender: UIButton) {
        guard let departmentPressed = departmentPressed, let departmentData = departmentData else { return }
        departmentPressed(departmentData)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        mainView.layer.borderWidth = 2
        mainView.layer.borderColor = UIColor.gray.cgColor
        mainView.layer.cornerRadius = 8
        nameView.layer.cornerRadius = 8
        nameView.backgroundColor = .white
        imageView.layer.cornerRadius = 8
    }
    
    func setupData(data: DepartmentData) {
        departmentData = data
        nameLabel.text = data.name
        guard let imageUrl = URL(string: data.imageUrl) else { return }
        self.imageView.downloadImage(from: imageUrl)
    }
    
    
    // MARK: - Closure
    func departmentPressed(_ departmentPressed: @escaping ButtonPressed) {
        self.departmentPressed = departmentPressed
    }
}
