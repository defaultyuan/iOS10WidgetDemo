//
//  TodayViewController.swift
//  TodayWidget
//
//  Created by 袁斌 on 2016/10/18.
//  Copyright © 2016年 https://github.com/DefaultYuan. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDelegate, UITableViewDataSource {
    
    let maxCount = 11.0
    var minCellHeight = 0.0
    var dataArray : NSMutableArray?
    let cellID = "Cell"
    
    
    @IBOutlet weak var widgetTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        //设置widget的模式为expanded
        extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
        
        //取到widget最大的size
        let maxSize = extensionContext?.widgetMaximumSize(for: NCWidgetDisplayMode.expanded)
        minCellHeight = Double((maxSize?.height)!) / maxCount
        
        initData()
        
        widgetTableView.delegate = self
        widgetTableView.dataSource =  self
        
        
    }
    
    private func initData() {
        //初始化数据源
        let data = [["name": "农业银行","price": "20000.00"],["name": "农业银行","price": "20000.00"],["name": "农业银行","price": "20000.00"],["name": "农业银行","price": "20000.00"],["name": "农业银行","price": "20000.00"],["name": "农业银行","price": "20000.00"],["name": "农业银行","price": "20000.00"],["name": "农业银行","price": "20000.00"],["name": "农业银行","price": "20000.00"]]

        dataArray = NSMutableArray()
        
        for dict in data {
            let item = Item.initWithDict(dict: dict )
            dataArray?.add(item)
        }
        
    }
    
    //UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return dataArray!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil {
            cell = UITableViewCell(style:.value1, reuseIdentifier: cellID)
        }
        
        let item = dataArray?.object(at: indexPath.row) as! Item
        
        cell?.textLabel?.text = item.name
        cell?.detailTextLabel?.text = item.price
        cell?.detailTextLabel?.textColor = UIColor.blue
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(minCellHeight);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func widgetPerformUpdate(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        
        if activeDisplayMode == .compact {
            preferredContentSize = maxSize
        } else {
            preferredContentSize = CGSize.init(width: Double(maxSize.width), height: Double((dataArray?.count)!) * minCellHeight)
        }
        
    }
}
