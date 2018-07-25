import Foundation


extension Data {
    var bytes : [UInt8]{
        return [UInt8](self)
    }
}
//[bytes] to Data

extension Array where Element == UInt8 {
    var data : Data{
        return Data(bytes:(self))
    }
}
