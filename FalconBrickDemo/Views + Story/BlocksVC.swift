//
//  ViewController.swift
//  FalconBrickDemo
//
//  Created by Abhishek Singh on 06/03/21.
//  Copyright © 2021 Girish. All rights reserved.
//

import UIKit

class BlocksVC: UIViewController {
    
    @IBOutlet weak var blocksTbl: UITableView!
    @IBOutlet weak var tabsScrlVW: UIScrollView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var bottomBorderVW: UIView!
    
    let Font =  UIFont.systemFont(ofSize: 14.0)
    var widthObj = CGFloat()
    private var blockListRespData: [BlocksModel]?
    private var blockListTempData: [BlocksModel.Units] = []
    private var fstTimeLoad = false
    var actiVityObserverInt = -1
    var actualObjIndex = [Int]()
    var appendActivities = [BlocksModel.Units.Activities]()
    var tblActivities = [BlocksModel.Units.Activities]()

       
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.searchBar.searchBarCustomize(colour: .clear)
        self.fetchBlocks()
        
    }
    
}

extension BlocksVC{
    func fetchBlocks(){
       let req = BlockRequest(decodeTyepeModel: [BlocksModel].self, bundleIdentifier: "Blocks.json")
       let res = Bundle.main.decode(req.decodeTyepeModel, from: req.bundleIdentifier)
        //print(res)
        self.blockListRespData = res
        //self.blockListTempData = res
       
        self.setupBlocks()
        
    }
}
//Mark: setup blocks
extension BlocksVC{
    func setupBlocks(){
        var btnNames:[String] = [] // "Tower A","Tower B", "Tower C", "Tower D", "Tower E","Tower F", "Tower G"
        btnNames.append("All")
        for item in self.blockListRespData ?? []{
            widthObj = item.block_name.SizeOf_String(font: Font).width + widthObj
            btnNames.append(item.block_name)
        }
        let codeSegmented = CustomTabsSegControl(frame: CGRect(x: 0, y: 0, width: widthObj + 200, height: 60), buttonTitle: btnNames)
               codeSegmented.backgroundColor = .clear
             codeSegmented.delegate = self
               tabsScrlVW.addSubview(codeSegmented)
               tabsScrlVW.contentSize = CGSize( width: codeSegmented.frame.width + 10, height: tabsScrlVW.frame.size.height)
        self.itterateandFindSearchedOrFirstTimeItems(searchText: "", noSearchingEffect: "All data show")
    }
}

//Mark:- Load Blocks
extension BlocksVC{
    func loadBlocks(){
        DispatchQueue.main.async {
            if self.fstTimeLoad == false{
            self.blocksTbl.register(BlocksCell.nib, forCellReuseIdentifier: BlocksCell.reuseID)
               self.blocksTbl.dataSource = self
                self.searchBar.delegate = self
               self.fstTimeLoad = true
            }
            self.blocksTbl.reloadData()
        }
    }
}

//Mark:- Table Delrgates
extension BlocksVC: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tblActivities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = tableView.dequeueReusableCell(withIdentifier: "BlocksCell", for: indexPath) as? BlocksCell
        
       self.blockListTempData.compactMap({ unitObj in
       
        cel?.configureCell(blockListUnitData: unitObj, blockListActivityObj: tblActivities[indexPath.row])
        })
        
        
        //cel?.configureCell(blockListTempData: self.blockListTempData)
        return cel!
    }
}

extension BlocksVC: CustomSegmentedControlDelegate{
    func selectedTabDetails(to index:Int, title: String) {
       // print(title)
        blockListTempData.removeAll()
        // selectedBlockDataPrepare(basedOnSelectedTabTitle: title)
    }

}

//Mark:- Search
extension BlocksVC:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.itterateandFindSearchedOrFirstTimeItems(searchText: searchText, noSearchingEffect: "")

    }
    
    func itterateandFindSearchedOrFirstTimeItems(searchText: String, noSearchingEffect: String){
//Mark:-Clear Items
       actiVityObserverInt = -1
       blockListTempData.removeAll()
       self.appendActivities.removeAll()
        tblActivities.removeAll()
        if noSearchingEffect == "" && searchText != ""{
// Mark:- Title
            let unitTitleObj = blockListRespData?.enumerated().compactMap{ mainIndex, obj in
                             obj.units?.filter{ obj1 in
                                   actiVityObserverInt = mainIndex
                                  return (obj1.title?.lowercased().contains(searchText.lowercased()))!
                             }
                         }
              unitTitleObj?.compactMap{ obj in
                  for unitFilterVal in obj{
                     // print(unitFilterVal.title)
                      let appendUnits = BlocksModel.Units(title: unitFilterVal.title, apt: unitFilterVal.apt, floor: unitFilterVal.floor, activities: unitFilterVal.activities)
                      blockListTempData.append(appendUnits)
                  }
              }
                //  print("TitleSearch:\(unitTitleObj)")
// Mark:- Step Name OR Activity Name
                  let activityStepOrNameOrObj = blockListRespData?.enumerated().compactMap{ mainIndex, obj in
                      obj.units?.compactMap{ obj1 in
                          obj1.activities?.enumerated().filter{  obj2 in
                             // print(obj2)
                              actiVityObserverInt = mainIndex
                              //actualObjIndex = [thirdIndex]
                             // print("indexMain:\(mainIndex)")
                              return (obj2.element.step_name?.lowercased().contains(searchText.lowercased()))! || (obj2.element.activity_name?.lowercased().contains(searchText.lowercased()))!
                          }
                      }
                  }
                  
                  
                  //print("Activities:\(self.appendActivities)")
                  if (unitTitleObj?[0].count)! == 0 && (unitTitleObj?[1].count)! == 0{
                      
                      for activityObj in activityStepOrNameOrObj!{
                          for actItem in activityObj{
                              for actItemObj in actItem{
                                  let appendActivitiItem = BlocksModel.Units.Activities(activity_name: actItemObj.element.activity_name, activity_status: actItemObj.element.activity_status, step_name: actItemObj.element.step_name, progress: actItemObj.element.progress)
                                  self.appendActivities.append(appendActivitiItem)
                              }
                          }
                      }
                      
                      if let mainVal = blockListRespData?[actiVityObserverInt].units{
                          
                              let appendUnits = BlocksModel.Units(title: mainVal[0].title, apt: mainVal[0].apt, floor: mainVal[0].floor, activities: self.appendActivities)
                              blockListTempData.append(appendUnits)
                      }
                      // print("Activities&Units:\(self.blockListTempData)")
                  }
                  
        }else{
            print("Show All Data")
            
            for data in blockListRespData!{
                for unitsObj in data.units!{
                   // for activityItem in unitsObj
                    
                    let appendUnits = BlocksModel.Units(title: unitsObj.title, apt: unitsObj.apt, floor:unitsObj.floor, activities:
                        unitsObj.activities)
                    self.blockListTempData.append(appendUnits)
                }
            }
            
        }
        self.blockListTempData.compactMap({ unitObj in
           unitObj.activities.flatMap{ $0.compactMap{ activity in
                  tblActivities.append(activity)
                }}
        })
        print(tblActivities)
        self.loadBlocks()
    }
}
