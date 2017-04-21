## Report Day3

The idea was to implement a fast and precise approximation for $e^x$. The non-integer part is computed using Pade Approximation.

The code is the following:

```c
const double log2e = 1.44269504088896340735992;
double adv_pad_exp(double x){

   double  px, qx;
   const double y = log2e * x;

   const int iy = (int)(y + 0.5) - (x < -0.5); // integer part
   const double fy = (y - iy); // non-integer part

   // ----------- Non - Integer Part--------------
   const double ff = fy * fy;

   px = adv_pad_exp_p[1] + ff * adv_pad_exp_p[0];
   px = ff * px + adv_pad_exp_p[2];
   px = px * fy;

   qx = adv_pad_exp_p[3] + ff;
   qx = ff * qx + adv_pad_exp_p[4];

   const double fpart = 1. + 2.*px/(qx - px);

   if (iy >= 0) {
     return fpart * (1 << iy);
    }
   else{
     return fpart / (1 << -1*iy);
  }

  }
```

Running the code on Ulysses, the result are the following for different sizes of the interval

```
____________________________________
interval [-10,+10]
time/set for 1000 x-values :    0.038us
<x>: 0.0565471    <x**2> - <x>**2: 16.5517589247028
time for                 exp():   0.0483us  numreps 1
time for               t_exp():   0.0077us  avgerr  78283.2
time for             pad_exp():   0.0158us  avgerr  2.49411
time for         adv_pad_exp():   0.0200us  avgerr  7.92391e-17
________________________________________________
interval [-5,+5]
time/set for 1000 x-values :    0.034us
<x>: 0.0282736    <x**2> - <x>**2: 4.1379397311757
time for                 exp():   0.0535us  numreps 1
time for               t_exp():   0.0077us  avgerr  4.95862
time for             pad_exp():   0.0092us  avgerr  0.00229088
time for         adv_pad_exp():   0.0198us  avgerr  6.38155e-17
________________________________________________
[-2.5,+2.5]
time/set for 1000 x-values :  0.03375us
<x>: 0.0141368    <x**2> - <x>**2: 1.03448493279393
time for                 exp():   0.0540us  numreps 1
time for               t_exp():   0.0077us  avgerr  0.0027821
time for             pad_exp():   0.0092us  avgerr  3.13137e-06
time for         adv_pad_exp():   0.0190us  avgerr  1.17226e-16
________________________________________________
[-0.5,+0.5]
time/set for 1000 x-values :   0.0335us
<x>: 0.00282736    <x**2> - <x>**2: 0.041379397311757
time for                 exp():   0.0737us  numreps 1
time for               t_exp():   0.0077us  avgerr  2.28847e-09
time for             pad_exp():   0.0092us  avgerr  1.41518e-12
time for         adv_pad_exp():   0.0163us  avgerr  4.83051e-17
```
We can easily notice that the 'adv_pad_exp' is faster than the natural implementation but slower that the traditional 'pad_exp'. However, its precision is very high.
