//
//  UserDefaults_EXT.swift
//  WatsonAshtonCE09
//
//  Created by Ashton Watson on 9/24/20.
//

import Foundation
import UIKit

extension UserDefaults{
    
    
    func set(color: UIColor, forKey key: String){
        
        do{
            
            
            let binaryData = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false)
            self.set(binaryData, forKey:  key)
      
        }
        catch{
            
        }
    }
    
    
    
    
    
    
     func color(forKey key: String) -> UIColor?{
               
               //Check for vaild dat
               if let binaryData = data(forKey: key){
                   
                   do{
                       
                       if let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(binaryData) as? UIColor{
                       
                       return color
                   }
                   }
                   catch{
                       
                   //is that data a uicolor
                  
                   }
               }
               return nil
           }
    
    
    
}
