//
//  Extensions.swift
//  AudioRecorder
//
//  Created by Alexander Zwerner on 1/7/21.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
