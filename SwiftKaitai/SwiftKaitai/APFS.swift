// mash up of
// https://github.com/cugu/afro/blob/master/afro/libapfs/apfs.ksy
// https://github.com/cugu/afro/blob/master/afro/libapfs/apfs.py
// AND THIS FILE
// https://github.com/ydkhatri/APFS_010/blob/master/apfs.010.bt
//
// TODO
//    CAMEL CASE
//    INTEGRATE INTO https://github.com/kaitai-io/kaitai_class _swift_runtime/pull/2

import Foundation
import KaitaiStream

public typealias byte          = Swift.Int8
public typealias ubyte          = Swift.UInt8
public typealias short         = Swift.Int16
public typealias ushort         = Swift.UInt16



//globals
let  apfs_Offset:UInt? = 0 // <---- Set this to wherever your APFS container starts
let  block_Size:UInt? = 4096 //default, we set this to actual later
let  follow_Pointer = true
let  current_Block_Offset:UInt? = 0

//BOILERPLATE - why not subclass ?? for v1 - desire parity with python class rather.


//    """Universal type to address a block: it both parses one u8-sized
//    block address and provides a lazy instance to parse that block
//    right away.
//    """

class Apfs:KaitaiStruct{
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var _raw_block0:obj?
    
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
        self._raw_block0 = self._io.readBytes(4096)
        var io = KaitaiStream(data: (self._raw_block0)) //BytesIO(self._raw_block0)
        self.block0 = self._root.Obj(io, self, self._root)
    }
    
}
class  ref_obj:KaitaiStruct{

    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var val:UInt?
    
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

// container_superblock (type: 0x01)
class  container_superblock:KaitaiStruct{
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
    var uuid:String?
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
       
//        self.magic = self._io.ensureFixedContents("x4E\x58\x53\x42")
//        self.block_size = self._io.read_u4le()
//        self.block_count = self._io.read_u8le()
//        self.features = self._io.read_u8le()
//        self.read_only_compatible_features = self._io.read_u8le()
//        self.incompatible_features = self._io.read_u8le()
//        self.uuid = self._io.read_bytes(16)
//        self.next_oid = self._io.read_u8le()
//        self.next_xid = self._io.read_u8le()
//        self.xp_desc_blocks = self._io.read_u4le()
//        self.xp_data_blocks = self._io.read_u4le()
//        self.xp_desc_base = self._io.read_u8le()
//        self.xp_data_base = self._io.read_u8le()
//        self.xp_desc_len = self._io.read_u4le()
//        self.xp_data_len = self._io.read_u4le()
//        self.xp_desc_index = self._io.read_u4le()
//        self.xp_desc_index_len = self._io.read_u4le()
//        self.xp_data_index = self._io.read_u4le()
//        self.xp_data_index_len = self._io.read_u4le()
//        self.spaceman_oid = self._io.read_u8le()
//        self.omap_oid = self._root.RefObj(self._io, self, self._root)
//        self.reaper_oid = self._io.read_u8le()
//        self.pad2 = self._io.read_u4le()
//        self.max_file_systems = self._io.read_u4le()
//        self.fs_oids = [None] * (self.max_file_systems)
//        for i in range(self.max_file_systems):
//        self.fs_oids[i] = self._io.read_u8le()
    }
    // END

    
}


//// node entry keys
class  key_hdr:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END

    var obj_id:UInt? = 60
    var kind_0:UInt? = 04 //<read=ReadKind>
}

class  empty_key:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END

}

class  omap_key:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END

    var xid:UInt?
}

class  history_key:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END

    var  xid:UInt?
    //ref_obj obj_id //inlined
    //// BEGIN ref_obj
    //    local uint64 rpos = FTell()
    //    var oid:UInt?
    //    if (oid == 0)
    //    Printf("\n%s\n", "oid was 0 in obj_ref!! Not defining history_object!!")
    //    else if (SeekBlock(oid) != 0)
    //    Printf("\n%s\n", "oid was invalid in obj_ref!! Not defining history_object!!")
    //    else
    //    obj history_object
    //    FSeek(rpos + 8)
    //    //// END ref_obj
}

class  lookup_key:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END

    //ref_obj offset
    var offset_ref_obj:UInt? = 60 // seen
    var kind_1:UInt?  = 04
}

class  drec_key:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var name_length:ubyte?
    var  hash:[byte]?
    var  name:String? //[ name_length ]
    
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
        self.name_length = self._io.readU1()
//        self.flag_1 = self._io.readU1()
//        self.unknown_2 = self._io.readU2le()
//        self.name = (KaitaiStream.bytes_terminate(self._io.readBytes(self.name_length), 0, false))
    }



}//  <read=ReadDrec_Key>

//string ReadDrec_Key(drec_key & d) {
//    return d.name
//}

class  xattr_key:KaitaiStruct {
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END

    var  name_length:ushort?
    var    name:String

//string ReadXattr_Key(xattr_key & d) {
//    return d.name
//}

class  sibling_key:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END

    var object:UInt?
}

class  extent_key:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END

    var offset:UInt? // seek pos in file
}

