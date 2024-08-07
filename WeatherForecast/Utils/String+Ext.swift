//
//  String+Ext.swift
//  WeatherForecast
//
//  Created by httruc on 7/8/24.
//

import UIKit

extension String {
    func estimateHeight(for font: UIFont, width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

        return ceil(boundingBox.height)
    }
}

final class AttributedStringBuilder {
    public typealias Attributes = [NSAttributedString.Key: Any]

    private let string: NSMutableAttributedString

    init() {
        string = NSMutableAttributedString()
    }

    @discardableResult
    func append(_ text: String,
                       attributes: Attributes) -> AttributedStringBuilder {
        let addedString = NSAttributedString(string: text, attributes: attributes)
        string.append(addedString)
        return self
    }

    func build() -> NSAttributedString {
        NSAttributedString(attributedString: string)
    }
}
