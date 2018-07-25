import Foundation
import KaitaiStream

class  obj :KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var hdr:obj_header?
    
    init(_io:KaitaiStream,_parent:KaitaiStruct?,_root:KaitaiStruct?) {
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
        //        self.hdr = self._root.ObjHeader(self._io, self, self._root)
        //        _on = self.hdr.type
        //        if let _on == self._root.ObjType.container_superblock{
        //
        //        }
        //        self.body = self._root.ContainerSuperblock(self._io, self, self._root)
        //        elif _on == self._root.ObjType.spaceman_internal_pool:
        //        self.body = self._root.SpacemanInternalPool(self._io, self, self._root)
        //        elif _on == self._root.ObjType.space_manager:
        //        self.body = self._root.SpaceManager(self._io, self, self._root)
        //        elif _on == self._root.ObjType.rootnode:
        //        self.body = self._root.Node(self._io, self, self._root)
        //        elif _on == self._root.ObjType.node:
        //        self.body = self._root.Node(self._io, self, self._root)
        //        elif _on == self._root.ObjType.checkpoint:
        //        self.body = self._root.Checkpoint(self._io, self, self._root)
        //        elif _on == self._root.ObjType.btree:
        //        self.body = self._root.Btree(self._io, self, self._root)
        //        elif _on == self._root.ObjType.volume_superblock:
        //        self.body = self._root.VolumeSuperblock(self._io, self, self._root)
        
    }
    
}

class  obj_header:KaitaiStruct {
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var cksum:UInt? // Flechters checksum, according to the docs.
    var oid:UInt?   // ID of the obj itself. Either the position of the obj or an incrementing number starting at 1024.
    var xid:UInt?   // Incrementing version number of the xid of the obj (highest == latest)
    var type:Apfs.objType
    var  flags:UInt? // <format=hex> // 0x4000 oid = position, 0x8000 = container
    var subtype:Apfs.objSubtype // enum: obj_subtype
    var pad:UInt?
    
    init(_io:KaitaiStream,_parent:KaitaiStruct?,_root:KaitaiStruct?) {
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
        self.type = Apfs.objType(rawValue:Int(self._io.readU2le()!))! // TODO - revisit this
        self.flags = self._io.readU2le()
        self.subtype = Apfs.objSubtype(rawValue:Int(self._io.readU2le()!))!
        self.pad = self._io.readU2le()
    }
    
    
}
