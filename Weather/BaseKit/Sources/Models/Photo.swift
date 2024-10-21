//
//  File.swift
//  
//
//  Created by hanjongwoo on 8/8/24.
//

import UIKit

public struct Photo: Identifiable, Equatable, Sendable {
    public let id: String
    public let image: UIImage
    public let title: String?
    public let dateTaken: Date?
    
    public init(id: String, image: UIImage, title: String?, dateTaken: Date?) {
        self.id = id
        self.image = image
        self.title = title
        self.dateTaken = dateTaken
    }
    
    public static let dummyData: Self = .init(
        id: "12345",
        image: UIImage(systemName: "plus")!,
        title: "dummyTitle",
        dateTaken: Date()
    )
    
    public static let empty: Self = .init(
        id: "",
        image: UIImage(systemName: "plus")!,
        title: nil,
        dateTaken: nil
    )
}
