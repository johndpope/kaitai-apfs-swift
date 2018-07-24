// mash up of
// https://github.com/cugu/afro/blob/master/afro/libapfs/apfs.ksy
// https://github.com/cugu/afro/blob/master/afro/libapfs/apfs.py
// AND THIS FILE
// https://github.com/ydkhatri/APFS_010/blob/master/apfs.010.bt
//
// TODO
//    CAMEL CASE
//    INTEGRATE INTO https://github.com/kaitai-io/kaitai_struct_swift_runtime/pull/2

import Foundation
import KaitaiStream

public typealias byte          = Swift.Int8
public typealias ubyte          = Swift.UInt8
public typealias short         = Swift.Int16
public typealias ushort         = Swift.UInt16
public typealias uint           = Swift.UInt32
public typealias nitfield       = Swift.UInt32
public typealias uint64         = Swift.UInt64
public typealias uint64EXT      = Swift.UInt64


//globals
let  apfs_Offset:uint64 = 0 // <---- Set this to wherever your APFS container starts
let  block_Size:uint = 4096 //default, we set this to actual later
let  follow_Pointer = true
let  current_Block_Offset:uint64 = 0

//struct Uuid {
//    func value()-> String{
//        /*BigEndian()
//         uint Data1 <format=hex>
//         ushort  Data2 <format=hex>
//         ushort  Data3 <format=hex>
//         ushort  Data4 <format=hex>
//         ubyte  Data5[6] <format=hex>
//         LittleEndian()*/
//    }
//
//
//    public var description: String {
//        switch self {
//
//        default: return "Unknown"
//        }
//
//    }
//} // <read=ReadUUID>

//string ReadUUID (Uuid  & g){
//    local string ret
//    SPrintf(ret, "%08x-%04x-%04x-%04x-%02x%02x%02x%02x%02x%02x", g.Data1, g.Data2, g.Data3, g.Data4, g.Data5[0], g.Data5[1], g.Data5[2], g.Data5[3], g.Data5[4], g.Data5[5])
//    return ret
//}

// reference obj
// This structure is unused now as it has been inlined everywhere due to
// limitation on the number of nested structures you can view in 010 gui.
struct ref_obj:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    //    local uint64 pos = FTell()
    //    var val:uint64
    //    if (val == 0)
    //    Printf("\n%s\n", "val was 0 in obj_ref!! Not defining obj!!")
    //    else if (SeekBlock(val) != 0)
    //    Printf("\n%s\n", "val was invalid in obj_ref!! Not defining obj!!")
    //    else
    //    obj object
    //
    //    FSeek(pos + 8)
}

// container_superblock (type: 0x01)
struct container_superblock:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    var  pos:uint64
    var magic:[String] // NXSB
    var   block_size:uint
    var  block_count:uint64
    var   features_0:uint64
    var   read_only_compatible_features:uint64
    var   incompatible_features:uint64
    var     uuid:Uuid
    var   next_oid:uint64
    var   next_xid:uint64
    var     xp_desc_blocks:uint
    var     xp_data_blocks:uint
    var   xp_desc_base:uint64
    var   xp_data_base:uint64
    var     xp_desc_len:uint
    var     xp_data_len:uint
    var     xp_desc_index:uint
    var     xp_desc_index_len:uint
    var     xp_data_index:uint
    var      xp_data_index_len:uint
    var   spaceman_oid:uint64
    //ref_obj omap_oid //inlined
    //// BEGIN ref_obj
    /* local uint64 rpos = FTell()
     uint64 omap_oid
     if (omap_oid == 0)
     Printf("\n%s\n", "omap_oid was 0 in obj_ref!! Not defining omap!!")
     else if (SeekBlock(omap_oid) != 0)
     Printf("\n%s\n", "omap_oid was invalid in obj_ref!! Not defining omap!!")
     else
     obj omap
     FSeek(rpos + 8)
     //// END ref_obj
     */
    //    var  reaper_oid:uint64
    //    var   pad2:uint
    //    var   max_file_systems:uint
    //    var fs_oids[max_file_systems]
    //    if (max_file_systems < 100)
    //    uint64 padding[100 - max_file_systems]
    //    uint64 unknown_version <format=hex> // seems to be incremental, block0 has highest number
    //    uint64 unknowns[0x26]      // only for encrypted
    //    var keybag_block_start:uint64  // only for encrypted
    //    var keybag_block_count:uint64  // only for encrypted
    //    var unknown_0x520:uint64       // only for encrypted
    //    local uint pos_end = FTell()
    
    // checkpoint
    //    SeekBlock(xp_desc_base + xp_desc_index)
    //    obj checkpoint
    //
    //    // spaceman
    //    SeekBlock(xp_data_base + xp_data_index)
    //    obj spaceman
    //    FSeek(pos_end)
}


