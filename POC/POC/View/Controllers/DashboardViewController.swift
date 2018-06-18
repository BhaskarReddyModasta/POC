//
//  DashboardViewController.swift
//  POC
//
//  Created by Admin on 13/06/18.
//  Copyright © 2018 Bhaskar. All rights reserved.
//

import UIKit
import SDWebImage

class DashboardViewController: UIViewController {

    fileprivate let cellIdentifier = "cellid"
    fileprivate let listTableView = UITableView()
    fileprivate var viewModel = DashBoardViewModel()
    fileprivate var refresh = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetUp()
        makeApiRequest()
    }
    func navigationBarSetUp() {
        self.navigationItem.title = "POC"
        self.navigationController?.navigationBar.backgroundColor = .lightGray
        self.view.backgroundColor = .white
        refresh = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(self.clickButton))
        refresh.isEnabled = false
        navigationItem.rightBarButtonItems = [refresh]
    }
    @objc func clickButton(){
        makeApiRequest()
    }
    // MARK: - Make api request
    func makeApiRequest() {
        let sv = UIViewController.displaySpinner(onView: self.view)
        viewModel.getbrandsAndSubbrands(urlString: Constants().apiEndPoint) { [weak self] (isSuccess, error) in
            UIViewController.removeSpinner(spinner: sv)
            self?.refresh.isEnabled = true
            if isSuccess! {
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
        listTableView.rowHeight = UITableViewAutomaticDimension
        listTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cellid")
        
        view.addSubview(listTableView)
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
// MARK: - UITableView Delegate and datasource
extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)  as! CustomTableViewCell
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
