import Foundation
import KaitaiStream

// space_manager (type: 0x05)
class  SpaceManager:KaitaiStruct {
    //BEGIN BOILERPLATE
    var _io: KaitaiStream
    var _root: KaitaiStruct?
    var _parent: KaitaiStruct?
    var block_size:UInt?
    var blocks_per_chunk:UInt?
    var chunks_per_cib:UInt?
    var cibs_per_cab:UInt?
    var block_count:UInt?
    var chunk_count:UInt?
    var cib_count:UInt?
    var cab_count:UInt?
    var entry_count:UInt?
    var unknown_68:UInt?
    var free_block_count:UInt?
    var entries_offset:UInt?
    var unknown_84:[UInt8]? //= [92]
    var prev_spaceman_internal_pool_block:UInt?
    
    
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
        block_size = self._io.readU4le()
        blocks_per_chunk = self._io.readU4le()
        chunks_per_cib = self._io.readU4le()
        cibs_per_cab = self._io.readU4le()
        block_count = self._io.readU4le()
        chunk_count = self._io.readU4le()
        cib_count = self._io.readU4le()
        cab_count = self._io.readU4le()
        entry_count = self._io.readU4le()
        unknown_68 = self._io.readU4le()
        free_block_count = self._io.readU8le()
        entries_offset = self._io.readU4le()
        unknown_84 = self._io.readBytes(92)
        prev_spaceman_internal_pool_block = self._io.readU8le()
    }
    


    func spaceman_internal_pool_blocks(){
        print("TODO")
//        if hasattr(self, '_m_spaceman_internal_pool_blocks'):
//        return self._m_spaceman_internal_pool_blocks if hasattr(self, '_m_spaceman_internal_pool_blocks') else None
//
//        _pos = self._io.pos()
//        self._io.seek(self.entries_offset)
//        self._m_spaceman_internal_pool_blocks = [None] * (self.entry_count)
//        for i in range(self.entry_count):
//        self._m_spaceman_internal_pool_blocks[i] = self._io.readU8le()
//
//        self._io.seek(_pos)
//        return self._m_spaceman_internal_pool_blocks if hasattr(self, '_m_spaceman_internal_pool_blocks') else None
    }
   

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
    var unknown_32:[UInt8]?
    var entry_count:UInt?
    var  entries:[SpacemanInternalPoolEntry]? //<optimize=false>
    
    
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
        self.unknown_32 = self._io.readBytes(4)
        self.entry_count = self._io.readU4le()
        self.entries = []
        
        let n = Int(bitPattern: self.entry_count!)
        for _ in 0..<n{
          self.entries?.append(SpacemanInternalPoolEntry(self._io, self, self._root))
        }
    }
    // END
    

}
