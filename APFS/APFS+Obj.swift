import Foundation
import KaitaiStream



class  RefObj:KaitaiStruct{
    
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var val:UInt?
    
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
        self.val = self._io.readU8le()
    }
    
    func  target()->KaitaiStruct?{
        //if hasattr(self, '_m_target'):
        //        //return self._m_target if hasattr(self, '_m_target') else None
        //
        //        io = self._root._io
        //        _pos = io.pos()
        //        io.seek((self.val * self._root.block_size))
        //        self._raw__m_target = io.read_bytes(self._root.block_size)
        //        io = KaitaiStream(BytesIO(self._raw__m_target))
        //        self._m_target = self._root.Obj(io, self, self._root)
        //        io.seek(_pos)
        //        return self._m_target if hasattr(self, '_m_target') else None
        return nil
    }
    
}

class  Obj :KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var hdr:ObjHeader?
    var _on:objType?
    var body:AnyObject?
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

        self.hdr = ObjHeader(self._io, self, self._root)
        _on = self.hdr?.type
        switch _on!{
        case .obj_type_container_superblock:
            self.body = ContainerSuperblock(self._io, self, self._root)
        case .obj_type_space_manager:
            self.body = SpaceManager(self._io, self, self._root)
        case .obj_type_rootnode:
            self.body = Node(self._io, self, self._root)
        case .obj_type_node:
            self.body = Node(self._io, self, self._root)
        case .obj_type_checkpoint:
            self.body = Checkpoint(self._io, self, self._root)
        case .obj_type_btree:
            self.body = Btree(self._io, self, self._root)
        case .obj_type_volume_superblock:
            self.body = VolumeSuperblock(self._io, self, self._root)

        default:
            self.body = nil
        }
    }
    
}

class  ObjHeader:KaitaiStruct {
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var cksum:UInt? // Flechters checksum, according to the docs.
    var oid:UInt?   // ID of the obj itself. Either the position of the obj or an incrementing number starting at 1024.
    var xid:UInt?   // Incrementing version number of the xid of the obj (highest == latest)
    var type:objType?
    var  flags:UInt? // <format=hex> // 0x4000 oid = position, 0x8000 = container
    var subtype:objSubtype? // enum: obj_subtype
    var pad:UInt?
    
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
        self.cksum = self._io.readU8le()
        self.oid = self._io.readU8le()
        self.xid = self._io.readU8le()
        self.type = objType(rawValue:Int(self._io.readU2le()!))! // TODO - revisit this
        self.flags = self._io.readU2le()
        self.subtype = objSubtype(rawValue:Int(self._io.readU2le()!))!
        self.pad = self._io.readU2le()
    }
    
    
}
