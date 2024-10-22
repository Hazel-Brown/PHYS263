using CSV, DataFrames, Plots, JuMP, Random

file1 = CSV.File("intensity.tsv")

intensity = file1 |> DataFrame |> Matrix

ds_ = intensity[:,1]
is_ = intensity[:,2]
xs_ = 0.4:0.001:1

p_ideal = 1
a_ideal = .4^p_ideal
A_ideal = 0.07
w_ideal = 0.015
phi_ideal = 0

#fit(d) = a/d^p + A*cos(2pi*d/w - phi)^2

fit(d, a, p) = a/d^p
fit(d) = a_ideal/d^p_ideal

err(xs, ys, a, p) = sum(@. (ys - fit(xs, a, p))^2 ) / (length(xs)-1)
err(a, p) = err(ds_, is_, a, p)

err_ideal = err(a_ideal, p_ideal)

for p in 0:0.0005:2
    global a_ideal, p_ideal, err_ideal
    a = .4^p
    a_p = a
    for da in -0.1:0.001:0.1
        if err(a+da, p) < err(a_p, p)
            a_p = a + da
        end
    end
    if err(a_p, p) < err_ideal
        a_ideal = a_p
        p_ideal = p
        err_ideal = err(a_ideal, p_ideal)
    end
end

# println(p_ideal, '\n', a_ideal, '\n', err_ideal)

scatter(ds_, is_)
plot!(xs_, fit.(xs_))

dis_ = is_ .- fit.(ds_)

fit2(d, A, w, phi) = A * (cos(2pi*d/w - phi)^2)
fit2(d) = fit2(d, A_ideal, w_ideal, phi_ideal)

plot!(xs_, fit2.(xs_))

err2(xs, ys, A, w, phi) = sum(@. (ys - fit2(xs, A, w, phi))^2 ) / (length(xs)-1)
err2(A, w, phi) = err2(ds_, dis_, A, w, phi)

err2_ideal = err2(A_ideal, w_ideal, phi_ideal)


for w in 0.1:0.001:0.2
    for phi in 0:0.01:pi
        for A in 0:0.005:0.1
            global A_ideal, w_ideal, phi_ideal, err2_ideal
            if rand(1:10000) == 3
                println(A, ' ', w, ' ', phi, ' ', fit2(.5, A, w, phi), ' ', err2(ds_, dis_, A, w, phi))
            end
            if err2(A, w, phi) < err2_ideal
                A_ideal = A
                w_ideal = w
                phi_ideal = phi
                err2_ideal = err2(A_ideal, w_ideal, phi_ideal)
            end
        end
    end
end

scatter!(ds_, dis_)
plot!(xs_, fit2.(xs_))


println(A_ideal, ' ', w_ideal, ' ', phi_ideal)
