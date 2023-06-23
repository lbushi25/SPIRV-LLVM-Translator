; LLVM IR generated by Intel SYCL Clang compiler (https://github.com/intel/llvm)

; SYCL source code for this test:
; void field_numbanks_attr() {
;   struct numbanks_st {
;     [[intelfpga::numbanks(4)]] int field;
;   } s;
;   s.field = 0;
; }
;
; template <int A>
; void templ_field_numbanks_attr() {
;   struct templ_numbanks_st {
;     [[intelfpga::numbanks(A)]] int field;
;   } s;
;   s.field = 0;
; }
;
; void field_register_attr() {
;   struct register_st {
;     [[intelfpga::register]] int field;
;   } s;
;   s.field = 0;
; }
;
; void field_memory_attr() {
;   struct memory_st {
;     [[intelfpga::memory("MLAB")]] int field;
;   } s;
;   s.field = 0;
; }
;
; void field_bankwidth_attr() {
;   struct bankwidth_st {
;     [[intelfpga::bankwidth(8)]] int field;
;   } s;
;   s.field = 0;
; }
;
; template <int A>
; void templ_field_bankwidth_attr() {
;   struct templ_bankwidth_st {
;     [[intelfpga::bankwidth(A)]] int field;
;   } s;
;   s.field = 0;
; }
;
; void field_private_copies_attr() {
;   struct private_copies_st {
;     [[intelfpga::private_copies(4)]] int field;
;   } s;
;   s.field = 0;
; }
;
; template <int A>
; void templ_field_private_copies_attr() {
;   struct templ_private_copies_st {
;     [[intelfpga::private_copies(A)]] int field;
;   } s;
;   s.field = 0;
; }
;
; void field_singlepump_attr() {
;   struct singlepump_st {
;     [[intelfpga::singlepump]] int field;
;   } s;
;   s.field = 0;
; }
;
; void field_doublepump_attr() {
;   struct doublepump_st {
;     [[intelfpga::doublepump]] int field;
;   } s;
;   s.field = 0;
; }
;
; void field_merge_attr() {
;   struct merge_st {
;     [[intelfpga::merge("foobar", "width")]] int field;
;   } s;
;   s.field = 0;
; }
;
; void field_max_replicates_attr() {
;   struct max_replicates_st {
;     [[intelfpga::max_replicates(4)]] int field;
;   } s;
;   s.field = 0;
; }
;
; template <int A>
; void templ_field_max_replicates_attr() {
;   struct templ_max_replicates_st {
;     [[intelfpga::max_replicates(A)]] int field;
;   } s;
;   s.field = 0;
; }
;
; void field_simple_dual_port_attr() {
;   struct simple_dual_port_st {
;     [[intelfpga::simple_dual_port]] int field;
;   } s;
;   s.field = 0;
; }
;
; void field_bank_bits_attr() {
;   struct bank_bits_st {
;     [[intelfpga::bank_bits(42,41,40)]] int field;
;   } s;
;   s.field = 0;
; }
;
; template <int A, int B>
; void templ_field_bank_bits_attr() {
;   struct templ_bank_bits_st {
;     [[intelfpga::bank_bits(A, B)]] int field;
;   } s;
;   s.field = 0;
; }
;
; void field_force_pow2_depth_attr() {
;   struct force_pow2_depth_st {
;     [[intelfpga::force_pow2_depth(0)]] int field;
;   } s;
;   s.field = 0;
; }
;
; template <int A>
; void templ_field_force_pow2_depth_attr() {
;   struct templ_force_pow2_depth_st {
;     [[intelfpga::force_pow2_depth(A)]] int field;
;   } s;
;   s.field = 0;
; }
;
; void field_addrspace_cast() {
;   struct state {
;     [[intelfpga::numbanks(2)]] int mem[8];
;
;     // The initialization code is not relevant to this example.
;     // It prevents the compiler from optimizing away access to this struct.
;     state() {
;       for (auto i = 0; i < 8; i++) {
;         mem[i] = i;
;       }
;     }
;   } state_var;
;   state_var.mem[0] = 42;
; }
;
; template <typename name, typename Func>
; __attribute__((sycl_kernel)) void kernel_single_task(Func kernelFunc) {
;   kernelFunc();
; }
;
; int main() {
;   kernel_single_task<class kernel_function>([]() {
;     field_numbanks_attr();
;     templ_field_numbanks_attr<8>();
;     field_register_attr();
;     field_memory_attr();
;     field_bankwidth_attr();
;     templ_field_bankwidth_attr<4>();
;     field_private_copies_attr();
;     templ_field_private_copies_attr<2>();
;     field_singlepump_attr();
;     field_doublepump_attr();
;     field_merge_attr();
;     field_max_replicates_attr();
;     templ_field_max_replicates_attr<2>();
;     field_simple_dual_port_attr();
;     field_bank_bits_attr();
;     templ_field_bank_bits_attr<2,3>();
;     field_force_pow2_depth_attr();
;     templ_field_force_pow2_depth_attr<1>();
;     field_addrspace_cast();
;   });
;   return 0;
; }

; LLVM IR compilation command:
; clang -cc1 -triple spir -disable-llvm-passes -fsycl-is-device -emit-llvm intel-fpga-local-var.cpp

; RUN: llvm-as %s -o %t.bc
; RUN: llvm-spirv %t.bc --spirv-ext=+SPV_INTEL_fpga_memory_attributes -o %t.spv
; RUN: llvm-spirv %t.spv --spirv-ext=+SPV_INTEL_fpga_memory_attributes -to-text -o %t.spt
; RUN: FileCheck < %t.spt %s --check-prefix=CHECK-SPIRV

; RUN: llvm-spirv -r %t.spv -o %t.rev.bc
; RUN: llvm-dis -opaque-pointers=0 < %t.rev.bc | FileCheck %s --check-prefix=CHECK-LLVM

; RUN: llvm-spirv -spirv-text -r %t.spt -o %t.rev.bc
; RUN: llvm-dis -opaque-pointers=0 < %t.rev.bc | FileCheck %s --check-prefix=CHECK-LLVM

; TODO: add a bunch of different tests for --spirv-ext option

; CHECK-SPIRV: Capability FPGAMemoryAttributesINTEL
; CHECK-SPIRV: Extension "SPV_INTEL_fpga_memory_attributes"
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 UserSemantic "{sizeinfo:4}"
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 RegisterINTEL
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 MemoryINTEL "DEFAULT"
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 MemoryINTEL "MLAB"
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 NumbanksINTEL 2
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 NumbanksINTEL 4
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 NumbanksINTEL 8
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 BankwidthINTEL 4
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 BankwidthINTEL 8
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 MaxPrivateCopiesINTEL 2
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 MaxPrivateCopiesINTEL 4
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 SinglepumpINTEL
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 DoublepumpINTEL
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 MaxReplicatesINTEL 2
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 MaxReplicatesINTEL 4
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 SimpleDualPortINTEL
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 MergeINTEL "foobar" "width"
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 BankBitsINTEL 2 3
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 BankBitsINTEL 42 41 40
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 ForcePow2DepthINTEL 0
; CHECK-SPIRV-DAG: MemberDecorate {{[0-9]+}} 0 ForcePow2DepthINTEL 1

target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spir"

%class.anon = type { i8 }
%struct.numbanks_st = type { i32 }
%struct.templ_numbanks_st = type { i32 }
%struct.register_st = type { i32 }
%struct.memory_st = type { i32 }
%struct.bankwidth_st = type { i32 }
%struct.templ_bankwidth_st = type { i32 }
%struct.private_copies_st = type { i32 }
%struct.templ_private_copies_st = type { i32 }
%struct.singlepump_st = type { i32 }
%struct.doublepump_st = type { i32 }
%struct.merge_st = type { i32 }
%struct.max_replicates_st = type { i32 }
%struct.templ_max_replicates_st = type { i32 }
%struct.simple_dual_port_st = type { i32 }
%struct.bank_bits_st = type { i32 }
%struct.templ_bank_bits_st = type { i32 }
%struct.force_pow2_depth_st = type { i32 }
%struct.templ_force_pow2_depth_st = type { i32 }
%struct.state = type { [8 x i32] }

; CHECK-LLVM: [[STR_NMB_SCT:@[0-9_.]+]] = {{.*}}{memory:DEFAULT}{numbanks:4}
; CHECK-LLVM: [[STR_SIZEINF:@[0-9_.]+]] = {{.*}}{sizeinfo:4}
; CHECK-LLVM: [[STR_NMB_STE:@[0-9_.]+]] = {{.*}}{memory:DEFAULT}{numbanks:8}
; CHECK-LLVM: [[STR_REG_SCT:@[0-9_.]+]] = {{.*}}{register:1}
; CHECK-LLVM: [[STR_MEM_SCT:@[0-9_.]+]] = {{.*}}{memory:MLAB}
; CHECK-LLVM: [[STR_BWD_SCT:@[0-9_.]+]] = {{.*}}{memory:DEFAULT}{bankwidth:8}
; CHECK-LLVM: [[STR_BWD_STE:@[0-9_.]+]] = {{.*}}{memory:DEFAULT}{bankwidth:4}
; CHECK-LLVM: [[STR_PRC_SCT:@[0-9_.]+]] = {{.*}}{memory:DEFAULT}{private_copies:4}
; CHECK-LLVM: [[STR_PRC_STE:@[0-9_.]+]] = {{.*}}{memory:DEFAULT}{private_copies:2}
; CHECK-LLVM: [[STR_SNP_SCT:@[0-9_.]+]] = {{.*}}{memory:DEFAULT}{pump:1}
; CHECK-LLVM: [[STR_DBP_SCT:@[0-9_.]+]] = {{.*}}{memory:DEFAULT}{pump:2}
; CHECK-LLVM: [[STR_MRG_SCT:@[0-9_.]+]] = {{.*}}{memory:DEFAULT}{merge:foobar:width}
; CHECK-LLVM: [[STR_MXR_SCT:@[0-9_.]+]] = {{.*}}{max_replicates:4}
; CHECK-LLVM: [[STR_MXR_STE:@[0-9_.]+]] = {{.*}}{max_replicates:2}
; CHECK-LLVM: [[STR_SDP_SCT:@[0-9_.]+]] = {{.*}}{memory:DEFAULT}{simple_dual_port:1}
; CHECK-LLVM: [[STR_BBT_SCT:@[0-9_.]+]] = {{.*}}{memory:DEFAULT}{numbanks:8}{bank_bits:42,41,40}
; CHECK-LLVM: [[STR_BBT_STE:@[0-9_.]+]] = {{.*}}{memory:DEFAULT}{numbanks:4}{bank_bits:2,3}
; CHECK-LLVM: [[STR_FP2_SCT:@[0-9_.]+]] = {{.*}}{memory:DEFAULT}{force_pow2_depth:0}
; CHECK-LLVM: [[STR_FP2_STE:@[0-9_.]+]] = {{.*}}{memory:DEFAULT}{force_pow2_depth:1}
; CHECK-LLVM: [[STR_NMB_ASC:@[0-9_.]+]] = {{.*}}{memory:DEFAULT}{numbanks:2}
@.str = private unnamed_addr constant [41 x i8] c"{memory:DEFAULT}{sizeinfo:4}{numbanks:4}\00", section "llvm.metadata"
@.str.1 = private unnamed_addr constant [28 x i8] c"intel-fpga-local-struct.cpp\00", section "llvm.metadata"
@.str.2 = private unnamed_addr constant [41 x i8] c"{memory:DEFAULT}{sizeinfo:4}{numbanks:8}\00", section "llvm.metadata"
@.str.3 = private unnamed_addr constant [13 x i8] c"{register:1}\00", section "llvm.metadata"
@.str.4 = private unnamed_addr constant [26 x i8] c"{memory:MLAB}{sizeinfo:4}\00", section "llvm.metadata"
@.str.5 = private unnamed_addr constant [42 x i8] c"{memory:DEFAULT}{sizeinfo:4}{bankwidth:8}\00", section "llvm.metadata"
@.str.6 = private unnamed_addr constant [42 x i8] c"{memory:DEFAULT}{sizeinfo:4}{bankwidth:4}\00", section "llvm.metadata"
@.str.7 = private unnamed_addr constant [47 x i8] c"{memory:DEFAULT}{sizeinfo:4}{private_copies:4}\00", section "llvm.metadata"
@.str.8 = private unnamed_addr constant [47 x i8] c"{memory:DEFAULT}{sizeinfo:4}{private_copies:2}\00", section "llvm.metadata"
@.str.9 = private unnamed_addr constant [37 x i8] c"{memory:DEFAULT}{sizeinfo:4}{pump:1}\00", section "llvm.metadata"
@.str.10 = private unnamed_addr constant [37 x i8] c"{memory:DEFAULT}{sizeinfo:4}{pump:2}\00", section "llvm.metadata"
@.str.11 = private unnamed_addr constant [49 x i8] c"{memory:DEFAULT}{sizeinfo:4}{merge:foobar:width}\00", section "llvm.metadata"
@.str.12 = private unnamed_addr constant [19 x i8] c"{max_replicates:4}\00", section "llvm.metadata"
@.str.13 = private unnamed_addr constant [19 x i8] c"{max_replicates:2}\00", section "llvm.metadata"
@.str.14 = private unnamed_addr constant [49 x i8] c"{memory:DEFAULT}{sizeinfo:4}{simple_dual_port:1}\00", section "llvm.metadata"
@.str.15 = private unnamed_addr constant [61 x i8] c"{memory:DEFAULT}{sizeinfo:4}{numbanks:8}{bank_bits:42,41,40}\00", section "llvm.metadata"
@.str.16 = private unnamed_addr constant [56 x i8] c"{memory:DEFAULT}{sizeinfo:4}{numbanks:4}{bank_bits:2,3}\00", section "llvm.metadata"
@.str.17 = private unnamed_addr constant [49 x i8] c"{memory:DEFAULT}{sizeinfo:4}{force_pow2_depth:0}\00", section "llvm.metadata"
@.str.18 = private unnamed_addr constant [49 x i8] c"{memory:DEFAULT}{sizeinfo:4}{force_pow2_depth:1}\00", section "llvm.metadata"
@.str.19 = private unnamed_addr constant [43 x i8] c"{memory:DEFAULT}{sizeinfo:4,8}{numbanks:2}\00", section "llvm.metadata"

; Function Attrs: norecurse nounwind
define spir_kernel void @_ZTSZ4mainE15kernel_function() #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !4 !kernel_arg_type !4 !kernel_arg_base_type !4 !kernel_arg_type_qual !4 {
entry:
  %0 = alloca %class.anon, align 1
  %1 = bitcast %class.anon* %0 to i8*
  call void @llvm.lifetime.start.p0i8(i64 1, i8* %1) #5
  call spir_func void @"_ZZ4mainENK3$_0clEv"(%class.anon* %0)
  %2 = bitcast %class.anon* %0 to i8*
  call void @llvm.lifetime.end.p0i8(i64 1, i8* %2) #5
  ret void
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: inlinehint norecurse nounwind
define internal spir_func void @"_ZZ4mainENK3$_0clEv"(%class.anon* %this) #2 align 2 {
entry:
  %this.addr = alloca %class.anon*, align 4
  store %class.anon* %this, %class.anon** %this.addr, align 4, !tbaa !5
  %this1 = load %class.anon*, %class.anon** %this.addr, align 4
  call spir_func void @_Z19field_numbanks_attrv()
  call spir_func void @_Z25templ_field_numbanks_attrILi8EEvv()
  call spir_func void @_Z19field_register_attrv()
  call spir_func void @_Z17field_memory_attrv()
  call spir_func void @_Z20field_bankwidth_attrv()
  call spir_func void @_Z26templ_field_bankwidth_attrILi4EEvv()
  call spir_func void @_Z25field_private_copies_attrv()
  call spir_func void @_Z31templ_field_private_copies_attrILi2EEvv()
  call spir_func void @_Z21field_singlepump_attrv()
  call spir_func void @_Z21field_doublepump_attrv()
  call spir_func void @_Z16field_merge_attrv()
  call spir_func void @_Z25field_max_replicates_attrv()
  call spir_func void @_Z31templ_field_max_replicates_attrILi2EEvv()
  call spir_func void @_Z27field_simple_dual_port_attrv()
  call spir_func void @_Z20field_bank_bits_attrv()
  call spir_func void @_Z26templ_field_bank_bits_attrILi2ELi3EEvv()
  call spir_func void @_Z27field_force_pow2_depth_attrv()
  call spir_func void @_Z33templ_field_force_pow2_depth_attrILi1EEvv()
  call spir_func void @_Z20field_addrspace_castv()
  ret void
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: norecurse nounwind
define spir_func void @_Z19field_numbanks_attrv() #3 {
entry:
  %s = alloca %struct.numbanks_st, align 4
  %0 = bitcast %struct.numbanks_st* %s to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #5
  ; CHECK-LLVM: %[[FLD_NMB_SCT:.*]] = getelementptr inbounds %struct.numbanks_st, %struct.numbanks_st* %{{[a-zA-Z0-9]+}}, i32 0, i32 0
  ; CHECK-LLVM: %[[PTR_NMB_SCT:.*]] = call i32* @llvm.ptr.annotation.p0i32{{.*}}%[[FLD_NMB_SCT]]{{.*}}[[STR_NMB_SCT]]
  ; CHECK-LLVM: call i32* @llvm.ptr.annotation.p0i32{{.*}}%[[PTR_NMB_SCT]]{{.*}}[[STR_SIZEINF]]
  %field = getelementptr inbounds %struct.numbanks_st, %struct.numbanks_st* %s, i32 0, i32 0
  %1 = call i32* @llvm.ptr.annotation.p0i32(i32* %field, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i32 0, i32 0), i32 3, i8* null)
  store i32 0, i32* %1, align 4, !tbaa !9
  %2 = bitcast %struct.numbanks_st* %s to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #5
  ret void
}

