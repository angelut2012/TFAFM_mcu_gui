

/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


 /* File created by MIDL compiler version 8.00.0595 */
/* at Thu Aug 27 01:57:07 2015
 */
/* Compiler settings for F:\Dropbox\TF_AFM_develop\software_TFAFM_Arduino_embeded\TFAFM_mcu_gui\AFM_GUI_solution\AFM_Project\MKernel\src\MKernel_idl.idl:
    Oicf, W1, Zp8, env=Win64 (32b run), target_arch=IA64 8.00.0595 
    protocol : dce , ms_ext, c_ext, robust
    error checks: allocation ref bounds_check enum stub_data 
    VC __declspec() decoration level: 
         __declspec(uuid()), __declspec(selectany), __declspec(novtable)
         DECLSPEC_UUID(), MIDL_INTERFACE()
*/
/* @@MIDL_FILE_HEADING(  ) */

#pragma warning( disable: 4049 )  /* more than 64k source lines */


#ifdef __cplusplus
extern "C"{
#endif 


#include <rpc.h>
#include <rpcndr.h>

#ifdef _MIDL_USE_GUIDDEF_

#ifndef INITGUID
#define INITGUID
#include <guiddef.h>
#undef INITGUID
#else
#include <guiddef.h>
#endif

#define MIDL_DEFINE_GUID(type,name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) \
        DEFINE_GUID(name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8)

#else // !_MIDL_USE_GUIDDEF_

#ifndef __IID_DEFINED__
#define __IID_DEFINED__

typedef struct _IID
{
    unsigned long x;
    unsigned short s1;
    unsigned short s2;
    unsigned char  c[8];
} IID;

#endif // __IID_DEFINED__

#ifndef CLSID_DEFINED
#define CLSID_DEFINED
typedef IID CLSID;
#endif // CLSID_DEFINED

#define MIDL_DEFINE_GUID(type,name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) \
        const type name = {l,w1,w2,{b1,b2,b3,b4,b5,b6,b7,b8}}

#endif !_MIDL_USE_GUIDDEF_

MIDL_DEFINE_GUID(IID, IID_IKernel,0x848F257E,0x513A,0x4C86,0xB9,0xEA,0xE9,0xFD,0xF6,0xC9,0x48,0xED);


MIDL_DEFINE_GUID(IID, LIBID_MKernel,0xE415471C,0x31D4,0x46F2,0x8A,0xB8,0x59,0xFB,0x64,0xDC,0x48,0x0B);


MIDL_DEFINE_GUID(CLSID, CLSID_Kernel,0x273B796E,0x94D7,0x44A8,0xBC,0x0F,0x06,0x8F,0x10,0xE9,0x7D,0x75);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



