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

    var listTableView = UITableView()
    var viewModel = DashBoardViewModel()
    var refresh = UIBarButtonItem()
    var activityView = NDActivityViewHelper()
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
        activityView.startActivity(target: self)
        viewModel.getbrandsAndSubbrands(urlString: Constants().apiEndPoint) { [weak self] (isSuccess, error) in
            self?.activityView.stopActivity()
            self?.refresh.isEnabled = true
            if isSuccess! {
                self?.navigationItem.title = self?.viewModel.loadNavigationBarTitle()
                self?.loadTableView()
            }else {
                // pop error alert
            }
        }
    }
    func loadTableView() {
        listTableView.frame = CGRect(x: 0, y:  (self.navigationController?.navigationBar.frame.size.height)!, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 44); //self.view.frame
        listTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.separatorColor = .clear
        listTableView.allowsSelection = false
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier:"cellid")
        self.view.addSubview(listTableView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
// MARK: - UITableView Delegate and datasource
extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = viewModel.heightForView(text: viewModel.getDescription(indexpath: indexPath)!, font: setFont(), width: UIScreen.main.bounds.width)
        return 250 + 45 + height
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        cell.backgroundColor = .white
        let height = viewModel.heightForView(text: viewModel.getDescription(indexpath: indexPath)!, font: setFont(), width: UIScreen.main.bounds.width)
        let cellView = CellView()
        cellView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250 + 45 + height)
        cellView.loadView(frame: cellView.frame)
        if let imageUrl = viewModel.getImageUrl(indexpath: indexPath){
            cellView.gridImgView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named:"placeHolder.png"))
        }else {
            cellView.gridImgView.image = UIImage(named: "placeHolder.png")
        }
        cellView.gridLabel.text = viewModel.getTitle(indexpath: indexPath)
        cellView.gridDescriptionLabel.text = viewModel.getDescription(indexpath: indexPath)
        cell.bringSubview(toFront: cellView)
        cell.addSubview(cellView)
        return cell
    }

    func setFont() -> UIFont {
        return UIFont(name: "Helvetica", size: 20.0)!
    }
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
        listTableView.reloadData()
    }

}
