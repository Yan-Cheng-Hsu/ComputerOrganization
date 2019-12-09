# 
# Synthesis run script generated by Vivado
# 

namespace eval rt {
    variable rc
}
set rt::rc [catch {
  uplevel #0 {
    set ::env(BUILTIN_SYNTH) true
    source $::env(HRT_TCL_PATH)/rtSynthPrep.tcl
    rt::HARTNDb_resetJobStats
    rt::HARTNDb_resetSystemStats
    rt::HARTNDb_startSystemStats
    rt::HARTNDb_startJobStats
    set rt::cmdEcho 0
    rt::set_parameter writeXmsg true
    rt::set_parameter enableParallelHelperSpawn true
    set ::env(RT_TMP) "D:/Programming_test/ComputerOrganization/Test/Test.runs/synth_1/.Xil/Vivado-16748-LAPTOP-AD9UN32I/realtime/tmp"
    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
      file mkdir $::env(RT_TMP)
    }

    rt::delete_design

    set rt::partid xc7z020clg484-1
    source $::env(HRT_TCL_PATH)/rtSynthParallelPrep.tcl
     file delete -force synth_hints.os

    set rt::multiChipSynthesisFlow false
    source $::env(SYNTH_COMMON)/common.tcl
    set rt::defaultWorkLibName xil_defaultlib

    set rt::useElabCache false
    if {$rt::useElabCache == false} {
      rt::read_verilog {
      D:/Programming_test/ComputerOrganization/Test/Test.srcs/sources_1/new/ALU.v
      D:/Programming_test/ComputerOrganization/Test/Test.srcs/sources_1/new/ALU_Control.v
      D:/Programming_test/ComputerOrganization/Test/Test.srcs/sources_1/new/Add_4.v
      D:/Programming_test/ComputerOrganization/Test/Test.srcs/sources_1/new/Control.v
      D:/Programming_test/ComputerOrganization/Test/Test.srcs/sources_1/new/Data_Memory.v
      D:/Programming_test/ComputerOrganization/Test/Test.srcs/sources_1/new/InstructionMemory.v
      D:/Programming_test/ComputerOrganization/Test/Test.srcs/sources_1/new/JAdd.v
      D:/Programming_test/ComputerOrganization/Test/Test.srcs/sources_1/new/Mux_32bits.v
      D:/Programming_test/ComputerOrganization/Test/Test.srcs/sources_1/new/Mux_5bits.v
      D:/Programming_test/ComputerOrganization/Test/Test.srcs/sources_1/new/PC.v
      D:/Programming_test/ComputerOrganization/Test/Test.srcs/sources_1/new/Register_file.v
      D:/Programming_test/ComputerOrganization/Test/Test.srcs/sources_1/new/ShiftLeft_2.v
      D:/Programming_test/ComputerOrganization/Test/Test.srcs/sources_1/new/ShiftLeft_26to28.v
      D:/Programming_test/ComputerOrganization/Test/Test.srcs/sources_1/new/SignExtend.v
      D:/Programming_test/ComputerOrganization/Test/Test.srcs/sources_1/new/CPU_SingleCycle.v
    }
      rt::filesetChecksum
    }
    rt::set_parameter usePostFindUniquification false
    set rt::top CPU_SingleCycle
    rt::set_parameter enableIncremental true
    set rt::reportTiming false
    rt::set_parameter elaborateOnly false
    rt::set_parameter elaborateRtl false
    rt::set_parameter eliminateRedundantBitOperator true
    rt::set_parameter elaborateRtlOnlyFlow false
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter ramStyle auto
    rt::set_parameter merge_flipflops true
# MODE: 
    rt::set_parameter webTalkPath {D:/Programming_test/ComputerOrganization/Test/Test.cache/wt}
    rt::set_parameter enableSplitFlowPath "D:/Programming_test/ComputerOrganization/Test/Test.runs/synth_1/.Xil/Vivado-16748-LAPTOP-AD9UN32I/"
    set ok_to_delete_rt_tmp true 
    if { [rt::get_parameter parallelDebug] } { 
       set ok_to_delete_rt_tmp false 
    } 
    if {$rt::useElabCache == false} {
        set oldMIITMVal [rt::get_parameter maxInputIncreaseToMerge]; rt::set_parameter maxInputIncreaseToMerge 1000
        set oldCDPCRL [rt::get_parameter createDfgPartConstrRecurLimit]; rt::set_parameter createDfgPartConstrRecurLimit 1
        $rt::db readXRFFile
      rt::run_synthesis -module $rt::top
        rt::set_parameter maxInputIncreaseToMerge $oldMIITMVal
        rt::set_parameter createDfgPartConstrRecurLimit $oldCDPCRL
    }

    set rt::flowresult [ source $::env(SYNTH_COMMON)/flow.tcl ]
    rt::HARTNDb_stopJobStats
    rt::HARTNDb_reportJobStats "Synthesis Optimization Runtime"
    rt::HARTNDb_stopSystemStats
    if { $rt::flowresult == 1 } { return -code error }


  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] } { 
     $rt::db killSynthHelper $hsKey
  } 
  rt::set_parameter helper_shm_key "" 
    if { [ info exists ::env(RT_TMP) ] } {
      if { [info exists ok_to_delete_rt_tmp] && $ok_to_delete_rt_tmp } { 
        file delete -force $::env(RT_TMP)
      }
    }

    source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  } ; #end uplevel
} rt::result]

if { $rt::rc } {
  $rt::db resetHdlParse
  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] } { 
     $rt::db killSynthHelper $hsKey
  } 
  source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  return -code "error" $rt::result
}