; Function Attrs: norecurse nounwind
define linkonce_odr spir_func void @_Z25templ_field_numbanks_attrILi8EEvv() #3 {
entry:
  %s = alloca %struct.templ_numbanks_st, align 4
  %0 = bitcast %struct.templ_numbanks_st* %s to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #5
  ; CHECK-LLVM: %[[FLD_NMB_STE:.*]] = getelementptr inbounds %struct.templ_numbanks_st, %struct.templ_numbanks_st* %{{[a-zA-Z0-9]+}}, i32 0, i32 0
  ; CHECK-LLVM: call i32* @llvm.ptr.annotation.p0i32{{.*}}%[[FLD_NMB_STE]]{{.*}}[[STR_NMB_STE]]
  %field = getelementptr inbounds %struct.templ_numbanks_st, %struct.templ_numbanks_st* %s, i32 0, i32 0
  %1 = call i32* @llvm.ptr.annotation.p0i32(i32* %field, i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str.2, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i32 0, i32 0), i32 11, i8* null)
  store i32 0, i32* %1, align 4, !tbaa !13
  %2 = bitcast %struct.templ_numbanks_st* %s to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #5
  ret void
}

; Function Attrs: norecurse nounwind
define spir_func void @_Z19field_register_attrv() #3 {
entry:
  %s = alloca %struct.register_st, align 4
  %0 = bitcast %struct.register_st* %s to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #5
  ; CHECK-LLVM: %[[FLD_REG_SCT:.*]] = getelementptr inbounds %struct.register_st, %struct.register_st* %{{[a-zA-Z0-9]+}}, i32 0, i32 0
  ; CHECK-LLVM: call i32* @llvm.ptr.annotation.p0i32{{.*}}%[[FLD_REG_SCT]]{{.*}}[[STR_REG_SCT]]
  %field = getelementptr inbounds %struct.register_st, %struct.register_st* %s, i32 0, i32 0
  %1 = call i32* @llvm.ptr.annotation.p0i32(i32* %field, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i32 0, i32 0), i32 18, i8* null)
  store i32 0, i32* %1, align 4, !tbaa !15
  %2 = bitcast %struct.register_st* %s to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #5
  ret void
}

