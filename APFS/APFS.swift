import Foundation
import KaitaiStream


//globals
let  apfs_Offset:UInt? = 0 // <---- Set this to wherever your APFS container starts
let  block_Size:UInt? = 4096 //default, we set this to actual later
let  follow_Pointer = true
let  current_Block_Offset:UInt? = 0


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


//// node entry keys
class  KeyHdr:KaitaiStruct{
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

    var obj_id:UInt? = 60
    var kind_0:UInt? = 04 //<read=ReadKind>
}



//// node entries
class  NodeEntry:KaitaiStruct{
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
    //    local uint64 pos = FTell()
    var  key_offset:short?
   // if ((parentof(this).node_type & 4) == 0)
    var key_length:ushort?
    var  data_offset:short?
//    if ((parentof(this).node_type & 4) == 0)
    var data_length:ushort?
//    local uint64 pos2 = FTell()
    
//    FSeek(parentof(parentof(this)).obj_start_off + key_offset + parentof(this).keys_offset + 56) //key_hdr
//    key_hdr key_header <bgcolor=cRed>
    
    /*switch(key_header.kind_0) {
    case kind_omap: omap_key key <bgcolor=cBlue> /*Printf("\nOmapkey @ node @ pos 0x%LX", pos)*/ break
    case kind_lookup: lookup_key key break
    case kind_inode: /*empty_key key*/ break
    case kind_xattr: xattr_key key break
    case kind_sibling: sibling_key key break
    case kind_extent_refcount: /*empty_key key */break
    case kind_extent: extent_key key break
    case kind_drec: drec_key key break
    case kind_sibling_map: /*empty_key key*/ break
    default: Printf("\nKey type not seen 0x%X", key_header.kind_0) break
    }
    
    FSeek(parentof(parentof(this)).obj_start_off + Block_Size - data_offset - 40 * (parentof(this).node_type & 1)) // val
    local uint test = (parentof(this).level > 0) ? 256 : key_header.kind_0
    switch(test) {
    case 256: {
    if (key_header.kind_0 == kind_extent_refcount ||
    key_header.kind_0 == kind_extent ||
    key_header.kind_0 == kind_drec ||
    key_header.kind_0 == kind_xattr ||
    key_header.kind_0 == kind_inode ||
    key_header.kind_0 == kind_sibling ||
    key_header.kind_0 == kind_sibling_map)
    uint64 val <bgcolor=cLtGreen>
    else {
    //pointer_val v_pointer //inlining this
    if (Follow_Pointer) {
    //ref_obj val //inlined
    //// BEGIN ref_obj
    local uint64 rpos = FTell()
    uint64 oid
    if (oid == 0)
    Printf("\n%s\n", "oid was 0 in obj_ref!! Not defining val!!")
    else if (SeekBlock(oid) != 0) // outside disk image!
    Printf("\n%s\n", "oid invalid in obj_ref!! Not defining val!!")
    else
    obj val
    FSeek(rpos + 8)
    //// END ref_obj
    }
    else
    uint64 pointer
    }
    break// applies to all pointer vals, i.e. any entry val in index nodes
    }
    case kind_omap: omap_val val  break
    case kind_lookup: lookup_val val break
    case kind_inode: inode_val val break
    case kind_xattr: xattr_val val break
    case kind_sibling: sibling_val val break
    case kind_extent_refcount: extent_refcount_val val break
    case kind_extent: extent_val val <bgcolor=0x52D456> break
    case kind_drec: drec_val val <bgcolor=0xc2f416> break
    case kind_sibling_map: sibling_map_val val break
    }
    FSeek(pos2)*/
}

// node (type: 0x02)
class Node:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var node_type:ushort?
    var level:ushort? // Zero for leaf nodes, > 0 for index nodes
    var   entry_count:UInt?
    var unknown_40:ushort?
    var keys_offset:ushort?
    var keys_length:ushort?
    var data_offset:ushort?
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
        print("override")
    }
    // END

}


// btree (type: 0x0b)
class  Btree:KaitaiStruct{
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
    
    var btree_type:treeType?
    var    unknown_0:UInt?// <format=hex>
    //ref_obj   root //inlined
    //// BEGIN ref_obj
    /*local uint64 rpos = FTell()
     uint64 root_oid
     if (root_oid == 0)
     Printf("\n%s\n", "root_oid was 0 in obj_ref!! Not defining root!!")
     else if (SeekBlock(root_oid) != 0) // outside disk image!
     Printf("\n%s\n", "root_oid invalid in obj_ref!! Not defining root!!")
     else
     obj root
     FSeek(rpos + 8)
     //// END ref_obj*/
}



