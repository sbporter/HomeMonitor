//
//  HistoryChartViewController.swift
//  HomeMonitor
//
//  Created by Seth Porter on 12/5/16.
//  Copyright © 2016 sbporter. All rights reserved.
//

import UIKit
import Charts
import PureLayout

class HistoryChartViewController: UIViewController {
    var chartView: LineChartView = LineChartView()
    let model = HomeModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "History"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.view.backgroundColor = Colors.mediumGray
        
        setupViews()
        
        model.delegates.addDelegate(delegate: self)
        
        model.loadHistoricalData()

    }
}

extension HistoryChartViewController: HomeModelDelegate {
    @objc func climate1TempUpdate() {
        updateHistoryChart()
    }
}

//MARK- Charts
extension HistoryChartViewController {
    func updateHistoryChart() {
        self.setChart(timestamps: model.climate1.temperature.timeValues,
                      values: model.climate1.temperature.values)
    }
    
    func setChart(timestamps: [Double], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<timestamps.count {
            let dataEntry = ChartDataEntry(x: timestamps[i], y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "DataSet")
        
        let chartData = LineChartData(dataSet: chartDataSet)
        
        
        chartDataSet.colors = [Colors.orange]
        
        chartDataSet.mode = .cubicBezier
        chartDataSet.drawCirclesEnabled = false
        chartDataSet.drawCircleHoleEnabled = false
        chartDataSet.circleColors = [Colors.orange]
        chartDataSet.drawFilledEnabled = true
        chartDataSet.fillColor = Colors.orange
        chartDataSet.drawValuesEnabled = false
        chartDataSet.lineWidth = 2.0
        chartDataSet.circleRadius = 5.0
        chartDataSet.circleHoleColor = UIColor.clear
        
        chartView.data = chartData

        
        // Zoom Code.  Doesn't seem to work properly.  //TODO: Debug later
        
//        let totalPoints: Double = Double(timestamps.count)
//        let initialPoints: Int = 15
//        
//        let xMax: Double = timestamps.last ?? Double(Int.max)
//        let xMin: Double = timestamps.first ?? 0
//        let xFullRange: Double = xMax - xMin
//        
//        var xScaledRange: Double = 1
//        if timestamps.count >= initialPoints {
//            xScaledRange = xMax - timestamps[timestamps.count - initialPoints]
//        }
//        let xScale: Double = xScaledRange / xFullRange
//        
//        let initialLeftPoint: Double = totalPoints - Double(initialPoints)
//        
//        chartView.zoom(scaleX: CGFloat(xScale), scaleY: 1.0, x: 0.0, y: 0.0)
//        chartView.moveViewToX(initialLeftPoint)
        
        
        chartView.setNeedsDisplay()
    }
}

extension HistoryChartViewController: ConstraintProtocol {
    func configureSubviews() {
        // Line Chart View
        chartView = LineChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false;
        chartView.noDataText = "Data unavailable.  Check your connection."
        chartView.chartDescription?.text = ""
        chartView.minOffset = 25
        
        chartView.chartDescription?.textColor = Colors.trueWhite
        chartView.leftAxis.labelTextColor = Colors.trueWhite
        chartView.xAxis.labelTextColor = Colors.trueWhite
        chartView.xAxis.gridColor = UIColor.clear
        
        chartView.isUserInteractionEnabled = true
        chartView.drawGridBackgroundEnabled = false
        chartView.legend.enabled = false
        chartView.rightAxis.enabled = false
        
        chartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        
        chartView.xAxis.valueFormatter = DateValueFormatter()
        
        chartView.leftAxis.labelPosition = YAxis.LabelPosition.outsideChart
        
        //        chartView.leftAxis.startAtZeroEnabled = false
        //        chartView.xAxis.labelHeight = 30.0
        //        chartView.xAxis.setLabelsToSkip(500)
        //                chartView.xAxis.granularity = 10.0
        
        
        
        
                chartView.animate(xAxisDuration: 1.0, yAxisDuration: 2.0)
        
        self.view.addSubview(chartView)
    }
    
    func configureConstraints() {
        chartView.autoPinEdgesToSuperviewEdges()
    }
}
