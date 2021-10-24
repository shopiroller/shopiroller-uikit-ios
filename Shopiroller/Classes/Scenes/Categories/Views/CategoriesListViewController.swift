//
//  CategoriesListViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 22.10.2021.
//

import UIKit

class CategoriesListViewController: BaseViewController<CategoriesListViewModel> {
    
    struct Constants {
        
        static var subCategoryContainerText: String { return "sub-category-container-text".localized }
        
    }
    
    @IBOutlet private weak var showAllSubCategoriesContainer: UIView!
    @IBOutlet private weak var showAllSubCategoriesTitle: UILabel!
    @IBOutlet private weak var categoriesTableView: UITableView!

    init(viewModel: CategoriesListViewModel){
        super.init(viewModel: viewModel, nibName: CategoriesListViewController.nibName, bundle: Bundle(for: CategoriesListViewController.self))
    }
    
    public override func setup() {
        super.setup()
        
        showAllSubCategoriesContainer.layer.cornerRadius = 15
        showAllSubCategoriesContainer.layer.borderWidth = 1
        showAllSubCategoriesContainer.layer.borderColor = UIColor.textPCaption.withAlphaComponent(0.3).cgColor
        showAllSubCategoriesContainer.layer.masksToBounds = true
        showAllSubCategoriesContainer.clipsToBounds = true
       
        
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        categoriesTableView.register(cellClass: CategoriesListCell.self)
        categoriesTableView.separatorStyle = .none
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backButton = UIBarButtonItem(customView: createNavigationItem(.backIcon , .goBack))
        let cartButton = UIBarButtonItem(customView: createNavigationItem(.cartIcon, .goToCard , true))
        let searchButton = UIBarButtonItem(customView: createNavigationItem(.searchIcon , .searchProduct))
        let shareButton = UIBarButtonItem(customView: createNavigationItem(.moreIcon , .openOptions))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItems = [shareButton,searchButton,cartButton]
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.makeNavigationBar(.clear)
        
        
         if viewModel.isSubCategory == true {
             showAllSubCategoriesTitle.text = Constants.subCategoryContainerText.replacingOccurrences(of: "XX", with: viewModel.getTitle() ?? "")
             showAllSubCategoriesContainer.isHidden = false
         }else {
             showAllSubCategoriesContainer.isHidden = true
         }
        
    }

    
    func setSubCategories(position: Int){
        self.showAllSubCategoriesTitle.text = viewModel.getCategoryTitle(position: position)
        let vc = CategoriesListViewController(viewModel: CategoriesListViewModel(categoryList: viewModel.categoryList?[position].subCategories, isSubCategory: true))
        prompt(vc, animated: true, completion: nil)
    }
    
}

extension CategoriesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getModel()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: CategoriesListCell.reuseIdentifier) as! CategoriesListCell
        cell.selectionStyle = .none
        cell.setupCategories(model: self.viewModel.getModel()?[indexPath.row] ?? SRCategoryResponseModel())
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.hasSubCategory(position: indexPath.row){
            self.setSubCategories(position: indexPath.row)
            viewModel.title = viewModel.getCategoryTitle(position: indexPath.row)
        }else {
            //TO DO Go To Product List
            print("\(viewModel.categoryList?[indexPath.row].name)")
        }
        
    }
}
