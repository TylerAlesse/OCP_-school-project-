//
//  tableViewTableViewCell.swift
//  collegeBuilder
//
//  Created by entre on 10/27/15.
//  Copyright (c) 2015 PHS. All rights reserved.
//

import UIKit

class tableViewTableViewCell: UITableViewCell
{
    

    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        
    }
    var checked = [Bool]() // Have an array equal to the number of cells in your table
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("tableViewTableViewCell") as! UITableViewCell
        
        //configure you cell here.
        
        if checked[indexPath.row] == false
        {
            
            cell.accessoryType = .None
        }
        else if checked[indexPath.row] == true
        {
            
            cell.accessoryType = .Checkmark
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if let cell = tableView.cellForRowAtIndexPath(indexPath)
        {
            if cell.accessoryType == .Checkmark
            {
                cell.accessoryType = .None
                checked[indexPath.row] = false
            }
            else
            {
                cell.accessoryType = .Checkmark
                checked[indexPath.row] = true
            }
        }    
    }
    
}