import Foundation
import KaitaiStream



class  VolumeAccessInfo:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var id:String? //char [32]
    var timestamp:UInt?// <read=ApfsTimeRead>
    var last_xid:UInt?
    
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
// volume_superblock (type: 0x0d)
class  VolumeSuperblock:KaitaiStruct{
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    
    var fs_index:UInt?
    var unknown_40:[UInt8]?
    var features_0:features?
    var unknown_60:[UInt8]?
    var fs_reserve_block_count:UInt?
    var fs_quota_block_count:UInt?
    var fs_alloc_count:UInt?
    var unknown_92:[UInt8]?
    var omap_oid:RefObj?
    var root_tree_oid:UInt?
    var extentref_tree_oid:RefObj?
    var snap_meta_tree_oid:RefObj?
    var unknown_160:[UInt8]?
    var next_doc_id:UInt?
    var num_files:UInt?
    var num_directories:UInt?
    var num_symlinks:UInt?
    var num_other_fsobjects:UInt?
    var num_snapshots:UInt?
    var unknown_1601:[UInt8]?
    var vol_uuid:[UInt8]?
    var last_mod_time:UInt?
    var formatted_by_last_xid:UInt?
    var formatted_by_id:UInt?
    var formatted_by_timestamp:UInt?
    var modified_by_last_xid:UInt?
    var modified_by_id:UInt?
    var modified_by_timestamp:UInt?
    var rest:[UInt8]?
    var volname:UInt?

    
    
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
  
//        magic = self._io.ensureFixedContents(b'"\x41\x50\x53\x42"') TODO - fix this
        fs_index = self._io.readU4le()
        unknown_40 = self._io.readBytes(16)
        features_0 = features(rawValue:Int(self._io.readU4le()!))
        unknown_60 = self._io.readBytes(12)
        fs_reserve_block_count = self._io.readU8le()
        fs_quota_block_count = self._io.readU8le()
        fs_alloc_count = self._io.readU8le()
        unknown_92 = self._io.readBytes(32)
        omap_oid = RefObj(self._io, self, self._root)
        root_tree_oid = self._io.readU8le()
        extentref_tree_oid = RefObj(self._io, self, self._root)
        snap_meta_tree_oid = RefObj(self._io, self, self._root)
        unknown_160 = self._io.readBytes(16)
        next_doc_id = self._io.readU8le()
        num_files = self._io.readU8le()
        num_directories = self._io.readU8le()
        num_symlinks = self._io.readU8le()
        num_other_fsobjects = self._io.readU8le()
        num_snapshots = self._io.readU8le()
        unknown_1601 = self._io.readBytes(16)
        vol_uuid = self._io.readBytes(16)
        last_mod_time = self._io.readU8le()
        formatted_by_last_xid = self._io.readU8le()
//        formatted_by_id = (KaitaiStream.bytesTerminate(self._io.readBytes(32), 0, false)) TODO - add helper in KaiTaiStream
        formatted_by_timestamp = self._io.readU8le()
        modified_by_last_xid = self._io.readU8le()
//        modified_by_id = (KaitaiStream.bytesTerminate(self._io.readBytes(32), 0, false)) TODO
        modified_by_timestamp = self._io.readU8le()
        rest = self._io.readBytes(344)
//        volname = (self._io.readBytesTerm(0, false, true, true)) TODO - fix this readBytesTerm
        
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
