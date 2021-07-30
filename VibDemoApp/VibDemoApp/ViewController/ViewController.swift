//
//  ViewController.swift
//  VibDemoApp
//
//  Created by MYGENOMEBOX INDIA on 30/07/21.
//

import UIKit

class ViewController: UIViewController,MyDataSendingDelegate {
   
// Mark : IBOutLets
    
    @IBOutlet weak var lblNoData: UILabel!
  
    @IBOutlet weak var tblView: UITableView!
    
    //Mark: Properties and variable
    
    var UserArray = [UserModel]()
    
    //Mark : ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func sendDataToFirstViewController(myData: [UserModel]) {
        self.UserArray = myData
        self.UpdatedataSource()
       
    }
    
    //Mark: Btn Add Tapped
    
    @IBAction func btnAddTapped(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        vc.delegate =  self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//Mark : Data Source
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return UserArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        
        cell.img_View.image = UserArray[indexPath.row].userImage
        cell.lblName.text = UserArray[indexPath.row].username
        cell.lblLocation.text = UserArray[indexPath.row].userLoacation
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBtnAction(_:)))
        cell.btnRemove.tag = indexPath.row
        cell.btnRemove.addGestureRecognizer(tapGesture)
        
        return cell
    }
    
    func UpdatedataSource(){
        if UserArray.count > 0{
            self.lblNoData.isHidden = true
        }else{
            self.lblNoData.isHidden = false
        }
        self.tblView.reloadData()
    }
    //Mark : Remove data on tap
    @objc func tapBtnAction(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        
        self.UserArray.remove(at: index)
        self.UpdatedataSource()
       
    }

}



