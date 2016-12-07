//
//  DashboardCollectionViewController.swift
//  HomeMonitor
//
//  Created by Seth Porter on 12/3/16.
//  Copyright © 2016 sbporter. All rights reserved.
//

import UIKit
import Charts
import PureLayout

class DashboardCollectionViewController: UIViewController {
    fileprivate static let temperatureReuseIdentifier: String = String(describing: TemperatureCell.self)
    fileprivate static let humidityReuseIdentifier: String =  String(describing: HumidityCell.self)
    
    fileprivate static let margin: CGFloat = 20
    fileprivate static let insets: UIEdgeInsets = UIEdgeInsetsMake(margin, margin, margin, margin)
    
    var chartView: LineChartView = LineChartView()
    let model = HomeModel.sharedInstance
    
    fileprivate var collectionView: UICollectionView {
        return view as! UICollectionView
    }
    
    override func loadView() {
        let flow: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets.zero
        flow.minimumInteritemSpacing = 0
        self.view = UICollectionView(frame: CGRect.zero, collectionViewLayout: flow)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Home Monitor"
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = Colors.trueWhite

        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TemperatureCell.self, forCellWithReuseIdentifier: DashboardCollectionViewController.temperatureReuseIdentifier)
        collectionView.register(HumidityCell.self, forCellWithReuseIdentifier: DashboardCollectionViewController.humidityReuseIdentifier)
        collectionView.backgroundColor = Colors.mediumGray
        
//        setupViews()
//        
//        model.delegates.addDelegate(delegate: self)
//        
//        model.loadHistoricalData()
    }
}

extension DashboardCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row % 2 == 0{
            let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DashboardCollectionViewController.temperatureReuseIdentifier, for: indexPath)
            
            if let temperatureCell: TemperatureCell = cell as? TemperatureCell {
                temperatureCell.layer.masksToBounds = true
                temperatureCell.layer.cornerRadius = 10
                temperatureCell.layer.borderWidth = 1
                temperatureCell.value = 71.8
                temperatureCell.lastUpdateString = "15 minutes ago"
                
                temperatureCell.layer.borderColor = Colors.lightGray.cgColor
            }
            
            return cell
        } else {
            let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DashboardCollectionViewController.humidityReuseIdentifier, for: indexPath)
            
            if let humidityCell: HumidityCell = cell as? HumidityCell {
                humidityCell.layer.masksToBounds = true
                humidityCell.layer.cornerRadius = 10
                humidityCell.layer.borderWidth = 1
                humidityCell.value = 37
                humidityCell.lastUpdateString = "15 minutes ago"
                
                humidityCell.layer.borderColor = Colors.lightGray.cgColor
            }
            
            return cell
        }
    }
}

extension DashboardCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailChart: HistoryChartViewController = HistoryChartViewController()
        self.navigationController?.pushViewController(detailChart, animated: true)
    }
}

extension DashboardCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (view.bounds.width - 4*DashboardCollectionViewController.margin) / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return DashboardCollectionViewController.insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return DashboardCollectionViewController.margin
    }
}

extension DashboardCollectionViewController: HomeModelDelegate {

}

//MARK:- Configure View and Constraints
extension DashboardCollectionViewController: ConstraintProtocol {
    func configureSubviews() {

    }
    
    func configureConstraints() {
        
    }
}

