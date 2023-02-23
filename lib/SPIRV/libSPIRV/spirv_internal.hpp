// Copyright (c) 2020 The Khronos Group Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and/or associated documentation files (the "Materials"),
// to deal in the Materials without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Materials, and to permit persons to whom the
// Materials are furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Materials.
//
// THE MATERIALS ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM,OUT OF OR IN CONNECTION WITH THE MATERIALS OR THE USE OR OTHER DEALINGS
// IN THE MATERIALS.

// The header is for SPIR-V to LLVM IR internal definitions, that are not a part
// of Khronos SPIR-V specification.

#include "spirv/unified1/spirv.hpp"

#ifndef spirv_internal_HPP
#define spirv_internal_HPP

namespace spv {
namespace internal {

enum InternalSourceLanguageNonSemanticDI {
  ISourceLanguagePython = 101,
  ISourceLanguageJulia = 102,
  ISourceLanguageRust = 103,
  ISourceLanguageD = 104,
  ISourceLanguageFortran95 = 105,
  ISourceLanguageFortran2003 = 106,
  ISourceLanguageFortran2008 = 107,
  ISourceLanguageC = 108,
  ISourceLanguageC99 = 109,
  ISourceLanguageC11 = 110,
  ISourceLanguageCPP = 111,
  ISourceLanguageCPP03 = 112,
  ISourceLanguageCPP11 = 113,
  ISourceLanguageCPP14 = 114,
  ISourceLanguageCPP17 = 115,
  ISourceLanguageCPP20 = 116,
};

enum InternalLinkageType {
  ILTPrev = LinkageTypeMax - 2,
  ILTInternal
};

enum InternalOp {
  IOpTypeTokenINTEL = 6113,
  IOpConvertFToBF16INTEL = 6116,
  IOpConvertBF16ToFINTEL = 6117,
  IOpTypeJointMatrixINTEL = 6119,
  IOpJointMatrixLoadINTEL = 6120,
  IOpJointMatrixStoreINTEL = 6121,
  IOpJointMatrixMadINTEL = 6122,
  IOpJointMatrixSUMadINTEL = 6128,
  IOpJointMatrixUSMadINTEL = 6129,
  IOpJointMatrixUUMadINTEL = 6130,
  IOpArithmeticFenceINTEL = 6145,
  IOpJointMatrixWorkItemLengthINTEL = 6410,
  IOpComplexFMulINTEL = 6415,
  IOpComplexFDivINTEL = 6416,
  IOpConvertFToTF32INTEL = 6426,
  IOpMaskedGatherINTEL = 6428,
  IOpMaskedScatterINTEL = 6429,
  IOpJointMatrixGetElementCoordINTEL = 6440,
  IOpPrev = OpMax - 2,
  IOpForward
};

enum InternalDecoration {
  IDecRuntimeAlignedINTEL = 5940,
  IDecCallableFunctionINTEL = 6087,
  IDecHostAccessINTEL = 6147,
  IDecInitModeINTEL = 6148,
  IDecImplementInCSRINTEL = 6149,
  IDecArgumentAttributeINTEL = 6409
};

enum InternalCapability {
  ICapFastCompositeINTEL = 6093,
  ICapOptNoneINTEL = 6094,
  ICapTokenTypeINTEL = 6112,
  ICapBfloat16ConversionINTEL = 6115,
  ICapabilityJointMatrixINTEL = 6118,
  ICapabilityHWThreadQueryINTEL = 6134,
  ICapFPArithmeticFenceINTEL = 6144,
  ICapGlobalVariableDecorationsINTEL = 6146,
  ICapabilityComplexFloatMulDivINTEL = 6414,
  ICapabilityTensorFloat32ConversionINTEL = 6425,
  ICapabilityMaskedGatherScatterINTEL = 6427,
  ICapabilityJointMatrixWIInstructionsINTEL = 6435
};

enum InternalFunctionControlMask { IFunctionControlOptNoneINTELMask = 0x10000 };

enum InternalExecutionMode {
  IExecModeFastCompositeKernelINTEL = 6088,
};

constexpr LinkageType LinkageTypeInternal =
    static_cast<LinkageType>(ILTInternal);

enum InternalJointMatrixLayout {
  RowMajor = 0,
  ColumnMajor = 1,
  PackedA = 2,
  PackedB = 3
};

enum InternalJointMatrixUse { MatrixA = 0, MatrixB = 1, Accumulator = 2 };

enum InternalBuiltIn {
  IBuiltInSubDeviceIDINTEL = 6135,
  IBuiltInGlobalHWThreadIDINTEL = 6136,
};

#define _SPIRV_OP(x, y) constexpr x x##y = static_cast<x>(I##x##y);
_SPIRV_OP(Capability, JointMatrixINTEL)
_SPIRV_OP(Capability, JointMatrixWIInstructionsINTEL)
_SPIRV_OP(Op, TypeJointMatrixINTEL)
_SPIRV_OP(Op, JointMatrixLoadINTEL)
_SPIRV_OP(Op, JointMatrixStoreINTEL)
_SPIRV_OP(Op, JointMatrixMadINTEL)
_SPIRV_OP(Op, JointMatrixSUMadINTEL)
_SPIRV_OP(Op, JointMatrixUSMadINTEL)
_SPIRV_OP(Op, JointMatrixUUMadINTEL)
_SPIRV_OP(Op, JointMatrixWorkItemLengthINTEL)
_SPIRV_OP(Op, JointMatrixGetElementCoordINTEL)

_SPIRV_OP(Capability, HWThreadQueryINTEL)
_SPIRV_OP(BuiltIn, SubDeviceIDINTEL)
_SPIRV_OP(BuiltIn, GlobalHWThreadIDINTEL)

_SPIRV_OP(Capability, ComplexFloatMulDivINTEL)
_SPIRV_OP(Op, ComplexFMulINTEL)
_SPIRV_OP(Op, ComplexFDivINTEL)

_SPIRV_OP(Capability, MaskedGatherScatterINTEL)
_SPIRV_OP(Op, MaskedGatherINTEL)
_SPIRV_OP(Op, MaskedScatterINTEL)

_SPIRV_OP(Capability, TensorFloat32ConversionINTEL)
_SPIRV_OP(Op, ConvertFToTF32INTEL)
#undef _SPIRV_OP

constexpr SourceLanguage SourceLanguagePython =
    static_cast<SourceLanguage>(ISourceLanguagePython);
constexpr SourceLanguage SourceLanguageJulia =
    static_cast<SourceLanguage>(ISourceLanguageJulia);
constexpr SourceLanguage SourceLanguageRust =
    static_cast<SourceLanguage>(ISourceLanguageRust);
constexpr SourceLanguage SourceLanguageD =
    static_cast<SourceLanguage>(ISourceLanguageD);
constexpr SourceLanguage SourceLanguageFortran95 =
    static_cast<SourceLanguage>(ISourceLanguageFortran95);
constexpr SourceLanguage SourceLanguageFortran2003 =
    static_cast<SourceLanguage>(ISourceLanguageFortran2003);
constexpr SourceLanguage SourceLanguageFortran2008 =
    static_cast<SourceLanguage>(ISourceLanguageFortran2008);
constexpr SourceLanguage SourceLanguageC =
    static_cast<SourceLanguage>(ISourceLanguageC);
constexpr SourceLanguage SourceLanguageC99 =
    static_cast<SourceLanguage>(ISourceLanguageC99);
constexpr SourceLanguage SourceLanguageC11 =
    static_cast<SourceLanguage>(ISourceLanguageC11);
constexpr SourceLanguage SourceLanguageCPP =
    static_cast<SourceLanguage>(ISourceLanguageCPP);
constexpr SourceLanguage SourceLanguageCPP03 =
    static_cast<SourceLanguage>(ISourceLanguageCPP03);
constexpr SourceLanguage SourceLanguageCPP11 =
    static_cast<SourceLanguage>(ISourceLanguageCPP11);
constexpr SourceLanguage SourceLanguageCPP14 =
    static_cast<SourceLanguage>(ISourceLanguageCPP14);
constexpr SourceLanguage SourceLanguageCPP17 =
    static_cast<SourceLanguage>(ISourceLanguageCPP17);
constexpr SourceLanguage SourceLanguageCPP20 =
    static_cast<SourceLanguage>(ISourceLanguageCPP20);

constexpr Op OpForward = static_cast<Op>(IOpForward);
constexpr Op OpTypeTokenINTEL = static_cast<Op>(IOpTypeTokenINTEL);
constexpr Op OpArithmeticFenceINTEL = static_cast<Op>(IOpArithmeticFenceINTEL);
constexpr Op OpConvertFToBF16INTEL = static_cast<Op>(IOpConvertFToBF16INTEL);
constexpr Op OpConvertBF16ToFINTEL = static_cast<Op>(IOpConvertBF16ToFINTEL);

constexpr Decoration DecorationCallableFunctionINTEL =
    static_cast<Decoration>(IDecCallableFunctionINTEL);
constexpr Decoration DecorationRuntimeAlignedINTEL =
    static_cast<Decoration>(IDecRuntimeAlignedINTEL);
constexpr Decoration DecorationHostAccessINTEL =
    static_cast<Decoration>(IDecHostAccessINTEL);
constexpr Decoration DecorationInitModeINTEL =
    static_cast<Decoration>(IDecInitModeINTEL);
constexpr Decoration DecorationImplementInCSRINTEL =
    static_cast<Decoration>(IDecImplementInCSRINTEL);
constexpr Decoration DecorationArgumentAttributeINTEL =
    static_cast<Decoration>(IDecArgumentAttributeINTEL);

constexpr Capability CapabilityFastCompositeINTEL =
    static_cast<Capability>(ICapFastCompositeINTEL);
constexpr Capability CapabilityOptNoneINTEL =
    static_cast<Capability>(ICapOptNoneINTEL);
constexpr Capability CapabilityTokenTypeINTEL =
    static_cast<Capability>(ICapTokenTypeINTEL);
constexpr Capability CapabilityFPArithmeticFenceINTEL =
    static_cast<Capability>(ICapFPArithmeticFenceINTEL);
constexpr Capability CapabilityBfloat16ConversionINTEL =
    static_cast<Capability>(ICapBfloat16ConversionINTEL);
constexpr Capability CapabilityGlobalVariableDecorationsINTEL =
    static_cast<Capability>(ICapGlobalVariableDecorationsINTEL);

constexpr FunctionControlMask FunctionControlOptNoneINTELMask =
    static_cast<FunctionControlMask>(IFunctionControlOptNoneINTELMask);

constexpr ExecutionMode ExecutionModeFastCompositeKernelINTEL =
    static_cast<ExecutionMode>(IExecModeFastCompositeKernelINTEL);

} // namespace internal
} // namespace spv

#endif // #ifndef spirv_internal_HPP
