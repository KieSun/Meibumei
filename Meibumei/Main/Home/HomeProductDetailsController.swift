//
//  HomeProductDetailsController.swift
//  Meibumei
//
//  Created by 俞诚恺 on 16/7/14.
//  Copyright © 2016年 Kie. All rights reserved.
//

import UIKit
import SnapKit

class HomeProductDetailsController: UIViewController {

    var productModel: Result?
    var topView: UserView?
    var bottomView: ShareAndBuyView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        automaticallyAdjustsScrollViewInsets = false 
        title = "\(productModel!.product.imageCount)张图片"
        
        setupBottomView()
        setupTopView()
        setupTableView()
    }
    
    private func setupBottomView() {
        bottomView = NSBundle.mainBundle().loadNibNamed("ShareAndBuyView", owner: nil, options: nil).first as? ShareAndBuyView
        view.addSubview(bottomView!)
        
        bottomView!.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.height.equalTo(200)
        }
        
        bottomView!.model = productModel
    }
    
    private func setupTopView() {
        topView = NSBundle.mainBundle().loadNibNamed("UserView", owner: nil, options: nil).first as? UserView
        view.addSubview(topView!)
        
        topView!.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.height.equalTo(40)
            make.top.equalTo(64)
        }
        
        topView!.model = productModel

    }
    
    private func setupTableView() {
        let tableView = UITableView()
        view.insertSubview(tableView, atIndex: 0)
        tableView.backgroundColor = UIColor.yellowColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 200
        tableView.registerNib(UINib(nibName: ProductDetailedCellID, bundle: nil), forCellReuseIdentifier: ProductDetailedCellID)
        
        tableView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(topView!.snp_bottom)
        }
    }
}

extension HomeProductDetailsController: UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productModel!.product.imageCount
    }
}

extension HomeProductDetailsController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ProductDetailedCellID) as? ProductDetailedCell
        let urlArray = productModel?.product.imageUrls.componentsSeparatedByString(",")
        cell?.urlString = urlArray![indexPath.row]
        return cell!
    }
}