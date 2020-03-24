//
//  ActiveGoalCollectionViewCell.swift
//  Summit
//
//  Created by Reagan Wood on 3/23/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit
import Charts

// TODO: own class
class ActiveGoalCollectionViewCell: UICollectionViewCell {
    private let offsetTopAndBottom: CGFloat = 15.0
    private let offsetTitleToContent: CGFloat = 5.0
    private let offsetDescriptionToDifficulty: CGFloat = 10.0
    private let textContentPercentWidth: CGFloat = 0.65
    private let contentWidthPercentSeperation: CGFloat = 0.075
    
    private var cellWidth: CGFloat = 0
    
    private let minCellHeight: CGFloat = 150.0
    
    private let attemptTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .offWhite
        titleLabel.text = "Attempt"
        titleLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        return titleLabel
    }()
    
    private let attemptDescriptionLabel: UILabel = {
        let attemptDescription = UILabel()
        attemptDescription.textColor = .darkBlue
        attemptDescription.font = .systemFont(ofSize: 14.0, weight: .medium)
        attemptDescription.numberOfLines = 0
        attemptDescription.lineBreakMode = .byWordWrapping
        return attemptDescription
    }()
    
    private let difficultyLabel: UILabel = {
        let difficultyLabel = UILabel()
        difficultyLabel.textColor = .darkBlue
        difficultyLabel.font = .systemFont(ofSize: 14.0, weight: .bold)
        return difficultyLabel
    }()
    
    private let difficultyTitleLabel: UILabel = {
        let difficultyLabel = UILabel()
        difficultyLabel.textColor = .offWhite
        difficultyLabel.text = "Difficulty: "
        difficultyLabel.font = .systemFont(ofSize: 14.0, weight: .medium)
        return difficultyLabel
    }()
    
    private let lineViewChart: LineChartView = {
        let chartConfiguer = ChartConfigurer()
        var lineView = LineChartView()
        return lineView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeUI()
    }
    
    private func initializeUI() {
        backgroundColor = .objectBlack
        addAllSubviews([attemptTitleLabel, attemptDescriptionLabel, difficultyTitleLabel, difficultyLabel, lineViewChart])
        createConstraints()
        roundCorners()
    }
    
    private func roundCorners() {
        layer.cornerRadius = 10.0
    }
    
    private func createConstraints() {
        attemptTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(offsetTopAndBottom)
            make.top.equalToSuperview().inset(offsetTopAndBottom)
        }
        
        attemptDescriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(attemptTitleLabel.snp.bottom).offset(offsetTitleToContent)
            make.left.equalTo(attemptTitleLabel.snp.left)
            make.right.equalTo(lineViewChart.snp.left).inset(-10)
        }
        
        difficultyTitleLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(offsetTopAndBottom)
            make.left.equalTo(attemptTitleLabel.snp.left)
        }
        
        difficultyLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(difficultyTitleLabel.snp.centerY)
            make.left.equalTo(difficultyTitleLabel.snp.right).offset(offsetTitleToContent)
        }
        
        remakeLineViewConstraints()
    }
    
    private func remakeLineViewConstraints() {
        let graphPercentWidth = 1.0 - textContentPercentWidth - contentWidthPercentSeperation
        lineViewChart.snp.remakeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
            make.width.equalTo(cellWidth * graphPercentWidth)
            make.height.equalTo(lineViewChart.snp.width)
        }
    }
    
    public func set(attemptDescription attempt: String, andDifficultyTo difficulty: String, currentCompleted: Int, withCellWidth cellWidth: CGFloat) {
        self.cellWidth = cellWidth
        attemptDescriptionLabel.text = attempt
        difficultyLabel.text = difficulty
        let chartConfiguer = ChartConfigurer()
        let dataSet = ChartDataSet(title: "Days", minY: 0.0, maxY: 50.0, startY: 0.0, startX: 0.0, endY: 25.0, endX: 15.0, goalY: 35.0, lineColor: .darkBlue, labelColor: .offWhite)
        chartConfiguer.configureUserChart(chart: lineViewChart, chartDataSet: dataSet, withAnimation: false)
        
        remakeLineViewConstraints()
    }
    
    public func getHeightForCell(withWidthOf totalCellWidth: CGFloat) -> CGFloat {
        let textContentWidth = totalCellWidth * textContentPercentWidth
        
        let attemptHeight = attemptTitleLabel.text?.height(withWidth: textContentWidth, font: attemptTitleLabel.font) ?? 0.0
        let attemptDescriptionHeight = attemptDescriptionLabel.text?.height(withWidth: textContentWidth, font: attemptDescriptionLabel.font) ?? 0.0
        let difficultyTitleHeight = difficultyTitleLabel.text?.height(withWidth: textContentWidth, font: difficultyTitleLabel.font) ?? 0.0
        let difficultyLabelHeight = difficultyLabel.text?.height(withWidth: textContentWidth, font: difficultyLabel.font) ?? 0.0
        
        let contentOffsets = (offsetTopAndBottom * 2) + (offsetTitleToContent) + offsetDescriptionToDifficulty
        let labelHeights = attemptHeight + attemptDescriptionHeight + difficultyTitleHeight + difficultyLabelHeight
        
        let minWidthLabels = contentOffsets + labelHeights
        
        return max(minCellHeight, minWidthLabels)
    }
    
    override func prepareForReuse() {
        // TODO: prepare for that reuse
    }
}
