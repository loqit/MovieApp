import Foundation

enum RequestError: Error {

    case clientError
    case serverError
    case noData
    case dataDecodingError
}