; Function Attrs: norecurse nounwind
define spir_func void @_Z17field_memory_attrv() #3 {
entry:
  %s = alloca %struct.memory_st, align 4
  %0 = bitcast %struct.memory_st* %s to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #5
  ; CHECK-LLVM: %[[FLD_MEM_SCT:.*]] = getelementptr inbounds %struct.memory_st, %struct.memory_st* %{{[a-zA-Z0-9]+}}, i32 0, i32 0
  ; CHECK-LLVM: call i32* @llvm.ptr.annotation.p0i32{{.*}}%[[FLD_MEM_SCT]]{{.*}}[[STR_MEM_SCT]]
  %field = getelementptr inbounds %struct.memory_st, %struct.memory_st* %s, i32 0, i32 0
  %1 = call i32* @llvm.ptr.annotation.p0i32(i32* %field, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.4, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i32 0, i32 0), i32 25, i8* null)
  store i32 0, i32* %1, align 4, !tbaa !17
  %2 = bitcast %struct.memory_st* %s to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #5
  ret void
}

; Function Attrs: norecurse nounwind
define spir_func void @_Z20field_bankwidth_attrv() #3 {
entry:
  %s = alloca %struct.bankwidth_st, align 4
  %0 = bitcast %struct.bankwidth_st* %s to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #5
  %field = getelementptr inbounds %struct.bankwidth_st, %struct.bankwidth_st* %s, i32 0, i32 0
  ; CHECK-LLVM: %[[FLD_BWD_SCT:.*]] = getelementptr inbounds %struct.bankwidth_st, %struct.bankwidth_st* %{{[a-zA-Z0-9]+}}, i32 0, i32 0
  ; CHECK-LLVM: call i32* @llvm.ptr.annotation.p0i32{{.*}}%[[FLD_BWD_SCT]]{{.*}}[[STR_BWD_SCT]]
  %1 = call i32* @llvm.ptr.annotation.p0i32(i32* %field, i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.5, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i32 0, i32 0), i32 32, i8* null)
  store i32 0, i32* %1, align 4, !tbaa !19
  %2 = bitcast %struct.bankwidth_st* %s to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #5
  ret void
}

