//
//  CanadaListModel.swift
//  POC
//
//  Created by Admin on 13/06/18.
//  Copyright © 2018 Bhaskar. All rights reserved.
//

import Foundation
internal class CanadaListDataModel {
    let title               :String?
    let rowsList            :[Dictionary<String, Any>]?
    var rowsListArray:[RowsList] = [RowsList]()
    init(json : Dictionary<String, Any>?) {
        self.title      = json?["title"] as? String
        self.rowsList   = json?["rows"] as? [Dictionary<String, Any>]
        for item in (self.rowsList)! {
            let value = RowsList.init(json:item)
            self.rowsListArray.append(value)
        }
    }
    func isEmptyLists(dict: [String: [String]]) -> Bool {
        for list in dict.values {
            if !list.isEmpty { return false }
        }
        return true
    }
}
internal struct RowsList {
    let title              :String?
    let description        :String?
    let imageHref          :String?

    init(json : Dictionary<String, Any>?) {
            self.title          = json!["title"] as? String ?? ""
            self.description    = json!["description"] as? String ?? ""
            self.imageHref      = json!["imageHref"] as? String ?? ""
    }
}