//// node entry keys
struct key_hdr:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    var obj_id:uint64 = 60
    var kind_0:uint64 = 04 //<read=ReadKind>
}

struct empty_key:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
}

struct omap_key:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    var xid:uint64
}

struct history_key:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    var  xid:uint64
    //ref_obj obj_id //inlined
    //// BEGIN ref_obj
    //    local uint64 rpos = FTell()
    //    var oid:uint64
    //    if (oid == 0)
    //    Printf("\n%s\n", "oid was 0 in obj_ref!! Not defining history_object!!")
    //    else if (SeekBlock(oid) != 0)
    //    Printf("\n%s\n", "oid was invalid in obj_ref!! Not defining history_object!!")
    //    else
    //    obj history_object
    //    FSeek(rpos + 8)
    //    //// END ref_obj
}

struct lookup_key:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    //ref_obj offset
    var offset_ref_obj:uint64 = 60 // seen
    var kind_1:uint64  = 04
}

struct drec_key:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    var name_length:ubyte
    var  hash:[byte]
    var  name:String //[ name_length ]
}//  <read=ReadDrec_Key>

//string ReadDrec_Key(drec_key & d) {
//    return d.name
//}

struct xattr_key:KaitaiStruct {
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    var  name_length:ushort
    var    name:String //[ name_length ]
}  //<read=ReadXattr_Key>

//string ReadXattr_Key(xattr_key & d) {
//    return d.name
//}

struct sibling_key:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    var object:uint64
}

struct extent_key:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    var offset:uint64 // seek pos in file
}

//// node entry vals

struct pointer_val:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    // for any index nodes
    //    if (Follow_Pointer) {
    //        //ref_obj val //inlined
    //        //// BEGIN ref_obj
    //        local uint64 rpos = FTell()
    //        uint64 val
    //        if (val == 0)
    //        Printf("\n%s\n", "val was 0 in obj_ref!! Not defining obj!!")
    //        else if (SeekBlock(val) != 0)
    //        Printf("\n%s\n", "val was invalid in obj_ref!! Not defining obj!!")
    //        else
    //        obj object
    //        FSeek(rpos + 8)
    //        //// END ref_obj
    //    }
    //    else
    //    uint64 pointer
}

struct history_val:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    // ???
    var unknown_0:uint
    var unknown_4:uint
}

struct omap_val:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    // 0x00
    var flags:uint
    var size:uint
    //ref_obj paddr //inlined
    //// BEGIN ref_obj
    /*var  rpos:uint64 = FTell()
     uint64 paddr
     if (paddr == 0)
     Printf("\n%s\n", "paddr was 0 in obj_ref!! Not defining omap!!")
     else if (SeekBlock(paddr) != 0) // outside disk image!
     Printf("\n%s\n", "paddr invalid in obj_ref!! Not defining omap!!")
     else
     obj omap
     FSeek(rpos + 8)
     //// END ref_obj*/
}

struct xf_header:KaitaiStruct {
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    var type:xfield_type
    var  length:ushort
}

struct xf_name{
    var name:String
}

struct xf_size:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    var  size:uint64
    var stored_size:uint64
    var unknown_16:uint64
    var unknown_size:uint64 // could be compressed size
    var unknown_32:uint64
}

struct xf_device_node:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    var major_minor:uint  // Works around lack of a u3 type
}

//uint get_xf_device_node_major(xf_device_node & xdn) {
//    return xdn.major_minor >> 24
//}
//
//uint get_xf_device_node_minor(xf_device_node & xdn) {
//    return xdn.major_minor & 0xFFFFFF
//}

