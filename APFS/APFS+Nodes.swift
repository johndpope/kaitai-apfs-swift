import Foundation
import KaitaiStream





//// node entries
class  NodeEntry:KaitaiStruct{
    var _parent: KaitaiStruct? // NOT USED
    
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var parent: Node?
    
    var  key_offset:Int = 0
    var key_length:UInt?
    var  data_offset:Int?
    var data_length:UInt?
    var _m_key_hdr:KeyHdr?
    var _m_key:Any?
    var _m_val:Any?
    
    init(_ _io:KaitaiStream,_ _parent:Node?,_ _root:KaitaiStruct?) {
        self._io = _io
        self._parent = _parent
        self.parent = _parent
        if  _root != nil{
            self._root = _root
        }else{
            self._root = self
        }
        self._read()
    }
    
    func _read(){
        
        self.key_offset = Int(self._io.readS2le()!)
        if (self.parent!.node_type! & 4) == 0{
            self.key_length = self._io.readU2le()
            self.data_offset = self._io.readS2le()
        }
        
        if (self.parent!.node_type! & 4) == 0{
            self.data_length = self._io.readU2le()
        }
        
    }
    
    var keyHdr:KeyHdr?{
        get{
            if let k = self._m_key_hdr{
                return k
            }
            
            let _pos = self._io.pos()
            let parentOffset = Int(bitPattern:self.parent!.keys_offset!)
            let offset = Int(self.key_offset + parentOffset + 56 )
            self._io.seek(offset)
            self._m_key_hdr = KeyHdr(self._io, self, self._root)
            self._io.seek(_pos)
            if let k = self._m_key_hdr{
                return k
            }
            
            return nil
        }
    }
    
    
    
    func key()->Any?{
        let _pos = self._io.pos()
        let parentOffset = Int(bitPattern:self.parent!.keys_offset!)
        let offset = Int(self.key_offset + parentOffset + 56 + 8)
        self._io.seek(offset)
        if let _kind = self.keyHdr?.kind_0{
            switch _kind{
            case .kind_lookup:
                self._m_key = LookupKey(self._io, self, self._root)
            case .kind_omap:
                self._m_key = OmapKey(self._io, self, self._root)
            case .kind_extent_refcount:
                self._m_key = EmptyKey(self._io, self, self._root)
            case .kind_sibling:
                self._m_key = SiblingKey(self._io, self, self._root)
            case .kind_sibling_map:
                self._m_key = SiblingKey(self._io, self, self._root)
            case .kind_extent:
                self._m_key = ExtentKey(self._io, self, self._root)
            case .kind_inode:
                self._m_key = EmptyKey(self._io, self, self._root)
            case .kind_drec:
                self._m_key = DrecKey(self._io, self, self._root)
                
            default:
                print("key not found")
                self._m_key = nil
            }
        }
        
        self._io.seek(_pos)
        return self._m_key
    }
    
    
    func val()->Any?{
        if self._m_val != nil{
            return _m_val
        }

        let  _pos = self._io.pos()
        let x = blockSize - Int(self.data_offset!) - 40 * Int(self.parent!.node_type! & 1)
        self._io.seek(x)
//        var _on
//        if( self.parent.level > 0){
//            _on = 256
//        }else{
//           _on =  self.key_hdr.kind.value
//        }
//
//        switch _kind{
//        case .kind_lookup:
//            self._m_key = LookupKey(self._io, self, self._root)
//        case .kind_omap:
//            self._m_key = OmapKey(self._io, self, self._root)
//        case .kind_extent_refcount:
//            self._m_key = EmptyKey(self._io, self, self._root)
//        case .kind_sibling:
//            self._m_key = SiblingVal(self._io, self, self._root)
//        case .kind_sibling_map:
//            self._m_key = SiblingKey(self._io, self, self._root)
//        case .kind_extent:
//            self._m_key = ExtentKey(self._io, self, self._root)
//        case .kind_inode:
//            self._m_key = EmptyKey(self._io, self, self._root)
//        case .kind_drec:
//            self._m_key = DrecKey(self._io, self, self._root)
//
//        default:
//            print("key not found")
//            self._m_key = nil
//        }

                self._io.seek(_pos)
                return self._m_val
    }
    
    
    
}

// node (type: 0x02)
class Node:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var node_type:UInt?
    var level:UInt? // Zero for leaf nodes, > 0 for index nodes
    var   entry_count:UInt?
    var unknown_40:UInt?
    var keys_offset:UInt?
    var keys_length:UInt?
    var data_offset:UInt?
    var unknown_48:UInt?// <format=hex>
    var entries:[NodeEntry]? //<optimize=false>
    
    init(_ _io:KaitaiStream,_ _parent:KaitaiStruct?,_ _root:KaitaiStruct?) {
        self._io = _io
        self._parent = _parent
        if  _root != nil{
            self._root = _root
        }else{
            self._root = self
        }
        self._read()
    }
    
    func _read(){
        node_type = self._io.readU2le()
        level = self._io.readU2le()
        entry_count = self._io.readU4le()
        unknown_40 = self._io.readU2le()
        keys_offset = self._io.readU2le()
        keys_length = self._io.readU2le()
        data_offset = self._io.readU2le()
        unknown_48 = self._io.readU8le()
        entries = []
        let x = Int(self.entry_count!)
        for _ in 0..<x{
            entries?.append(NodeEntry(self._io, self, self._root))
        }
    }
    
    
}