; Function Attrs: norecurse nounwind
define linkonce_odr spir_func void @_Z26templ_field_bankwidth_attrILi4EEvv() #3 {
entry:
  %s = alloca %struct.templ_bankwidth_st, align 4
  %0 = bitcast %struct.templ_bankwidth_st* %s to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #5
  ; CHECK-LLVM: %[[FLD_BWD_STE:.*]] = getelementptr inbounds %struct.templ_bankwidth_st, %struct.templ_bankwidth_st* %{{[a-zA-Z0-9]+}}, i32 0, i32 0
  ; CHECK-LLVM: call i32* @llvm.ptr.annotation.p0i32{{.*}}%[[FLD_BWD_STE]]{{.*}}[[STR_BWD_STE]]
  %field = getelementptr inbounds %struct.templ_bankwidth_st, %struct.templ_bankwidth_st* %s, i32 0, i32 0
  %1 = call i32* @llvm.ptr.annotation.p0i32(i32* %field, i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.6, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i32 0, i32 0), i32 40, i8* null)
  store i32 0, i32* %1, align 4, !tbaa !21
  %2 = bitcast %struct.templ_bankwidth_st* %s to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #5
  ret void
}

; Function Attrs: norecurse nounwind
define spir_func void @_Z25field_private_copies_attrv() #3 {
entry:
  %s = alloca %struct.private_copies_st, align 4
  %0 = bitcast %struct.private_copies_st* %s to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #5
  ; CHECK-LLVM: %[[FLD_PRC_SCT:.*]] = getelementptr inbounds %struct.private_copies_st, %struct.private_copies_st* %{{[a-zA-Z0-9]+}}, i32 0, i32 0
  ; CHECK-LLVM: call i32* @llvm.ptr.annotation.p0i32{{.*}}%[[FLD_PRC_SCT]]{{.*}}[[STR_PRC_SCT]]
  %field = getelementptr inbounds %struct.private_copies_st, %struct.private_copies_st* %s, i32 0, i32 0
  %1 = call i32* @llvm.ptr.annotation.p0i32(i32* %field, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @.str.7, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i32 0, i32 0), i32 47, i8* null)
  store i32 0, i32* %1, align 4, !tbaa !23
  %2 = bitcast %struct.private_copies_st* %s to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #5
  ret void
}