struct xf_sparse_size :KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    var size:uint64
}

struct xf_document_id :KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    var id:uint
}

struct inode_val:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    // 0x30
    var parent_id:uint64
    var extents_id:uint64
    var  creation_timestamp:uint64 //<read=ApfsTimeRead>
    var  modified_timestamp:uint64 //<read=ApfsTimeRead>
    var  changed_timestamp:uint64 // <read=ApfsTimeRead>
    var  accessed_timestamp:uint64// <read=ApfsTimeRead>
    var  flags:uint64
    var  nchildren_or_nlink:uint
    var    unknown_60:uint
    var    unknown_64:uint
    var    bsdflags:uint
    var    owner_id:uint
    var    group_id:uint
    var  mode:ushort// <format=octal>
    var  unknown_82:ushort
    var    unknown_84:uint
    var    unknown_88:uint
    var  xf_num_exts:ushort // File 0x02 or Folder 0x01 cmp. TN1150
    var  xf_used_data:ushort
    var  xf_hdr:[xf_header]
    var   local_index:uint = 0
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

struct sibling_val:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    // 0x50
    var node_id:uint64
    var length:ushort
    var  name:String //char [length]
}

struct extent_refcount_val:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    // 0x60
    var count:uint
}

struct lookup_val:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    // 0x20
    var   block_count:uint
    var unknown_4:ushort
    var block_size:ushort
    var inode:uint64
    var   unknown_16:uint
}

struct extent_val:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    // 0x80
    var  len:uint64
    var phys_block_num:uint64 //error in ksy  spec, this is NOT ref_obj
    var  flags:uint64
}

struct drec_val:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    // 0x90
    var node_id:uint64
    var timestamp:uint64// <read=ApfsTimeRead>
    var type_item:item_type
}

struct sibling_map_val:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    // 0xc0
    var map_node_id:uint64
}

struct xattr_val :KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
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
struct node_entry:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
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
struct node:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    var node_type:ushort
    var level:ushort // Zero for leaf nodes, > 0 for index nodes
    var   entry_count:uint
    var unknown_40:ushort
    var keys_offset:ushort
    var keys_length:ushort
    var data_offset:ushort
    var unknown_48:uint64// <format=hex>
    //    if (entry_count)
    var entries:[node_entry] //<optimize=false>
}

// space_manager (type: 0x05)
struct space_manager:KaitaiStruct {
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    // uint64 pos = FTell()
    var   block_size:uint
    var   blocks_per_chunk:uint
    var   chunks_per_cib:uint
    var      cibs_per_cab:uint
    var      block_count:uint
    var      chunk_count:uint
    var      cib_count:uint
    var      cab_count:uint
    var      entry_count:uint
    var      unknown_68:uint
    var    free_block_count:uint64
    var      entries_offset:uint
    var      unknown_84:byte //= [92]
    var    prev_spaceman_internal_pool_block:uint64
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
     FSeek(pos + 152) //prevent error about struct end offset < start*/
}

class spaceman_internal_pool_entry:KaitaiStruct{
    var _io: KaitaiStream?
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
    var xid:UInt?
    var num_preceeding_blocks:UInt? // number ofs blocks before this one
    var block_count:UInt?
    var free_block_count:UInt?
    var bitmap_block:UInt?
    var unknown_8:UInt?
    var unknown_12:UInt?
    
    
    func _read(){
        xid = _io?.readU8le()
        unknown_8 = _io?.readU4le()
        unknown_12 = _io?.readU4le()
        block_count = _io?.readU4le()
        free_block_count = _io?.readU4le()
        bitmap_block = _io?.readU8le()
    }
  
}

// spaceman internal pool (type: 0x07)
struct spaceman_internal_pool:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    var unknown_32:uint
    var entry_count:uint
    //    if (entry_count)
    var  entries:[spaceman_internal_pool_entry] //<optimize=false>
}

// btree (type: 0x0b)
struct btree:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    var btree_type:tree_type
    var    unknown_0:uint64// <format=hex>
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

