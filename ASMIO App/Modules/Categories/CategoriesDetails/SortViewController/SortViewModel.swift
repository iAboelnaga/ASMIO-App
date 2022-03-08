//
//  SortViewModel.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import Foundation

enum SortOptions: String {
    case popularity = "Popularity"
    case highToLow = "Price: High to Low"
    case lowToHigh = "Price: Low to High"
}

class SortViewModel: NSObject {
    let sortOptions: [SortOptions] = [.popularity, .highToLow, .lowToHigh]
    var selectedOption = SortOptions.popularity
}
