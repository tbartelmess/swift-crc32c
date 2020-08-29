import CIntelCRC

#if arch(x86_64)
import _Builtin_intrinsics.intel.cpuid
#endif


#if arch(x86_64)
/// Returns if the current CPU supports the SSE 4.2 instruction set.
/// - Returns: A boolean indicating if SSE 4.2 is supported
func hasSSE42() -> Bool {
    var eax: UInt32 = 0
    var ebx: UInt32 = 0
    var ecx: UInt32 = 0
    var edx: UInt32 = 0
    __get_cpuid(1, &eax, &ebx, &ecx, &edx)
    return (ecx & UInt32(bit_SSE42)) == bit_SSE42
}
#else
func hasSSE42() -> Bool {
    return false
}
#endif
