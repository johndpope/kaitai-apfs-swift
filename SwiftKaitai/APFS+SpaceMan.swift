//
//  APFS+SpaceMan.swift
//  SwiftKaitai
//
//  Created by Pope, John on 7/25/18.
//  Copyright © 2018 UXKit. All rights reserved.
//

import Foundation
import KaitaiStream

// space_manager (type: 0x05)
class  SpaceManager:KaitaiStruct {
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
    var      unknown_84:byte? //= [92]
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

class SpacemanInternalPoolEntry:KaitaiStruct{
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
        xid = _io.readU8le()
        unknown_8 = _io.readU4le()
        unknown_12 = _io.readU4le()
        block_count = _io.readU4le()
        free_block_count = _io.readU4le()
        bitmap_block = _io.readU8le()
    }
    
}

// spaceman internal pool (type: 0x07)
class  SpacemanInternalPool:KaitaiStruct{
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
    
    var unknown_32:UInt?
    var entry_count:UInt?
    //    if (entry_count)
    var  entries:[SpacemanInternalPoolEntry]? //<optimize=false>
}
