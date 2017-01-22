//
//  EntityApp.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/21/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import ObjectMapper

class EntityApp: Mappable {
    
    // --------------------------------------------------
    // Data
    // --------------------------------------------------
    var name:        String?
    var imageUrl:    String?
    var summary:     String?
    var price:       Double?
    var currency:    String?
    var contentType: String?
    var copyright:   String?
    var longName:    String?
    var itunesLink:  String?
    var itunesId:    String?
    var bundleId:    String?
    var artistName:  String?
    var artistLink:  String?
    var releaseDate: String?
    var category:    EntityCategory?
    
    
    // --------------------------------------------------
    // Json Parsing
    // --------------------------------------------------
    
    // Keys
    private let nameKey        = "name.label"
    private let imageUrlKey    = "image.2.label"
    private let summaryKey     = "summary.label"
    private let priceKey       = "price.attributes.amount"
    private let currencyKey    = "price.attributes.currency"
    private let contentTypeKey = "contentType.attributes.label"
    private let copyrightKey   = "rights.label"
    private let longNameKey    = "title.label"
    private let itunesLinkKey  = "link.attributes.href"
    private let itunesIdKey    = "id.attributes.id"
    private let bundleIdKey    = "id.attributes.bundleId"
    private let artistNameKey  = "artist.label"
    private let artistLinkKey  = "artist.attributes.href"
    private let releaseDateKey = "releaseDate.attributes.label"
    private let categoryKey    = "category.attributes"
    
    func mapping(map: Map) {
        
        // Deserialize the fields
        name        <- map[nameKey]
        imageUrl    <- map[imageUrlKey]
        summary     <- map[summaryKey]
        price       <- map[priceKey]
        currency    <- map[currencyKey]
        contentType <- map[contentTypeKey]
        copyright   <- map[copyrightKey]
        longName    <- map[longNameKey]
        itunesLink  <- map[itunesLinkKey]
        itunesId    <- map[itunesIdKey]
        bundleId    <- map[bundleIdKey]
        artistName  <- map[artistNameKey]
        artistLink  <- map[artistLinkKey]
        releaseDate <- map[releaseDateKey]
        category    <- map[categoryKey]
    }
    
    required init?(_ map: Map) {}
}
