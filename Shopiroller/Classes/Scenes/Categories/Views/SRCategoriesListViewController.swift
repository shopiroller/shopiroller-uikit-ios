//
//  CategoriesListViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 22.10.2021.
//

import UIKit

class SRCategoriesListViewController: BaseViewController<SRCategoriesListViewModel> {
    
    @IBOutlet private weak var showAllSubCategoriesContainer: UIView!
    @IBOutlet private weak var showAllSubCategoriesTitle: UILabel!
    @IBOutlet private weak var categoriesTableView: UITableView!
    
    private let badgeView  = SRBadgeButton()
    
    init(viewModel: SRCategoriesListViewModel) {
        super.init(viewModel: viewModel, nibName: SRCategoriesListViewController.nibName, bundle: Bundle(for: SRCategoriesListViewController.self))
        title = viewModel.getPageTitle()
    }
    
    public override func setup() {
        super.setup()
        getCount()
        let showAllProductTapGesture = UITapGestureRecognizer(target: self, action: #selector(showAllProducts))
        showAllSubCategoriesContainer.addGestureRecognizer(showAllProductTapGesture)
        
        showAllSubCategoriesContainer.layer.cornerRadius = 15
        showAllSubCategoriesContainer.layer.borderWidth = 1
        showAllSubCategoriesContainer.layer.borderColor = UIColor.textPCaption.withAlphaComponent(0.3).cgColor
        showAllSubCategoriesContainer.layer.masksToBounds = true
        showAllSubCategoriesContainer.clipsToBounds = true
        
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        categoriesTableView.register(cellClass: SRCategoriesListCell.self)
        categoriesTableView.separatorStyle = .none
        
        if viewModel.isSubCategory == true {
            showAllSubCategoriesContainer.isHidden = false
            showAllSubCategoriesTitle.text = viewModel.getTitle()
        }else {
            showAllSubCategoriesContainer.isHidden = true
        }
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCount()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateBadgeCount),
            name: Notification.Name(SRAppConstants.UserDefaults.Notifications.updateShoppighCartObserve),
            object: nil)
    }
    
    @objc func updateBadgeCount() {
        badgeView.badgeCount = SRAppContext.shoppingCartCount
    }
    
    @objc func showAllProducts() {
        let vc = SRProductListViewController(viewModel: SRProductListViewModel(categoryId: viewModel.getCategoryId(), pageTitle: viewModel.getPageTitle()))
        prompt(vc, animated: true, completion: nil)
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        let cartButton = UIBarButtonItem(customView: createNavigationItem(.generalCartIcon, .goToCard))
        let searchButton = UIBarButtonItem(customView: createNavigationItem(.searchIcon , .searchProduct))
        updateNavigationBar(rightBarButtonItems: [searchButton, cartButton],isBackButtonActive: true)
        cartButton.customView?.addSubview(badgeView)
    }
    
    private func getCount() {
        viewModel.getShoppingCartCount(succes: {
            [weak self] in
            guard let self = self else { return }
        }) {
            [weak self] _ in
            guard let self = self else { return }
        }
    }
    
    func setSubCategories(position: Int) {
        let vc = SRCategoriesListViewController(viewModel: SRCategoriesListViewModel(categoryList: viewModel.categoryList?[position].subCategories, isSubCategory: true,selectedRowName: viewModel.getSelectedRowName(),categoryId: viewModel.getCategoryId()))
        prompt(vc, animated: true, completion: nil)
    }
    
}

extension SRCategoriesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getModel()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: SRCategoriesListCell.reuseIdentifier) as! SRCategoriesListCell
        cell.selectionStyle = .none
        cell.setupCategories(model: self.viewModel.getModel()?[indexPath.row] ?? SRCategoryResponseModel(),categoryDisplayTypeEnum: viewModel.getCategoryDisplayTypeEnum())
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.hasSubCategory(position: indexPath.row) {
            viewModel.setSelectedRowName(position: indexPath.row)
            viewModel.setCategoryId(position: indexPath.row)
            self.setSubCategories(position: indexPath.row)
        } else {
            let vc = SRProductListViewController(viewModel: SRProductListViewModel(categoryId: viewModel.categoryList?[indexPath.row].categoryId, pageTitle: viewModel.categoryList?[indexPath.row].name))
            prompt(vc, animated: true, completion: nil)
        }
    }
}
