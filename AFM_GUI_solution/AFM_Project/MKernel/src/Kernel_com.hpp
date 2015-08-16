#ifndef _MKernel_Kernel_com_HPP
#define _MKernel_Kernel_com_HPP 1

#include <windows.h>
#include "MKernel_idl.h"
#include "mclmcrrt.h"
#include "mclcom.h"
#include "mclcommain.h"
#include "mclcomclass.h"

class CKernel : public CMCLClassImpl<IKernel, &IID_IKernel, CKernel, &CLSID_Kernel>
{
public:
  CKernel();
  ~CKernel();

  HRESULT __stdcall AFM_dip_for_show(/*[in]*/long nargout, /*[in,out]*/VARIANT* 
                                     image_show_buffer, /*[in,out]*/VARIANT* im_buffer, 
                                     /*[in]*/VARIANT im_buffer_in1, /*[in]*/VARIANT 
                                     point_now_x, /*[in]*/VARIANT point_now_y); 

  HRESULT __stdcall AFM_dip_show_image(/*[in]*/long nargout, /*[in,out]*/VARIANT* out, 
                                       /*[in]*/VARIANT imHL, /*[in]*/VARIANT imHR, 
                                       /*[in]*/VARIANT imEL, /*[in]*/VARIANT imER, 
                                       /*[in]*/VARIANT point_now_x, /*[in]*/VARIANT 
                                       point_now_y, /*[in]*/VARIANT str); 

  HRESULT __stdcall AFM_dip_show_image_from_txt(); 

  HRESULT __stdcall AFM_scan_set_ROI(/*[in]*/long nargout, /*[in,out]*/VARIANT* position, 
                                     /*[in]*/VARIANT im_buffer, /*[in]*/VARIANT 
                                     position_in1); 

  HRESULT __stdcall AFM_show_indent_data(); 

  HRESULT __stdcall StringEval(/*[in]*/long nargout, /*[in,out]*/VARIANT* out_str, 
                               /*[in,out]*/VARIANT* out_data, /*[in]*/VARIANT in_str, 
                               /*[in]*/VARIANT in_data); 

  HRESULT __stdcall MCRWaitForFigures();

};
#endif
