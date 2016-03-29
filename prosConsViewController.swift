
import UIKit

class prosConsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var prosTableView: UITableView!
    @IBOutlet var consTableView: UITableView!
    
    var colleges = [NetCollege]()
    var collegesTwo = [NetCollegeTwo]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        editButtonItem().tag = 0
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == prosTableView
        {
            return colleges.count
        }
        else
        {
            return collegesTwo.count
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if tableView == prosTableView
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
            cell.textLabel?.text = colleges[indexPath.row].name
            
            return cell
        }
        else
        {
            let cellTwo = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
            cellTwo.textLabel?.text = collegesTwo[indexPath.row].conName
            
           return cellTwo

        }
    }

    @IBAction func plusButtonTwo(sender: UIBarButtonItem)
    {
        let alertTwo = UIAlertController(title: "Add Con", message: nil, preferredStyle: .Alert)
                alertTwo.addTextFieldWithConfigurationHandler
                    { (textField) -> Void in
                        textField.placeholder = "Add Con Here"
                }
                let cancelActionTwo = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
                alertTwo.addAction(cancelActionTwo)
    
        
                let addActionTwo = UIAlertAction(title: "Add", style: .Default) { (action) -> Void in
                    let addCollegesTextFieldTwo = (alertTwo.textFields?[0])! as UITextField
        
                    let netCollegeTwo = NetCollegeTwo(NameTwo: "\(addCollegesTextFieldTwo.text!)")
        
                    self.collegesTwo.append(netCollegeTwo)
                    self.consTableView.reloadData()
                }
                alertTwo.addAction(addActionTwo)
                self.presentViewController(alertTwo, animated: true, completion: nil)
    }
    
    @IBAction func onTappedPlusButton(sender: UIBarButtonItem)
    {
        let alert = UIAlertController(title: "Add Pro", message: nil, preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler
            { (textField) -> Void in
            textField.placeholder = "Add Pro Here"
            }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(cancelAction)
        
        
        let addAction = UIAlertAction(title: "Add", style: .Default) { (action) -> Void in
            let addCollegesTextField = (alert.textFields?[0])! as UITextField
            
            let netCollege = NetCollege(Name: "\(addCollegesTextField.text!)")
            
            self.colleges.append(netCollege)
            self.prosTableView.reloadData()
        }
        alert.addAction(addAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            if tableView == prosTableView
            {
                colleges.removeAtIndex(indexPath.row)
                tableView.reloadData()
            }
            else
            {
                collegesTwo.removeAtIndex(indexPath.row)
                tableView.reloadData()
            }
        }
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath)
    {
        let college = colleges[sourceIndexPath.row]
        colleges.removeAtIndex(sourceIndexPath.row)
        colleges.insert(college, atIndex: destinationIndexPath.row)
    }

}