import Pkg; Pkg.activate(".")
using Unitful, Plots, CurveFit

const g = 9.81u"m/s^2"

mu = 15.59u"mg/cm"

L = 112.0u"cm"



m1 = 551u"g"

T1 = m1*g
T1 = uconvert(u"N", T1)

f1 = [26.5
      53
      80
      107
      134.5
      161] .* u"Hz"

n1 = collect(1:6)

lam1 = 2L ./n1
lam1 = uconvert.(u"m", lam1)

lam1_inv = 1 ./ lam1

v1_meas = lam1 .* f1
v1_meas = uconvert.(u"m/s", v1_meas)

v1_calc = sqrt(T1 / mu)
v1_calc = uconvert(u"m/s", v1_calc)

v1_err = v1_meas ./ v1_calc .- 1



f2 = 58.0u"Hz"

m2 = [.622
      .285
      .160
      .100
      .066] .* u"kg"

T2 = m2 .* g
T2 = uconvert.(u"N", T2)

n2 = collect(2:6)

lam2 = 2L ./ n2
lam2 = uconvert.(u"m", lam2)

v2_meas = lam2 .* f2
v2_meas = uconvert.(u"m/s", v2_meas)

v2_calc = sqrt.(T2 ./ mu)
v2_calc = uconvert.(u"m/s", v2_calc)

v2_err = v2_meas ./ v2_calc .- 1



reg1 = linear_fit(f1, lam1_inv)

