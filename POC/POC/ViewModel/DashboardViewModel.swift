//
//  DashboardViewModel.swift
//  POC
//
//  Created by Admin on 14/06/18.
//  Copyright © 2018 Bhaskar. All rights reserved.
//

import Foundation
import UIKit
class DashBoardViewModel {
    var apiClient = APIClient()
    var navigationBarTitle: String?
    var rowsListArray:[RowsList] = [RowsList]()

    // - This function is what directly accesses the apiClient to make the API call
    func getbrandsAndSubbrands(urlString: String, completion: @escaping (_ isSuccess: Bool?,
        _ error: String?) -> Void) {
        // call on the apiClient to fetch the Title and rows List
        apiClient.getRequestFetch(urlString: urlString, completion: {[weak self] (rowsList, isSuccess, error)  in
            DispatchQueue.main.async {
                guard let dataDict = rowsList else {
                    return
                }
                let value = CanadaDataModel.init(json:dataDict)
                self?.navigationBarTitle = value.title
                self?.rowsListArray = value.rowsListArray
                completion(isSuccess, error)
            }
        })
    }
    
    func loadNavigationBarTitle() -> String? {
        return self.navigationBarTitle
    }
    func numberOfRowsCount() -> Int {
        return self.rowsListArray.count
    }
    func getTitle(indexpath: IndexPath) -> String? {
        return self.rowsListArray[indexpath.row].title
    }
    func getDescription(indexpath: IndexPath) -> String? {
        return self.rowsListArray[indexpath.row].description
    }
    func getImageUrl(indexpath: IndexPath) -> String? {
        return self.rowsListArray[indexpath.row].imageHref
    }
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}
