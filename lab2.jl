import Pkg; Pkg.activate(".")
using Unitful, Plots, CurveFit, LaTeXStrings

# f1 = 383.5u"Hz"

# peaks1 = [4.5, 41,  ]

# zags1 = [[20, 27.5], [66.5, 76.5]]
#

f1 = 383.0u"Hz"

peaks1 = [7.5, 53.5] .* u"cm"

zags1 = [18.5, 34, 67]

# peaks2 = [19, 59]

f2 = 440.8u"Hz"

peaks2 = [4.5, 41.5, 67]

zags2 = [15.75, ]

f3 = 480.4u"Hz"

peaks3 = [5.5, 40, 76.5]

f4 = missing

peaks4 = [7.5, 41, 77.5]




fs = [f1,f2,f3]
lams = [92,75,69] .* u"cm"
lams_inv = uconvert.(u"m^-1", 1 ./ lams)

reg = linear_fit(fs, lams_inv)

scatter(fs, lams, show=true, label=false, xlabel="frequency", ylabel="wavelength", title="Resonant wavelengths for given frequencies")

savefig("lab2-graph1.svg")

readline()

scatter(fs, lams_inv, show=true, label=false, xlabel="frequency", ylabel="inverse wavelength")

plot!([f1,f3], [f1*reg[2]+reg[1], f3*reg[2]+reg[1]], label=L"1/\lambda = \frac{1.27}{v_{mean}}f - \frac{0.260}{\lambda_{mean}}", title="Linearization of wavelengths and frequencies")

savefig("lab2-graph2.svg")

readline()