; Function Attrs: norecurse nounwind
define linkonce_odr spir_func void @_Z31templ_field_private_copies_attrILi2EEvv() #3 {
entry:
  %s = alloca %struct.templ_private_copies_st, align 4
  %0 = bitcast %struct.templ_private_copies_st* %s to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #5
  ; CHECK-LLVM: %[[FLD_PRC_STE:.*]] = getelementptr inbounds %struct.templ_private_copies_st, %struct.templ_private_copies_st* %{{[a-zA-Z0-9]+}}, i32 0, i32 0
  ; CHECK-LLVM: call i32* @llvm.ptr.annotation.p0i32{{.*}}%[[FLD_PRC_STE]]{{.*}}[[STR_PRC_STE]]
  %field = getelementptr inbounds %struct.templ_private_copies_st, %struct.templ_private_copies_st* %s, i32 0, i32 0
  %1 = call i32* @llvm.ptr.annotation.p0i32(i32* %field, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @.str.8, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i32 0, i32 0), i32 55, i8* null)
  store i32 0, i32* %1, align 4, !tbaa !25
  %2 = bitcast %struct.templ_private_copies_st* %s to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #5
  ret void
}

; Function Attrs: norecurse nounwind
define spir_func void @_Z21field_singlepump_attrv() #3 {
entry:
  %s = alloca %struct.singlepump_st, align 4
  %0 = bitcast %struct.singlepump_st* %s to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #5
  ; CHECK-LLVM: %[[FLD_SNP_SCT:.*]] = getelementptr inbounds %struct.singlepump_st, %struct.singlepump_st* %{{[a-zA-Z0-9]+}}, i32 0, i32 0
  ; CHECK-LLVM: call i32* @llvm.ptr.annotation.p0i32{{.*}}%[[FLD_SNP_SCT]]{{.*}}[[STR_SNP_SCT]]
  %field = getelementptr inbounds %struct.singlepump_st, %struct.singlepump_st* %s, i32 0, i32 0
  %1 = call i32* @llvm.ptr.annotation.p0i32(i32* %field, i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.9, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i32 0, i32 0), i32 62, i8* null)
  store i32 0, i32* %1, align 4, !tbaa !27
  %2 = bitcast %struct.singlepump_st* %s to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #5
  ret void
}

; Function Attrs: norecurse nounwind
define spir_func void @_Z21field_doublepump_attrv() #3 {
entry:
  %s = alloca %struct.doublepump_st, align 4
  %0 = bitcast %struct.doublepump_st* %s to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #5
  ; CHECK-LLVM: %[[FLD_DBP_SCT:.*]] = getelementptr inbounds %struct.doublepump_st, %struct.doublepump_st* %{{[a-zA-Z0-9]+}}, i32 0, i32 0
  ; CHECK-LLVM: call i32* @llvm.ptr.annotation.p0i32{{.*}}%[[FLD_DBP_SCT]]{{.*}}[[STR_DBP_SCT]]
  %field = getelementptr inbounds %struct.doublepump_st, %struct.doublepump_st* %s, i32 0, i32 0
  %1 = call i32* @llvm.ptr.annotation.p0i32(i32* %field, i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.10, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i32 0, i32 0), i32 69, i8* null)
  store i32 0, i32* %1, align 4, !tbaa !29
  %2 = bitcast %struct.doublepump_st* %s to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #5
  ret void
}

