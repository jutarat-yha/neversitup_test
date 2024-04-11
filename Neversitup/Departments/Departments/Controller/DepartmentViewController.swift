//
//  DepartmentViewController.swift
//  Departments
//
//  Created by Jutarat Yothasilarak on 9/4/2567 BE.
//

import UIKit

class DepartmentViewController: UIViewController {
    
    var departmentViewModel: DepartmentViewModel?
    var productListViewModel: ProductViewModel?
    
    @IBOutlet weak var departmentTitleLabel: UILabel!
    @IBOutlet weak var productListTitleLabel: UILabel!
    @IBOutlet weak var departmentCollectionView: UICollectionView! {
        didSet {
            departmentCollectionView.dataSource = self
            departmentCollectionView.delegate = self
            departmentCollectionView.register(UINib(nibName: "DepartmentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DepartmentCollectionViewCell")
        }
    }
    @IBOutlet weak var productCollectionView: UICollectionView! {
        didSet {
            productCollectionView.dataSource = self
            productCollectionView.delegate = self
            productCollectionView.register(UINib(nibName: "ProductListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductListCollectionViewCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.departmentTitleLabel.text = "Department Carousel"
        callDepartmentViewModel()
    }
    
    func callDepartmentViewModel() {
        self.departmentViewModel = DepartmentViewModel()
        self.departmentViewModel?.onDepartmentsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.departmentCollectionView.reloadData()
            }
        }
    }
    
    func callProductListViewModel(departmentId: String) {
        self.productListViewModel = ProductViewModel()
        self.productListViewModel?.fecthProductList(departmentId: departmentId)
        self.productListViewModel?.onProductListUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.productCollectionView.reloadData()
            }
        }
    }
    
    func showDialogView(descText: String) {
        let destinationVC = DialogView(nibName: "DialogView", bundle: nil)
        destinationVC.descText = descText
        destinationVC.view.backgroundColor = UIColor.clear
        destinationVC.modalPresentationStyle = .overCurrentContext
        self.present(destinationVC, animated: false)
    }
}

extension DepartmentViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == departmentCollectionView {
            return departmentViewModel?.departmentData.count ?? 0
        } else {
            return productListViewModel?.productListData.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == departmentCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DepartmentCollectionViewCell", for: indexPath) as? DepartmentCollectionViewCell else { return UICollectionViewCell() }
            guard let departmentViewModel = departmentViewModel else { return UICollectionViewCell() }
            let data = departmentViewModel.departmentData[indexPath.item]
            cell.setupData(data: data)
            cell.departmentPressed { [weak self] item in
                guard let self = self else { return }
                self.callProductListViewModel(departmentId: item.id)
                self.productListTitleLabel.text = "Product list : \(item.name)"
                self.productCollectionView.reloadData()
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCollectionViewCell", for: indexPath) as? ProductListCollectionViewCell else { return UICollectionViewCell() }
            guard let productListViewModel = productListViewModel else { return UICollectionViewCell() }
            let data = productListViewModel.productListData[indexPath.item]
            cell.setupData(data: data)
            cell.productPressed { [weak self] item in
                guard let self = self else { return }
                self.showDialogView(descText: item.desc)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == departmentCollectionView {
            return CGSize(width: 100, height: 100)
        } else {
            let width: CGFloat = (collectionView.frame.size.width-10)/2
            let height: CGFloat = 250
            return CGSize(width: width, height: height)
        }
    }
    
}
