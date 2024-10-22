import Pkg; Pkg.activate(".")
using Unitful, Plots, CurveFit, LaTeXStrings

default(show=true)

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

T2_log = log.(T2 * u"N^-1")

n2 = collect(2:6)

lam2 = 2L ./ n2
lam2 = uconvert.(u"m", lam2)

v2_meas = lam2 .* f2
v2_meas = uconvert.(u"m/s", v2_meas)

v2_log = log.(v2_meas * u"s/m")

v2_calc = sqrt.(T2 ./ mu)
v2_calc = uconvert.(u"m/s", v2_calc)

v2_err = v2_meas ./ v2_calc .- 1


println(T2_log)
println(v2_log)


reg1 = linear_fit(f1, lam1_inv)
reg_display = round(typeof(.1u"s/m"), uconvert(u"s/m", reg1[2]), digits=5)



#println(reg1[2]*v1_calc)
#println(1/v1_calc)


scatter(f1, lam1_inv, label=L"(\lambda^{-1}, f)")

f1p = [f1[1], f1[6]]

#regression values done manually as formatting workaround
plot!(f1p, f1p .* reg1[2] .+ reg1[1], label=L"$R=0.01655$ s/m $=0.9745\sqrt{\mu/T}$")

xlabel!(L"inverse wavelength (m$^{-1}$)")
ylabel!("frequency (Hz)")
title!("Linearization of Table 1")


savefig("lab1-graph1.svg")
#readline()


reg2 = linear_fit(T2_log, v2_log)
println(reg2)

scatter(T2_log, v2_log, label=L"(\ln\frac{T}{1N}, \ln\frac{v_{meas}}{1m/s})")

T2p = [T2_log[1], T2_log[5]]
plot!(T2p, T2p .* reg2[2] .+ reg2[1], label=L"y=3.273+0.4913x")

xlabel!("tension (N, log)")
ylabel!("measured wave speed (m/s, log)")
title!("Linearization of Table 2")

savefig("lab1-graph2.svg")

#readline()
