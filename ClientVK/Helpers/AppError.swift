//
//  AppError.swift
//  ClientVK
//
//  Created by Denis Molkov on 17.06.2021.
//

import Foundation

enum AppError: Error {
    case noDataProvided
    case failedToDecode
    case noDataSave
}
