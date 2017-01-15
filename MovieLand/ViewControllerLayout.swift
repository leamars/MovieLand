//
//  ViewControllerLayout.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/14/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

extension ViewController {
    //MARK: Constraints
    func setupConstraints() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableTopConstraint = NSLayoutConstraint(
            item: tableView,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1.0,
            constant: tableTopOffset)
        
        let tableCenterX = NSLayoutConstraint(
            item: tableView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let tableWidth = NSLayoutConstraint(
            item: tableView,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1.0,
            constant: 0.0)
        
        let tableBottom = NSLayoutConstraint(
            item: tableView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0.0)
        
        view.addConstraints([
            tableTopConstraint,
            tableCenterX,
            tableWidth,
            tableBottom]
        )
        
        filterView.translatesAutoresizingMaskIntoConstraints = false
        
        let filterCenterX = NSLayoutConstraint(
            item: filterView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let filterWidth = NSLayoutConstraint(
            item: filterView,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1.0,
            constant: 0.0)
        
        let filterBottom = NSLayoutConstraint(
            item: filterView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: tableView,
            attribute: .top,
            multiplier: 1.0,
            constant: 0.0)
        
        let filterHeight = NSLayoutConstraint(
            item: filterView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: filtersViewCompactSize)
        
        view.addConstraints([
            filterCenterX,
            filterWidth,
            filterBottom,
            filterHeight]
        )
    }
}
