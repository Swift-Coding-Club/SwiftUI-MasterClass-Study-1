//
//  PageModel.swift
//  Pinch
//
//  Created by Subeen on 2023/07/29.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
    
}

extension Page {
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
