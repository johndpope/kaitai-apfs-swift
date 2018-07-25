import Foundation
import KaitaiStream


//globals
let  apfsOffset:UInt? = 0 // <---- Set this to wherever your APFS container starts
let  blockSize:Int = 4096 //default, we set this to actual later
let  followPointer = true
let  currentBlockOffset:UInt? = 0


//    """Universal type to address a block: it both parses one u8-sized
//    block address and provides a lazy instance to parse that block
//    right away.
//    """
class Apfs:KaitaiStruct{
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var _raw_block0:Data?
    var block0:Obj?
    
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
        if let data = self._io.readBytes(4096)?.data{
            self._raw_block0 = data
            let io = KaitaiStream(data: data)
            self.block0 = Obj(io, self, self._root)
        }
    }
    
}

// container_superblock (type: 0x01)
class  ContainerSuperblock:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var pos:UInt?
    var magic:String? // NXSB
    var block_size:UInt?
    var block_count:UInt?
    var features_0:UInt?
    var read_only_compatible_features:UInt?
    var incompatible_features:UInt?
    var uuid:[UInt8]?
    var next_oid:UInt?
    var next_xid:UInt?
    var xp_desc_blocks:UInt?
    var xp_data_blocks:UInt?
    var xp_desc_base:UInt?
    var xp_data_base:UInt?
    var xp_desc_len:UInt?
    var xp_data_len:UInt?
    var xp_desc_index:UInt?
    var xp_desc_index_len:UInt?
    var xp_data_index:UInt?
    var xp_data_index_len:UInt?
    var spaceman_oid:UInt?
    var omap_oid:RefObj?
    var reaper_oid:UInt?
    var pad2:UInt?
    var max_file_systems:UInt?
    var fs_oids:[UInt]?
    
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
       
//        self.magic = self._io.ensureFixedContents("x4E\x58\x53\x42") - TODO FIX
        self.block_size = self._io.readU4le()
        self.block_count = self._io.readU8le()
        self.features_0 = self._io.readU8le()
        self.read_only_compatible_features = self._io.readU8le()
        self.incompatible_features = self._io.readU8le()
        self.uuid = self._io.readBytes(16)
        self.next_oid = self._io.readU8le()
        self.next_xid = self._io.readU8le()
        self.xp_desc_blocks = self._io.readU4le()
        self.xp_data_blocks = self._io.readU4le()
        self.xp_desc_base = self._io.readU8le()
        self.xp_data_base = self._io.readU8le()
        self.xp_desc_len = self._io.readU4le()
        self.xp_data_len = self._io.readU4le()
        self.xp_desc_index = self._io.readU4le()
        self.xp_desc_index_len = self._io.readU4le()
        self.xp_data_index = self._io.readU4le()
        self.xp_data_index_len = self._io.readU4le()
        self.spaceman_oid = self._io.readU8le()
        self.omap_oid = RefObj(self._io, self, self._root)
        self.reaper_oid = self._io.readU8le()
        self.pad2 = self._io.readU4le()
        self.max_file_systems = self._io.readU4le()
//        self.fs_oids = [None] * (self.max_file_systems)
        let n = Int(self.max_file_systems!)
        
        for _ in 0..<n{
            fs_oids?.append(self._io.readU8le()!)
        }
     
    }
    // END

    
}




// btree (type: 0x0b)
class  Btree:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var btree_type:treeType?
    var    unknown_0:[UInt8]?// <format=hex>
    var root:RefObj?
    
    
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
 
        let x = Int(bitPattern: self._io.readU8le()!)
        btree_type = treeType(rawValue:x)
        unknown_0 = self._io.readBytes(8)
        root = RefObj(self._io, self, self._root)
    }
    // END
    

}



