//LPF
//define number of 2nd-order stages
#define STAGES 3
float b[STAGES][3] = { /*numerator coefficients */
{ 0.228803890293,  0.228803890293, 0.000000000000}, /*b01, b11, b21 */
{ 0.696404257411,  0.327742087706, 0.696404257411}, /*b02, b12, b22 */
{ 0.450162648212,  0.555984977119,  0.450162648212}  /*b03, b13, b23 */
};
float a[STAGES][2] = { /*denominator coefficients*/
{-0.024458604736,  0.000000000000}, /*a11, a21 */
{-0.428276325884,  0.614919704567}, /*a12, a22 */
{-0.168010775478,  0.158497913712}  /*a13, a23 */
};
float scalevalue =  1.000000000000; /* final output scale value */
/*******************************************************************/
//HPF
//define number of 2nd-order stages
//#define STAGES 3
float b[STAGES][3] = { /*numerator coefficients */
{ 0.228803890293,  0.228803890293, 0.000000000000}, /*b01, b11, b21 */
{ 0.696404257411,  0.327742087706, 0.696404257411}, /*b02, b12, b22 */
{ 0.450162648212,  0.555984977119,  0.450162648212}  /*b03, b13, b23 */
};
float a[STAGES][2] = { /*denominator coefficients*/
{-0.024458604736,  0.000000000000}, /*a11, a21 */
{-0.428276325884,  0.614919704567}, /*a12, a22 */
{-0.168010775478,  0.158497913712}  /*a13, a23 */
};
float scalevalue =  1.000000000000; /* final output scale value */
/*******************************************************************/



double dly[STAGES][2]; //buffer for delay samples
double IIR_filter(double input)
{
double wn, input;
double result = 0; //initialize the accumulator
 //Biquad section filtering stage-by-stage
 //using a float accumulator.
 for (int i = 0; i < STAGES; i++)
 {
 //2nd-order LCCDE code
 wn = input - a[i][0] * dly[i][0] - a[i][1] * dly[i][1]; //8.8
 result = b[i][0]*wn + b[i][1]*dly[i][0] + b[i][2]*dly[i][1]; //8.9
 //Update filter buffers for stage i
 dly[i][1] = dly[i][0];
 dly[i][0] = wn;
 input = result; /*in case we have to loop again*/
 }
 //result *= scalevalue; //Apply cascade final stage scale factor
return result;
}