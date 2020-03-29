//
//  ChartConfiguerer.swift
//  Summit
//
//  Created by Reagan Wood on 3/23/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import Charts

class ChartConfigurer {
    // TODO: clean up
    public func configureUserChart(chart: LineChartView, chartDataSet: ChartDataSet, withAnimation shouldAnimate: Bool) {
        let ll1 = ChartLimitLine(limit: 150, label: "Goal") // TODO: constants
        ll1.lineWidth = 2
        ll1.lineDashLengths = [0, 0]
        ll1.labelPosition = .topRight
        ll1.valueFont = .systemFont(ofSize: 10)
        ll1.valueTextColor = .offWhite
        ll1.lineColor = .darkBlue // TODO: make whatever the color that is necessary
        
        let rightAxis = chart.rightAxis
        rightAxis.removeAllLimitLines()
        rightAxis.addLimitLine(ll1)
        rightAxis.axisMaximum = chartDataSet.goalY
        rightAxis.axisMinimum = chartDataSet.minY
        rightAxis.gridColor = .clear
        rightAxis.axisLineColor = .clear
        rightAxis.gridLineDashLengths = [5, 5]
        rightAxis.drawLimitLinesBehindDataEnabled = true
        rightAxis.labelTextColor = .offWhite
        
        let leftAxis = chart.leftAxis
        leftAxis.drawAxisLineEnabled = false
        leftAxis.drawLabelsEnabled = false
        leftAxis.axisMaximum = chartDataSet.goalY
        leftAxis.axisMinimum = chartDataSet.minY
        
        let xAxis = chart.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelTextColor = chartDataSet.labelColor
        xAxis.axisMinimum = 0
        xAxis.axisMaximum = chartDataSet.maxX
        xAxis.drawLabelsEnabled = false

        leftAxis.drawGridLinesEnabled = false
        rightAxis.drawGridLinesEnabled = false
        xAxis.drawGridLinesEnabled = false
        
        chart.legend.enabled = false
        
        setDataCount(dataSet: chartDataSet, onLineView: chart, withAnimation: shouldAnimate)
    }
    
    private func setDataCount(dataSet: ChartDataSet, onLineView lineView: LineChartView, withAnimation shouldAnimate: Bool) {
        let startingValue = ChartDataEntry(x: 0.0, y: dataSet.startY)

        let currentEnd = ChartDataEntry(x: dataSet.endX, y: dataSet.endY)
        let values = [startingValue, currentEnd]
        
        let set1 = LineChartDataSet(entries: values, label: nil)
        set1.drawIconsEnabled = false
        
        set1.lineDashLengths = [0, 0]
        set1.highlightLineDashLengths = [0, 0]
        set1.setColor(.darkBlue)
        set1.setCircleColor(.darkBlue)
        set1.valueTextColor = .clear
        set1.lineWidth = 1
        set1.circleRadius = 1
        set1.drawCircleHoleEnabled = false
        set1.valueFont = .systemFont(ofSize: 9)
        set1.formLineDashLengths = [0, 0]
        set1.formLineWidth = 1
        set1.formSize = 15
        
        let gradientColors = [UIColor.darkBlue.withAlphaComponent(0.5).cgColor, UIColor.darkBlue.cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set1.fillAlpha = 1
        set1.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)
        set1.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: set1)
        
        lineView.data = data
        
        if shouldAnimate {
            lineView.animate(xAxisDuration: 2.5)
        }
    }
}
