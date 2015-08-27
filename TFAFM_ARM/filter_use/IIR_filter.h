//LPF
//define number of 2nd-order stages
#define N (3)

const double Lb[N][3] = { /*numerator coefficients */
{ 0.228803890293,  0.228803890293, 0.000000000000}, /*b01, b11, b21 */
{ 0.696404257411,  0.327742087706, 0.696404257411}, /*b02, b12, b22 */
{ 0.450162648212,  0.555984977119,  0.450162648212}  /*b03, b13, b23 */
};
const double La[N][2] = { /*denominator coefficients*/
{-0.024458604736,  0.000000000000}, /*a11, a21 */
{-0.428276325884,  0.614919704567}, /*a12, a22 */
{-0.168010775478,  0.158497913712}  /*a13, a23 */
};
//double scalevalue =  1.000000000000; /* final output scale value */
/*******************************************************************/
//HPF
//define number of 2nd-order N
//#define N 3
double Hb[N][3] = { /*numerator coefficients */
{ 0.228803890293,  0.228803890293, 0.000000000000}, /*b01, b11, b21 */
{ 0.696404257411,  0.327742087706, 0.696404257411}, /*b02, b12, b22 */
{ 0.450162648212,  0.555984977119,  0.450162648212}  /*b03, b13, b23 */
};
 double Ha[N][2] = { /*denominator coefficients*/
{-0.024458604736,  0.000000000000}, /*a11, a21 */
{-0.428276325884,  0.614919704567}, /*a12, a22 */
{-0.168010775478,  0.158497913712}  /*a13, a23 */
};

//----------convert
double La0[N],La1[N],Lb0[N],Lb1[N],Lb2[N];
double Ha0[N],Ha1[N],Hb0[N],Hb1[N],Hb2[N];

for (int k=0;k<N;k++)
{
	La0[k]=La[k][0];
	La1[k]=La[k][1];
	Lb0[k]=Lb[k][0];
	Lb1[k]=Lb[k][1];
	Lb2[k]=Lb[k][2];

	Ha0[k]=Ha[k][0];
	Ha1[k]=Ha[k][1];
	Hb0[k]=Hb[k][0];
	Hb1[k]=Hb[k][1];
	Hb2[k]=Hb[k][2];	
}



double IIR_filter_unused(double input,double* a,double *b)
{
double wn, input;
double result = 0; //initialize the accumulator
 //Biquad section filtering stage-by-stage
 //using a double accumulator.
 for (int i = 0; i < N; i++)
 {
 //2nd-order LCCDE code
 wn = input - a[i][0] * dbf[i][0] - a[i][1] * dbf[i][1]; //8.8
 result = b[i][0]*wn + b[i][1]*dbf[i][0] + b[i][2]*dbf[i][1]; //8.9
 //Update filter buffers for stage i
 dbf[i][1] = dbf[i][0];
 dbf[i][0] = wn;
 input = result; /*in case we have to loop again*/
 }
 //result *= scalevalue; //Apply cascade final stage scale factor
return result;
}

double IIR_filter_HPF(double input)
{

const double Ha0[N]=
{0.226395357685043,
0.0187037918273417,
-0.0404326893752033,
};
const double Ha1[N]=
{0.606633166651684,
0.153377180801087,
0
};

const double Hb0[N]=
{0.509810680512777,
0.335401664868460,
0.520216344687602
};
const double Hb1[N]=
{-0.360616447941088,
-0.463870059236825,
-0.520216344687602
};
const double Hb2[N]=
{
0.509810680512777,
0.335401664868460,
0
};

static double Hbuf0[N],Hbuf1[N]; //buffer for delay samples LPF
return IIR_filter(input,N,Hbuf0,Hbuf1,La0,La1,Lb0,Lb1,Lb2);
}
double IIR_filter_LPF(double input)
{
const double La0[N]=
{-0.428276325883684,
-0.168010775478271,
-0.0244586047360019
};
const double La1[N]=
{0.614919704567223,
0.158497913712364,
0
};

const double Lb0[N]=
{0.226039837317933,
0.378144670742543,
0.487770697631999
};
const double Lb1[N]=
{
0.226039837317933,
0.378144670742543,
0.487770697631999
};
const double Lb2[N]=
{
0.480301770682803,
0.306171233745775,
0
};
static double Lbuf0[N],Lbuf1[N]; //buffer for delay samples LPF
return IIR_filter(input,N,Lbuf0,Lbuf1,La0,La1,Lb0,Lb1,Lb2);
}
double IIR_filter(double input,int order,double* buf0,double* buf1, double* a0,double* a1,double *b0,double * b1, double *b2)
{
double wn=0;
double result = 0; //initialize the accumulator
 //Biquad section filtering stage-by-stage
 //using a double accumulator.
 for (int i = 0; i < order; i++)
 {
 //2nd-order LCCDE code
 wn = input - a0[i] * buf0[i] - a1[i] * buf1[i];
 result = b0[i]*wn + b1[i]*buf0[i] + b2[i]*buf1[i];
 //Update filter buffers for stage i
	buf1[i]=buf0[i];
	buf0[i] = wn;
	input = result; /*in case we have to loop again*/
 }
 //result *= scalevalue; //Apply cascade final stage scale factor
return result;
}