struct checkpoint_entry:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    var type:obj_type
    var   flags:ushort
    var     subtype:uint // enum: obj_subtype
    var     size:uint
    var     unknown_52:uint
    var     unknown_56:uint
    var     unknown_60:uint
    var   oid:uint64
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
struct checkpoint:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    var   unknown_0:uint//  <format=hex>
    var    entry_count:uint
    //    if (entry_count)
    var entries:[checkpoint_entry]// <optimize=false>
}

struct volume_access_info:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    
    var   id:String //char [32]
    var timestamp:uint64// <read=ApfsTimeRead>
    var last_xid:uint64
}
// volume_superblock (type: 0x0d)
struct volume_superblock:KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
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
//struct reaper:KaitaiStruct{
//    var unknown0:uint64
//    var unknown8:uint64
//    var unknowns:uint6 = [10]
//}

struct obj_header:KaitaiStruct {
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    //<size=32>
    var cksum:uint64 // Flechters checksum, according to the docs.
    var oid:uint64   // ID of the obj itself. Either the position of the obj or an incrementing number starting at 1024.
    var xid:uint64   // Incrementing version number of the xid of the obj (highest == latest)
    var type:obj_type
    var  flags:ushort// <format=hex> // 0x4000 oid = position, 0x8000 = container
    var subtype:obj_subtype // enum: obj_subtype
    var pad:ushort
}

struct obj :KaitaiStruct{
    var _io: KaitaiStream
    
    var _root: KaitaiStruct?
    
    var _parent: KaitaiStruct?
    //<size=GetObjSize>
    //    local uint64 obj_start_off = FTell()
    //Printf("\n Obj @ %LX", obj_start_off)
    var hdr:obj_header
    /*switch  hdr.type
    {
    case obj_type_container_superblock: container_superblock body break
    case obj_type_rootnode: node body break
    case obj_type_node: node body break
    case obj_type_space_manager: space_manager body break
    case obj_type_spaceman_internal_pool: spaceman_internal_pool body break
    case obj_type_btree: btree body break
    case obj_type_checkpoint: checkpoint body break
    case obj_type_volume_superblock: volume_superblock body break
    case obj_type_reaper: reaper rp_body break
    case obj_type_18_unknown: Printf("\nType 18 obj header type 0x%X @ 0x%LX", hdr.type, obj_start_off) break
    case obj_type_32_unknown: Printf("\nType 32 obj header type 0x%X @ 0x%LX", hdr.type, obj_start_off) break
    default: Printf("\nUnknown obj header type 0x%X @ 0x%LX", hdr.type, obj_start_off) /*Exit(3)*/ break
    }*
}

//int GetObjSize(obj & o) {
//    return Block_Size
//}
//
//int SeekBlock(uint64 block_id) {
//    Current_Block_Offset = Apfs_Offset + (block_id * Block_Size)
//    return FSeek(Current_Block_Offset)
//}
//
//uint CheckApfsAndSetBlockSize() {
//    local uint64 pos = FTell()
//    FSkip(32)
//    if (ReadUInt() == 0x4253584E) { // NXSB
//        FSkip(4)
//        Block_Size = ReadUInt()
//        FSeek(pos)
//        return true
//    }
//    FSeek(pos)
//    return false
//}
//
//void BookmarkVolumes(obj & csb) {
//    local uint i
//    local string vol_name = ""
//    for (i=0 i < csb.body.omap.body.root.body.entry_count ++i) {
//        vol_name = csb.body.omap.body.root.body.entries[i].val.omap.body.volname
//        Printf("\nVol name = %s", vol_name)
//        SeekBlock(csb.body.omap.body.root.body.entries[i].val.paddr)
//        obj vol <comment=GetVolName>
//    }
//}
//
//string GetVolName(obj & vsb) {
//    local string ret = vsb.body.volname
//    if ((vsb.body.encryption_flags & 1) != 1)
//    ret += " <ENCRYPTED volume>"
//    return ret
//}
//
////MAIN
//FSeek(Apfs_Offset)
//
//if (!CheckApfsAndSetBlockSize()) {
//    Printf("\nError, starting point not an APFS container superblock. Set the 'Apfs_Offset' variable to correct value!")
//    Exit(1)
//}
//
//obj csb//container super block
//BookmarkVolumes(csb)
