//
//  TableViewController+UITabBarDelegate.swift
//  MemeMeApp2
//
//  Created by Joel Stevick on 4/27/22.
//

import UIKit

extension TableViewController: UITabBarDelegate {
    internal func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tableView.reloadData()
    }
}