//// node entry vals

class  pointer_val:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END

}

class  history_val:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END

    var unknown_0:UInt?
    var unknown_4:UInt?
}

class  omap_val:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END

    // 0x00
    var flags:UInt?
    var size:UInt?

}

class  xf_header:KaitaiStruct {
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END

    var type:xfield_type
    var  length:ushort
}

class  xf_name:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END

    var name:String
}

class  xf_size:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    var  size:UInt?
    var stored_size:UInt?
    var unknown_16:UInt?
    var unknown_size:UInt? // could be compressed size
    var unknown_32:UInt?
}

class  xf_device_node:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    var major_minor:UInt?  // Works around lack of a u3 type
}

//uint get_xf_device_node_major(xf_device_node & xdn) {
//    return xdn.major_minor >> 24
//}
//
//uint get_xf_device_node_minor(xf_device_node & xdn) {
//    return xdn.major_minor & 0xFFFFFF
//}

class  xf_sparse_size :KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    var size:UInt?
}

class  xf_document_id :KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    var id:UInt?
}

class  inode_val:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    // 0x30
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
    var  mode:ushort// <format=octal>
    var  unknown_82:ushort
    var    unknown_84:UInt?
    var    unknown_88:UInt?
    var  xf_num_exts:ushort // File 0x02 or Folder 0x01 cmp. TN1150
    var  xf_used_data:ushort
    var  xf_hdr:[xf_header]
    var   local_index:UInt? = 0
    //    for (_index =0 _index < xf_num_exts _index++) {
    //        switch (xf_hdr[_index].type) {
    //        case xfield_type_name: xf_name x_name break
    //        case xfield_type_size: xf_size x_size break
    //        case xfield_type_device_node: xf_device_node x_dev_node break
    //        case xfield_type_sparse_size: xf_sparse_size x_sp_size break
    //        case xfield_type_document_id: xf_document_id x_doc_id break
    //        default: {
    //        byte xf_data[xf_hdr[_index].length]
    //        Printf("\nUnknown xfield_type 0x%X", xf_hdr[_index].type)
    //        }
    //    }
    //    if     (((8 - xf_hdr[_index].length) % 8) > 0)
    //    byte padding[((8 - xf_hdr[_index].length) % 8)]
    //    }
}

class  sibling_val:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    // 0x50
    var node_id:UInt?
    var length:ushort
    var  name:String //char [length]
}

class  extent_refcount_val:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    // 0x60
    var count:UInt?
}

class  lookup_val:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    // 0x20
    var   block_count:UInt?
    var unknown_4:ushort
    var block_size:ushort
    var inode:UInt?
    var   unknown_16:UInt?
}

class  extent_val:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    // 0x80
    var  len:UInt?
    var phys_block_num:UInt? //error in ksy  spec, this is NOT ref_obj
    var  flags:UInt?
}

class  drec_val:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    // 0x90
    var node_id:UInt?
    var timestamp:UInt?// <read=ApfsTimeRead>
    var type_item:item_type
}

class  sibling_map_val:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    // 0xc0
    var map_node_id:UInt?
}

class  xattr_val :KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    // 0x40 xattr_val
    var type:ea_type
    var  data_length:ushort
    //    switch (type) {
    //    case ea_type_symlink: char symbolic_link[] break // symlink
    //    default: {
    //    if (data_length)
    //    byte data[data_length]
    //    break
    //    }
    //    }
}

//// node entries
class  node_entry:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    //    local uint64 pos = FTell()
    var  key_offset:short
   // if ((parentof(this).node_type & 4) == 0)
    var key_length:ushort
    var  data_offset:short
//    if ((parentof(this).node_type & 4) == 0)
    var data_length:ushort
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
class  node:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    var node_type:ushort
    var level:ushort // Zero for leaf nodes, > 0 for index nodes
    var   entry_count:UInt?
    var unknown_40:ushort
    var keys_offset:ushort
    var keys_length:ushort
    var data_offset:ushort
    var unknown_48:UInt?// <format=hex>
    //    if (entry_count)
    var entries:[node_entry] //<optimize=false>
}

// space_manager (type: 0x05)
class  space_manager:KaitaiStruct {
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    // uint64 pos = FTell()
    var   block_size:UInt?
    var   blocks_per_chunk:UInt?
    var   chunks_per_cib:UInt?
    var      cibs_per_cab:UInt?
    var      block_count:UInt?
    var      chunk_count:UInt?
    var      cib_count:UInt?
    var      cab_count:UInt?
    var      entry_count:UInt?
    var      unknown_68:UInt?
    var    free_block_count:UInt?
    var      entries_offset:UInt?
    var      unknown_84:byte //= [92]
    var    prev_spaceman_internal_pool_block:UInt?
    /*SeekBlock(prev_spaceman_internal_pool_block)
     obj    prev_spaceman
     if (entry_count) {
     FSeek(pos - 0x20 + entries_offset)
     local uint i
     local uint64 pos2 = FTell()
     for (i=0 i < entry_count i++) {
     uint64 spaceman_internal_pool_block
     SeekBlock(spaceman_internal_pool_block)
     obj spaceman_internal_pool
     FSeek(pos2 + 8*(i+1))
     }
     }
     else
     FSeek(pos + 152) //prevent error about class  end offset < start*/
}