; Function Attrs: norecurse nounwind
define spir_func void @_Z16field_merge_attrv() #3 {
entry:
  %s = alloca %struct.merge_st, align 4
  %0 = bitcast %struct.merge_st* %s to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #5
  ; CHECK-LLVM: %[[FLD_MRG_SCT:.*]] = getelementptr inbounds %struct.merge_st, %struct.merge_st* %{{[a-zA-Z0-9]+}}, i32 0, i32 0
  ; CHECK-LLVM: call i32* @llvm.ptr.annotation.p0i32{{.*}}%[[FLD_MRG_SCT]]{{.*}}[[STR_MRG_SCT]]
  %field = getelementptr inbounds %struct.merge_st, %struct.merge_st* %s, i32 0, i32 0
  %1 = call i32* @llvm.ptr.annotation.p0i32(i32* %field, i8* getelementptr inbounds ([49 x i8], [49 x i8]* @.str.11, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i32 0, i32 0), i32 76, i8* null)
  store i32 0, i32* %1, align 4, !tbaa !31
  %2 = bitcast %struct.merge_st* %s to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #5
  ret void
}

; Function Attrs: norecurse nounwind
define spir_func void @_Z25field_max_replicates_attrv() #3 {
entry:
  %s = alloca %struct.max_replicates_st, align 4
  %0 = bitcast %struct.max_replicates_st* %s to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #5
  ; CHECK-LLVM: %[[FLD_MXR_SCT:.*]] = getelementptr inbounds %struct.max_replicates_st, %struct.max_replicates_st* %{{[a-zA-Z0-9]+}}, i32 0, i32 0
  ; CHECK-LLVM: call i32* @llvm.ptr.annotation.p0i32{{.*}}%[[FLD_MXR_SCT]]{{.*}}[[STR_MXR_SCT]]
  %field = getelementptr inbounds %struct.max_replicates_st, %struct.max_replicates_st* %s, i32 0, i32 0
  %1 = call i32* @llvm.ptr.annotation.p0i32(i32* %field, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.12, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i32 0, i32 0), i32 83, i8* null)
  store i32 0, i32* %1, align 4, !tbaa !33
  %2 = bitcast %struct.max_replicates_st* %s to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #5
  ret void
}

; Function Attrs: norecurse nounwind
define linkonce_odr spir_func void @_Z31templ_field_max_replicates_attrILi2EEvv() #3 {
entry:
  %s = alloca %struct.templ_max_replicates_st, align 4
  %0 = bitcast %struct.templ_max_replicates_st* %s to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #5
  ; CHECK-LLVM: %[[FLD_MXR_STE:.*]] = getelementptr inbounds %struct.templ_max_replicates_st, %struct.templ_max_replicates_st* %{{[a-zA-Z0-9]+}}, i32 0, i32 0
  ; CHECK-LLVM: call i32* @llvm.ptr.annotation.p0i32{{.*}}%[[FLD_MXR_STE]]{{.*}}[[STR_MXR_STE]]
  %field = getelementptr inbounds %struct.templ_max_replicates_st, %struct.templ_max_replicates_st* %s, i32 0, i32 0
  %1 = call i32* @llvm.ptr.annotation.p0i32(i32* %field, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.13, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i32 0, i32 0), i32 91, i8* null)
  store i32 0, i32* %1, align 4, !tbaa !35
  %2 = bitcast %struct.templ_max_replicates_st* %s to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #5
  ret void
}

; Function Attrs: norecurse nounwind
define spir_func void @_Z27field_simple_dual_port_attrv() #3 {
entry:
  %s = alloca %struct.simple_dual_port_st, align 4
  %0 = bitcast %struct.simple_dual_port_st* %s to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #5
  ; CHECK-LLVM: %[[FLD_SDP_SCT:.*]] = getelementptr inbounds %struct.simple_dual_port_st, %struct.simple_dual_port_st* %{{[a-zA-Z0-9]+}}, i32 0, i32 0
  ; CHECK-LLVM: call i32* @llvm.ptr.annotation.p0i32{{.*}}%[[FLD_SDP_SCT]]{{.*}}[[STR_SDP_SCT]]
  %field = getelementptr inbounds %struct.simple_dual_port_st, %struct.simple_dual_port_st* %s, i32 0, i32 0
  %1 = call i32* @llvm.ptr.annotation.p0i32(i32* %field, i8* getelementptr inbounds ([49 x i8], [49 x i8]* @.str.14, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i32 0, i32 0), i32 98, i8* null)
  store i32 0, i32* %1, align 4, !tbaa !37
  %2 = bitcast %struct.simple_dual_port_st* %s to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #5
  ret void
}

; Function Attrs: norecurse nounwind
define spir_func void @_Z20field_bank_bits_attrv() #3 {
entry:
  %s = alloca %struct.bank_bits_st, align 4
  %0 = bitcast %struct.bank_bits_st* %s to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #5
  ; CHECK-LLVM: %[[FLD_BBT_SCT:.*]] = getelementptr inbounds %struct.bank_bits_st, %struct.bank_bits_st* %{{[a-zA-Z0-9]+}}, i32 0, i32 0
  ; CHECK-LLVM: call i32* @llvm.ptr.annotation.p0i32{{.*}}%[[FLD_BBT_SCT]]{{.*}}[[STR_BBT_SCT]]
  %field = getelementptr inbounds %struct.bank_bits_st, %struct.bank_bits_st* %s, i32 0, i32 0
  %1 = call i32* @llvm.ptr.annotation.p0i32(i32* %field, i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.15, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i32 0, i32 0), i32 105, i8* null)
  store i32 0, i32* %1, align 4, !tbaa !39
  %2 = bitcast %struct.bank_bits_st* %s to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #5
  ret void
}

