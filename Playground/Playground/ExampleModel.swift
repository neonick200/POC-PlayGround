import Foundation

public struct ExampleModel: Codable {
  public let status: Status
  public var data: DataClass
  
  public init(status: Status, data: DataClass) {
    self.status = status
    self.data = data
  }
}

public struct DataClass: Codable {
  public var foundation: [Foundation]
  
  enum CodingKeys: String, CodingKey {
    case foundation = "Foundation"
  }
  
  public init(foundation: [Foundation]) {
    self.foundation = foundation
  }
}

public struct Foundation: Codable {
  public let name, key: String
  
  public init(name: String, key: String) {
    self.name = name
    self.key = key
  }
}

public struct Status: Codable {
  public let code: Int
  public let statusDescription, header: String
  
  enum CodingKeys: String, CodingKey {
    case code
    case statusDescription = "description"
    case header
  }
  
  public init(code: Int, statusDescription: String, header: String) {
    self.code = code
    self.statusDescription = statusDescription
    self.header = header
  }
}