class spaceman_internal_pool_entry:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var xid:UInt?
    var num_preceeding_blocks:UInt? // number ofs blocks before this one
    var block_count:UInt?
    var free_block_count:UInt?
    var bitmap_block:UInt?
    var unknown_8:UInt?
    var unknown_12:UInt?
    
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
        xid = _io.readU8le()
        unknown_8 = _io.readU4le()
        unknown_12 = _io.readU4le()
        block_count = _io.readU4le()
        free_block_count = _io.readU4le()
        bitmap_block = _io.readU8le()
    }
  
}

// spaceman internal pool (type: 0x07)
class  spaceman_internal_pool:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    
    var unknown_32:UInt?
    var entry_count:UInt?
    //    if (entry_count)
    var  entries:[spaceman_internal_pool_entry] //<optimize=false>
}

// btree (type: 0x0b)
class  btree:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    
    var btree_type:tree_type
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

class  checkpoint_entry:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    
    var type:objType
    var   flags:ushort
    var     subtype:UInt? // enum: obj_subtype
    var     size:UInt?
    var     unknown_52:UInt?
    var     unknown_56:UInt?
    var     unknown_60:UInt?
    var   oid:UInt?
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
class  checkpoint:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    
    var   unknown_0:UInt?//  <format=hex>
    var    entry_count:UInt?
    //    if (entry_count)
    var entries:[checkpoint_entry]// <optimize=false>
}

class  volume_access_info:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    
    var   id:String //char [32]
    var timestamp:UInt?// <read=ApfsTimeRead>
    var last_xid:UInt?
}
// volume_superblock (type: 0x0d)
class  volume_superblock:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
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
    }
    // END
    // missing: next_obj_id, fs_flags, unmount_time
    /*char   magic[4] // APSB
     uint   fs_index
     byte   unknown_40[16]
     features   features_0
     byte   unknown_60[12] // readonly_compatible_features, incompatible_features
     uint64 fs_reserve_block_count
     uint64 fs_quota_block_count
     uint64 fs_alloc_count
     byte   unknown_92[32] // root_tree_type, extentref_tree_type, snap_meta_tree_type
     //ref_obj omap_oid // 'Maps node IDs to the inode Btree nodes'  //inlined
     //// BEGIN ref_obj
     local uint64 rpos = FTell()
     uint64 omap_oid
     if (omap_oid == 0)
     Printf("\n%s\n", "omap_oid was 0 in obj_ref!! Not defining omap!!")
     else if (SeekBlock(omap_oid) != 0) // outside disk image!
     Printf("\n%s\n", "omap_oid invalid in obj_ref!! Not defining omap!!")
     else
     obj omap
     FSeek(rpos + 8)
     //// END ref_obj
     uint64 root_tree_oid
     //ref_obj extentref_tree_oid /// 'Maps file extents to inodes' //inlined
     //// BEGIN ref_obj
     rpos = FTell()
     uint64 extentref_tree_oid
     if (extentref_tree_oid == 0)
     Printf("\n%s\n", "extentref_tree_oid was 0 in obj_ref!! Not defining extentref_tree!!")
     else if (SeekBlock(extentref_tree_oid) != 0) // outside disk image!
     Printf("\n%s\n", "extentref_tree_oid invalid in obj_ref!! Not defining extentref_tree!!")
     else
     obj extentref_tree
     FSeek(rpos + 8)
     //// END ref_obj
     //ref_obj snap_meta_tree_oid //inlined
     //// BEGIN ref_obj
     rpos = FTell()
     uint64 snap_meta_tree_oid
     if (snap_meta_tree_oid == 0)
     Printf("\n%s\n", "snap_meta_tree_oid was 0 in obj_ref!! Not defining snap_meta_tree!!")
     else if (SeekBlock(snap_meta_tree_oid) != 0) // outside disk image!
     Printf("\n%s\n", "snap_meta_tree_oid invalid in obj_ref!! Not defining snap_meta_tree!!")
     else
     obj snap_meta_tree
     FSeek(rpos + 8)
     //// END ref_obj
     byte   unknown_160[16] // revert_to_xid, total_blocks_freed?
     uint64 next_doc_id // next_obj_id?
     uint64 num_files
     uint64 num_directories
     uint64 num_symlinks
     uint64 num_other_fsobjects
     uint64 num_snapshots
     uint64 unknown_112 // revert_to_xid, total_blocks_freed?
     uint64 unknown_120 // revert_to_xid, total_blocks_freed?
     Uuid   vol_uuid
     uint64 last_mod_time <read=ApfsTimeRead>
     encryption_types encryption_flags
     volume_access_info formatted_by
     volume_access_info modified_by[8]
     char   volname[]*/
}

//
//class  reaper:KaitaiStruct{
//    var unknown0:UInt?
//    var unknown8:UInt?
//    var unknowns:UInt?6 = [10]
//}



