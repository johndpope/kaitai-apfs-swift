import Foundation
import KaitaiStream

class  InodeVal:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
    var parent_id:UInt?
    var extents_id:UInt?
    var  creation_timestamp:UInt? //<read=ApfsTimeRead>
    var  modified_timestamp:UInt? //<read=ApfsTimeRead>
    var  changed_timestamp:UInt? // <read=ApfsTimeRead>
    var  accessed_timestamp:UInt?// <read=ApfsTimeRead>
    var  flags:UInt?
    var  nchildren_or_nlink:UInt?
    var    unknown_60:UInt?
    var    unknown_64:UInt?
    var    bsdflags:UInt?
    var    owner_id:UInt?
    var    group_id:UInt?
    var  mode:UInt?// <format=octal>
    var  unknown_82:UInt?
    var    unknown_84:UInt?
    var    unknown_88:UInt?
    var  xf_num_exts:UInt? // File 0x02 or Folder 0x01 cmp. TN1150
    var  xf_used_data:UInt?
    var xf_header:[XfHeader]?
    var  xf_hdr:[XfHeader]?
    var   local_index:UInt?
//    var _raw_xf:
    
    
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
        
        self.parent_id = self._io.readU8le()
        self.extents_id = self._io.readU8le()
        self.creation_timestamp = self._io.readU8le()
        self.modified_timestamp = self._io.readU8le()
        self.changed_timestamp = self._io.readU8le()
        self.accessed_timestamp = self._io.readU8le()
        self.flags = self._io.readU8le()
        self.nchildren_or_nlink = self._io.readU4le()
        self.unknown_60 = self._io.readU4le()
        self.unknown_64 = self._io.readU4le()
        self.bsdflags = self._io.readU4le()
        self.owner_id = self._io.readU4le()
        self.group_id = self._io.readU4le()
        self.mode = self._io.readU2le()
        self.unknown_82 = self._io.readU2le()
        self.unknown_84 = self._io.readU4le()
        self.unknown_88 = self._io.readU4le()
        self.xf_num_exts = self._io.readU2le()
        self.xf_used_data = self._io.readU2le()
        self.xf_header = []
        let n = Int(self.xf_num_exts!)
        for _ in 0..<n{
            self.xf_header?.append(XfHeader.init(self._io, self, self._root))
        }

        print("TODO - xf.i")
//        self._raw_xf = [None] * (self.xf_num_exts)
//        self.xf = [None] * (self.xf_num_exts)
//        for i in range(self.xf_num_exts):
//        _on = self.xf_header[i].type
//        if _on == self._root.XfieldType.size:
//        self._raw_xf[i] = self._io.read_bytes((self.xf_header[i].length + ((8 - self.xf_header[i].length) % 8)))
//        io = KaitaiStream(BytesIO(self._raw_xf[i]))
//        self.xf[i] = self._root.XfSize(io, self, self._root)
//        elif _on == self._root.XfieldType.device_node:
//        self._raw_xf[i] = self._io.read_bytes((self.xf_header[i].length + ((8 - self.xf_header[i].length) % 8)))
//        io = KaitaiStream(BytesIO(self._raw_xf[i]))
//        self.xf[i] = self._root.XfDeviceNode(io, self, self._root)
//        elif _on == self._root.XfieldType.name:
//        self._raw_xf[i] = self._io.read_bytes((self.xf_header[i].length + ((8 - self.xf_header[i].length) % 8)))
//        io = KaitaiStream(BytesIO(self._raw_xf[i]))
//        self.xf[i] = self._root.XfName(io, self, self._root)
//        elif _on == self._root.XfieldType.sparse_size:
//        self._raw_xf[i] = self._io.read_bytes((self.xf_header[i].length + ((8 - self.xf_header[i].length) % 8)))
//        io = KaitaiStream(BytesIO(self._raw_xf[i]))
//        self.xf[i] = self._root.XfSparseSize(io, self, self._root)
//        else:
//        self.xf[i] = self._io.read_bytes((self.xf_header[i].length + ((8 - self.xf_header[i].length) % 8)))

    }


}

class  SiblingVal:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    // 0x50
    var node_id:UInt?
    var length:ushort?
    var  name:String? //char [length]
    
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
        print("override")
    }
    // END
    
}

class  ExtentRefcountVal:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
        print("override")
    }
    // END
    // 0x60
    var count:UInt?
}

class  LookupVal:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var   block_count:UInt?
    var unknown_4:ushort?
    var block_size:ushort?
    var inode:UInt?
    var   unknown_16:UInt?
    
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
        print("override")
    }
    // END

    
}

class  extent_val:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var len:UInt?
    var phys_block_num:UInt? //error in ksy  spec, this is NOT ref_obj
    var flags:UInt?
    
    
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
        print("override")
    }
    // END


}

class  DrecVal:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var node_id:UInt?
    var timestamp:UInt?// <read=ApfsTimeRead>
    var type_item:itemType?
    
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
        print("override")
    }
    // END


}

class  SiblingMapVal:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
        print("override")
    }
    // END
    // 0xc0
    var map_node_id:UInt?
}

class  XattrVal :KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var type:eaType?
    var  data_length:ushort?
    
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
        print("override")
    }

}



class  PointerVal:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
        print("override")
    }
    // END
    
}

class  HistoryVal:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var unknown_0:UInt?
    var unknown_4:UInt?
    
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
        print("override")
    }
    // END
}

class  OmapVal:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var flags:UInt?
    var size:UInt?
    
    
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
        print("override")
    }
    // END


    
}

