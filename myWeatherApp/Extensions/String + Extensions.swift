//
//  String + Extensions.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 14.03.2022.
//

import Foundation

extension String {
    var firstUppercased: String {
        let firstChar = self.first?.uppercased() ?? ""
        return firstChar + self.dropFirst()
    }
    
    func utf8EncodedString() -> String {
            let messageData = self.data(using: .nonLossyASCII)
            let text = String(data: messageData!, encoding: .utf8) ?? ""
        print(text)
            return text
        }
}

