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

        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }

        return nil
    }
}

