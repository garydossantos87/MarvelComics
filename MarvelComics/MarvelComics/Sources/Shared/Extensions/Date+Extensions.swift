import Foundation

extension Date {
    static func fromString(
        _ dateString: String,
        format: String = "yyyy-MM-dd'T'HH:mm:ssZ"
    ) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateString)
    }
    
    func toString(with format: String = "dd/MM/yyyy") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
