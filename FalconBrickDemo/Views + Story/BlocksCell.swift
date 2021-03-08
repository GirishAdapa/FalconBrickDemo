//
//  BlocksCell.swift
//  FalconBrickDemo
//
//  Created by Abhishek Singh on 07/03/21.
//  Copyright © 2021 Girish. All rights reserved.
//

import UIKit

class BlocksCell: UITableViewCell {
    static let reuseID = String(describing: BlocksCell.self)
    static let nib = UINib(nibName: String(describing: BlocksCell.reuseID.self), bundle: nil)

    @IBOutlet weak var towerSearchShowVW: UIView!
    @IBOutlet weak var unitsLbl: UILabel!
    @IBOutlet weak var floarNumLbl: UILabel!
    @IBOutlet weak var activityNameLbl: UILabel!
    @IBOutlet weak var stepNameLbl: UILabel!
    
    @IBOutlet weak var persentageLbl: UILabel!
    @IBOutlet weak var statusVW: UIView!
    @IBOutlet weak var showProgressBar: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func configureCell(blockListUnitData: BlocksModel.Units, blockListActivityObj: BlocksModel.Units.Activities){
        
          self.unitsLbl.text = "Unit A \(blockListUnitData.apt ?? "")"
          self.stepNameLbl.text = blockListActivityObj.step_name
          self.activityNameLbl.text = blockListActivityObj.activity_name
          self.statusVW.backgroundColor = blockListActivityObj.activity_status == "Active" ? .green : .red
          self.floarNumLbl.text = blockListUnitData.floor
        self.persentageLbl.text = "\(blockListActivityObj.progress)%"
        DispatchQueue.main.async {
            self.showProgressBar.setProgress(Float(blockListActivityObj.progress), animated: true)
        }
        
    }
    
}