; Function Attrs: norecurse nounwind
define linkonce_odr spir_func void @_Z26templ_field_bank_bits_attrILi2ELi3EEvv() #3 {
entry:
  %s = alloca %struct.templ_bank_bits_st, align 4
  %0 = bitcast %struct.templ_bank_bits_st* %s to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #5
  ; CHECK-LLVM: %[[FLD_BBT_STE:.*]] = getelementptr inbounds %struct.templ_bank_bits_st, %struct.templ_bank_bits_st* %{{[a-zA-Z0-9]+}}, i32 0, i32 0
  ; CHECK-LLVM: call i32* @llvm.ptr.annotation.p0i32{{.*}}%[[FLD_BBT_STE]]{{.*}}[[STR_BBT_STE]]
  %field = getelementptr inbounds %struct.templ_bank_bits_st, %struct.templ_bank_bits_st* %s, i32 0, i32 0
  %1 = call i32* @llvm.ptr.annotation.p0i32(i32* %field, i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.16, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i32 0, i32 0), i32 113, i8* null)
  store i32 0, i32* %1, align 4, !tbaa !41
  %2 = bitcast %struct.templ_bank_bits_st* %s to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #5
  ret void
}

; Function Attrs: norecurse nounwind
define spir_func void @_Z27field_force_pow2_depth_attrv() #3 {
entry:
  %s = alloca %struct.force_pow2_depth_st, align 4
  %0 = bitcast %struct.force_pow2_depth_st* %s to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #5
  ; CHECK-LLVM: %[[FLD_FP2_SCT:.*]] = getelementptr inbounds %struct.force_pow2_depth_st, %struct.force_pow2_depth_st* %{{[a-zA-Z0-9]+}}, i32 0, i32 0
  ; CHECK-LLVM: call i32* @llvm.ptr.annotation.p0i32{{.*}}%[[FLD_FP2_SCT]]{{.*}}[[STR_FP2_SCT]]
  %field = getelementptr inbounds %struct.force_pow2_depth_st, %struct.force_pow2_depth_st* %s, i32 0, i32 0
  %1 = call i32* @llvm.ptr.annotation.p0i32(i32* %field, i8* getelementptr inbounds ([49 x i8], [49 x i8]* @.str.17, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i32 0, i32 0), i32 120, i8* null)
  store i32 0, i32* %1, align 4, !tbaa !43
  %2 = bitcast %struct.force_pow2_depth_st* %s to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #5
  ret void
}

; Function Attrs: norecurse nounwind
define linkonce_odr spir_func void @_Z33templ_field_force_pow2_depth_attrILi1EEvv() #3 {
entry:
  %s = alloca %struct.templ_force_pow2_depth_st, align 4
  %0 = bitcast %struct.templ_force_pow2_depth_st* %s to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #5
  ; CHECK-LLVM: %[[FLD_FP2_STE:.*]] = getelementptr inbounds %struct.templ_force_pow2_depth_st, %struct.templ_force_pow2_depth_st* %{{[a-zA-Z0-9]+}}, i32 0, i32 0
  ; CHECK-LLVM: call i32* @llvm.ptr.annotation.p0i32{{.*}}%[[FLD_FP2_STE]]{{.*}}[[STR_FP2_STE]]
  %field = getelementptr inbounds %struct.templ_force_pow2_depth_st, %struct.templ_force_pow2_depth_st* %s, i32 0, i32 0
  %1 = call i32* @llvm.ptr.annotation.p0i32(i32* %field, i8* getelementptr inbounds ([49 x i8], [49 x i8]* @.str.18, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i32 0, i32 0), i32 128, i8* null)
  store i32 0, i32* %1, align 4, !tbaa !45
  %2 = bitcast %struct.templ_force_pow2_depth_st* %s to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #5
  ret void
}

; Function Attrs: norecurse nounwind
define spir_func void @_Z20field_addrspace_castv() #3 {
entry:
  %state_var = alloca %struct.state, align 4
  %0 = bitcast %struct.state* %state_var to i8*
  call void @llvm.lifetime.start.p0i8(i64 32, i8* %0) #5
  call spir_func void @_ZZ20field_addrspace_castvEN5stateC1Ev(%struct.state* %state_var)
  ; CHECK-LLVM: %[[GEP:.*]] = getelementptr inbounds %struct.state, %struct.state* %state_var, i32 0, i32 0
  ; CHECK-LLVM: %[[CAST:.*]] = bitcast [8 x i32]* %[[GEP:.*]] to i8*
  ; CHECK-LLVM: %{{[0-9]+}} = call i8* @llvm.ptr.annotation.p0i8.p0i8(i8* %[[CAST]]{{.*}}[[STR_NMB_ASC]]
  %mem = getelementptr inbounds %struct.state, %struct.state* %state_var, i32 0, i32 0
  %1 = bitcast [8 x i32]* %mem to i8*
  %2 = call i8* @llvm.ptr.annotation.p0i8(i8* %1, i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.19, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i32 0, i32 0), i32 120, i8* null)
  %3 = bitcast i8* %2 to [8 x i32]*
  %arrayidx = getelementptr inbounds [8 x i32], [8 x i32]* %3, i32 0, i32 0
  store i32 42, i32* %arrayidx, align 4, !tbaa !12
  %4 = bitcast %struct.state* %state_var to i8*
  call void @llvm.lifetime.end.p0i8(i64 32, i8* %4) #5
  ret void
}

; Function Attrs: norecurse nounwind
define internal spir_func void @_ZZ20field_addrspace_castvEN5stateC1Ev(%struct.state* %this) unnamed_addr #3 align 2 {
entry:
  %this.addr = alloca %struct.state*, align 4
  store %struct.state* %this, %struct.state** %this.addr, align 4, !tbaa !5
  %this1 = load %struct.state*, %struct.state** %this.addr, align 4
  call spir_func void @_ZZ20field_addrspace_castvEN5stateC2Ev(%struct.state* %this1)
  ret void
}

