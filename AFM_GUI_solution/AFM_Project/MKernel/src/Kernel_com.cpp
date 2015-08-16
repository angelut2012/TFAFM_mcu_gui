#include "Kernel_com.hpp"


CKernel::CKernel()
{
  g_pModule->InitializeComponentInstanceEx(&m_hinst);
}
CKernel::~CKernel()
{
  if (m_hinst)
    g_pModule->TerminateInstance(&m_hinst);
}


HRESULT __stdcall CKernel::AFM_dip_for_show(/*[in]*/long nargout, /*[in,out]*/VARIANT* 
                                            image_show_buffer, /*[in,out]*/VARIANT* 
                                            im_buffer, /*[in]*/VARIANT im_buffer_in1, 
                                            /*[in]*/VARIANT point_now_x, /*[in]*/VARIANT 
                                            point_now_y) {
  return( CallComFcn( "AFM_dip_for_show", (int) nargout, 2, 3, image_show_buffer, 
                      im_buffer, &im_buffer_in1, &point_now_x, &point_now_y ) );
}


HRESULT __stdcall CKernel::AFM_dip_show_image(/*[in]*/long nargout, /*[in,out]*/VARIANT* 
                                              out, /*[in]*/VARIANT imHL, /*[in]*/VARIANT 
                                              imHR, /*[in]*/VARIANT imEL, /*[in]*/VARIANT 
                                              imER, /*[in]*/VARIANT point_now_x, 
                                              /*[in]*/VARIANT point_now_y, 
                                              /*[in]*/VARIANT str) {
  return( CallComFcn( "AFM_dip_show_image", (int) nargout, 1, 7, out, &imHL, &imHR, 
                      &imEL, &imER, &point_now_x, &point_now_y, &str ) );
}


HRESULT __stdcall CKernel::AFM_dip_show_image_from_txt() {
  return( CallComFcn( "AFM_dip_show_image_from_txt", 0, 0, 0 ) );
}


HRESULT __stdcall CKernel::AFM_scan_set_ROI(/*[in]*/long nargout, /*[in,out]*/VARIANT* 
                                            position, /*[in]*/VARIANT im_buffer, 
                                            /*[in]*/VARIANT position_in1) {
  return( CallComFcn( "AFM_scan_set_ROI", (int) nargout, 1, 2, position, &im_buffer, 
                      &position_in1 ) );
}


HRESULT __stdcall CKernel::AFM_show_indent_data() {
  return( CallComFcn( "AFM_show_indent_data", 0, 0, 0 ) );
}


HRESULT __stdcall CKernel::StringEval(/*[in]*/long nargout, /*[in,out]*/VARIANT* out_str, 
                                      /*[in,out]*/VARIANT* out_data, /*[in]*/VARIANT 
                                      in_str, /*[in]*/VARIANT in_data) {
  return( CallComFcn( "StringEval", (int) nargout, 2, 2, out_str, out_data, &in_str, 
                      &in_data ) );
}

HRESULT __stdcall CKernel::MCRWaitForFigures()
{
  mclWaitForFiguresToDie(m_hinst);
  return(S_OK);
}
