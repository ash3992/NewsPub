//
//  Article.swift
//  WatsonAshtonCE09
//
//  Created by Ashton Watson on 9/22/20.
//

import Foundation
import UIKit
class Article{
    
    var author : String
    var title: String
    var description: String
    var url: String
    var image: UIImage!
    var date: String
    
    
    
    init(author: String, title: String, description: String, url: String, image: String, date: String){
        
        
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        
        if let pictureUrl = URL(string: image){
            
            
            do{
                let data = try Data(contentsOf: pictureUrl)
                self.image = UIImage(data: data)
            }catch{
                print(error.localizedDescription)
            }
        }
        
        
        self.date = date
        
    }
    
    
}
