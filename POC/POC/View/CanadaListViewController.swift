//
//  CanadaListViewController.swift
//  POC
//
//  Created by Admin on 13/06/18.
//  Copyright © 2018 Bhaskar. All rights reserved.
//

import UIKit
import SDWebImage

class CanadaListViewController: UIViewController {

    fileprivate let cellIdentifier = "cellid"
    fileprivate let listTableView = UITableView()
    fileprivate var viewModel = CanadaListViewModel()
    fileprivate var refresh = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set up
        navigationBarSetUp()
        makeApiRequest()
    }
    func navigationBarSetUp() {
        self.navigationItem.title = "POC"
        self.navigationController?.navigationBar.backgroundColor = .lightGray
        self.view.backgroundColor = .white
        refresh = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(self.refreshButtonAction))
        refresh.isEnabled = false
        navigationItem.rightBarButtonItems = [refresh]
    }
    // MARK: - Refresh Api
    @objc func refreshButtonAction(){
        makeApiRequest()
    }
    // MARK: - Make api request
    func makeApiRequest() {
        let sv = UIViewController.displaySpinner(onView: self.view)
        viewModel.getbrandsAndSubbrands(urlString: Constants().apiEndPoint) { [weak self] (isSuccess, error) in
            UIViewController.removeSpinner(spinner: sv)
            self?.refresh.isEnabled = true
            if (isSuccess)! {
                self?.navigationItem.title = self?.viewModel.loadNavigationBarTitle()
                self?.configureTableView()
            }else {
                // pop error alert
            }
        }
    }
    func configureTableView() {
    
        listTableView.dataSource = self
        listTableView.estimatedRowHeight = 100
        listTableView.allowsSelection = false
        listTableView.rowHeight = UITableViewAutomaticDimension
        listTableView.register(CanadaListTableViewCell.self, forCellReuseIdentifier: "cellid")
        view.addSubview(listTableView)
        listTableView.translatesAutoresizingMaskIntoConstraints = false

        // below VFL constraints applied
        var constraints = [NSLayoutConstraint]()
        let views: [String: UIView] = ["listTableView": listTableView]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[listTableView(0)]|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[listTableView(0)]|", options: [], metrics: nil, views: views)
        NSLayoutConstraint.activate(constraints)
        
 
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
// MARK: - UITableView Delegate and datasource
extension CanadaListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)  as? CanadaListTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .white
        if let imageUrl = viewModel.getImageUrl(indexpath: indexPath){
            cell.imageViewCustom.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named:"placeHolder.png"))
        }else {
            cell.imageViewCustom.image = UIImage(named: "placeHolder.png")
        }
        cell.detailLabel.text = viewModel.getTitleAndDescription(indexpath: indexPath)
        return cell
    }
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
    }

}