; Function Attrs: norecurse nounwind
define internal spir_func void @_ZZ20field_addrspace_castvEN5stateC2Ev(%struct.state* %this) unnamed_addr #3 align 2 {
entry:
  %this.addr = alloca %struct.state*, align 4
  %i = alloca i32, align 4
  store %struct.state* %this, %struct.state** %this.addr, align 4, !tbaa !5
  %this1 = load %struct.state*, %struct.state** %this.addr, align 4
  %0 = bitcast i32* %i to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #5
  store i32 0, i32* %i, align 4, !tbaa !12
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i32, i32* %i, align 4, !tbaa !12
  %cmp = icmp slt i32 %1, 8
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond
  %2 = bitcast i32* %i to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #5
  br label %for.end

for.body:                                         ; preds = %for.cond
  %3 = load i32, i32* %i, align 4, !tbaa !12
  %mem = getelementptr inbounds %struct.state, %struct.state* %this1, i32 0, i32 0
  ; FIXME: currently llvm.ptr.annotation is not emitted for c'tors, need to fix it and add a check here
  %4 = bitcast [8 x i32]* %mem to i8*
  %5 = call i8* @llvm.ptr.annotation.p0i8(i8* %4, i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.19, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i32 0, i32 0), i32 120, i8* null)
  %6 = bitcast i8* %5 to [8 x i32]*
  %7 = load i32, i32* %i, align 4, !tbaa !12
  %arrayidx = getelementptr inbounds [8 x i32], [8 x i32]* %6, i32 0, i32 %7
  store i32 %3, i32* %arrayidx, align 4, !tbaa !12
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %8 = load i32, i32* %i, align 4, !tbaa !12
  %inc = add nsw i32 %8, 1
  store i32 %inc, i32* %i, align 4, !tbaa !12
  br label %for.cond

for.end:                                          ; preds = %for.cond.cleanup
  ret void
}

; Function Attrs: nounwind willreturn
declare i8* @llvm.ptr.annotation.p0i8(i8*, i8*, i8*, i32, i8*) #4

; Function Attrs: nounwind willreturn
declare i32* @llvm.ptr.annotation.p0i32(i32*, i8*, i8*, i32, i8*) #4

attributes #0 = { norecurse nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "sycl-module-id"="intel-fpga-local-struct.cpp" "uniform-work-group-size"="true" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { inlinehint norecurse nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { norecurse nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind willreturn }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0}
!opencl.spir.version = !{!1}
!spirv.Source = !{!2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, i32 2}
!2 = !{i32 4, i32 100000}
!3 = !{!"clang version 11.0.0"}
!4 = !{}
!5 = !{!6, !6, i64 0}
!6 = !{!"any pointer", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C++ TBAA"}
!9 = !{!10, !11, i64 0}
!10 = !{!"_ZTSZ19field_numbanks_attrvE11numbanks_st", !11, i64 0}
!11 = !{!"int", !7, i64 0}
!12 = !{!11, !11, i64 0}
!13 = !{!14, !11, i64 0}
!14 = !{!"_ZTSZ25templ_field_numbanks_attrILi8EEvvE17templ_numbanks_st", !11, i64 0}
!15 = !{!16, !11, i64 0}
!16 = !{!"_ZTSZ19field_register_attrvE11register_st", !11, i64 0}
!17 = !{!18, !11, i64 0}
!18 = !{!"_ZTSZ17field_memory_attrvE9memory_st", !11, i64 0}
!19 = !{!20, !11, i64 0}
!20 = !{!"_ZTSZ20field_bankwidth_attrvE12bankwidth_st", !11, i64 0}
!21 = !{!22, !11, i64 0}
!22 = !{!"_ZTSZ26templ_field_bankwidth_attrILi4EEvvE18templ_bankwidth_st", !11, i64 0}
!23 = !{!24, !11, i64 0}
!24 = !{!"_ZTSZ25field_private_copies_attrvE17private_copies_st", !11, i64 0}
!25 = !{!26, !11, i64 0}
!26 = !{!"_ZTSZ31templ_field_private_copies_attrILi2EEvvE23templ_private_copies_st", !11, i64 0}
!27 = !{!28, !11, i64 0}
!28 = !{!"_ZTSZ21field_singlepump_attrvE13singlepump_st", !11, i64 0}
!29 = !{!30, !11, i64 0}
!30 = !{!"_ZTSZ21field_doublepump_attrvE13doublepump_st", !11, i64 0}
!31 = !{!32, !11, i64 0}
!32 = !{!"_ZTSZ16field_merge_attrvE8merge_st", !11, i64 0}
!33 = !{!34, !11, i64 0}
!34 = !{!"_ZTSZ25field_max_replicates_attrvE17max_replicates_st", !11, i64 0}
!35 = !{!36, !11, i64 0}
!36 = !{!"_ZTSZ31templ_field_max_replicates_attrILi2EEvvE23templ_max_replicates_st", !11, i64 0}
!37 = !{!38, !11, i64 0}
!38 = !{!"_ZTSZ27field_simple_dual_port_attrvE19simple_dual_port_st", !11, i64 0}
!39 = !{!40, !11, i64 0}
!40 = !{!"_ZTSZ20field_bank_bits_attrvE12bank_bits_st", !11, i64 0}
!41 = !{!42, !11, i64 0}
!42 = !{!"_ZTSZ26templ_field_bank_bits_attrILi2ELi3EEvvE18templ_bank_bits_st", !11, i64 0}
!43 = !{!44, !11, i64 0}
!44 = !{!"_ZTSZ27field_force_pow2_depth_attrvE19force_pow2_depth_st", !11, i64 0}
!45 = !{!46, !11, i64 0}
!46 = !{!"_ZTSZ33templ_field_force_pow2_depth_attrILi1EEvvE25templ_force_pow2_depth_st", !11, i64 0}
