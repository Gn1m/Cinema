//
//  BarCodeGenerator.swift
//  Cinema
//
//  Created by Ming Z on 16/5/2024.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

class BarcodeGenerator {
    private let context = CIContext()
    private let filter = CIFilter.code128BarcodeGenerator()

    func generateBarcode(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        guard let outputImage = filter.outputImage else {
            return nil
        }

        let scaleX = 3.0
        let scaleY = 3.0
        let transformedImage = outputImage.transformed(by: CGAffineTransform(scaleX: CGFloat(scaleX), y: CGFloat(scaleY)))

        if let cgImage = context.createCGImage(transformedImage, from: transformedImage.extent) {
            return UIImage(cgImage: cgImage)
        }

        return nil
    }
}
