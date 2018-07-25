import Foundation
import KaitaiStream


class  CheckpointEntry:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var type:objType?
    var flags:UInt? //ushort
    var subtype:objSubtype?
    var size:UInt?
    var unknown_52:UInt?
    var unknown_56:UInt?
    var unknown_60:UInt?
    var oid:UInt?
    var object:RefObj?
    
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
        if let typeInt = self._io.readU2le(){
            self.type = objType(rawValue:Int(typeInt))!
            self.flags = self._io.readU2le()
        }
        if let subTypeInt = self._io.readU4le(){
            self.subtype = objSubtype(rawValue:Int(subTypeInt))!
        }
        self.size = self._io.readU4le()
        self.unknown_52 = self._io.readU4le()
        self.unknown_56 = self._io.readU4le()
        self.unknown_60 = self._io.readU4le()
        self.oid = self._io.readU8le()
        
        self.object = RefObj(self._io, self, self._root)
    }
    // END

    //ref_obj  object //inlined
    //// BEGIN ref_obj
    /* local uint64 rpos = FTell()
     uint64 checkpoint_oid
     if (checkpoint_oid == 0)
     Printf("\n%s\n", "checkpoint_oid was 0 in obj_ref!! Not defining checkpoint!!")
     else if (SeekBlock(checkpoint_oid) != 0) // outside disk image!
     Printf("\n%s\n", "checkpoint_oid invalid in obj_ref!! Not defining checkpoint!!")
     else
     obj checkpoint
     FSeek(rpos + 8)
     //// END ref_obj*/
}

// checkpoint (type: 0x0c)
class  Checkpoint:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var   unknown_0:UInt?//  <format=hex>
    var    entry_count:UInt?
    //    if (entry_count)
    var entries:[CheckpointEntry] = [] // <optimize=false>
    
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

        self.unknown_0 = self._io.readU4le()
        self.entry_count = self._io.readU4le()
        let n = Int(bitPattern:self.entry_count!)
        for i in 0..<n {
              entries?[i] = CheckpointEntry(self._io, self, self._root)
        }

    }
 
    

}
