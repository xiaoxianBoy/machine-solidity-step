/// @title S_Instructions
pragma solidity ^0.5.0;

import "../../contracts/MemoryInteractor.sol";
import "../../contracts/RiscVDecoder.sol";
import "../../contracts/VirtualMemory.sol";

library S_Instructions {
  event Print(string a, uint64 b);
  function get_rs1_imm_rs2(MemoryInteractor mi, uint256 mmIndex, uint32 insn)
  internal returns(uint64 rs1, int32 imm, uint64 val){
    rs1 = mi.read_x(mmIndex, RiscVDecoder.insn_rs1(insn));
    imm = RiscVDecoder.insn_S_imm(insn);
    val = mi.read_x(mmIndex, RiscVDecoder.insn_rs2(insn));
  }

  function SB(MemoryInteractor mi, uint256 mmIndex, uint64 pc, uint32 insn)
  public returns(bool){
    (uint64 vaddr, int32 imm, uint64 val) = get_rs1_imm_rs2(mi, mmIndex, insn);
    // 8 == uint8
    return VirtualMemory.write_virtual_memory(mi, mmIndex, 8, vaddr + uint64(imm), val);
  }

  function SH(MemoryInteractor mi, uint256 mmIndex, uint64 pc, uint32 insn)
  public returns(bool){
    (uint64 vaddr, int32 imm, uint64 val) = get_rs1_imm_rs2(mi, mmIndex, insn);
    // 16 == uint16
    return VirtualMemory.write_virtual_memory(mi, mmIndex, 16, vaddr + uint64(imm), val);
  }

  function SW(MemoryInteractor mi, uint256 mmIndex, uint64 pc, uint32 insn)
  public returns(bool){
    (uint64 vaddr, int32 imm, uint64 val) = get_rs1_imm_rs2(mi, mmIndex, insn);
    // 32 == uint32
    return VirtualMemory.write_virtual_memory(mi, mmIndex, 32, vaddr + uint64(imm), val);
  }

  function SD(MemoryInteractor mi, uint256 mmIndex, uint64 pc, uint32 insn)
  public returns(bool){
    (uint64 vaddr, int32 imm, uint64 val) = get_rs1_imm_rs2(mi, mmIndex, insn);
    // 64 == uint64
    return VirtualMemory.write_virtual_memory(mi, mmIndex, 64, vaddr + uint64(imm), val);
  }
}