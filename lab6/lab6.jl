using Plots, Latexify

e6 = [
        1 23.6 24.3 48.1
     ]

e3 = [
        1 11.1 11.0
        2 23.8 23.3
   ]

e1 = [
        1 3.6 3.6
        2 7.3 7.4
        3 11.1 11.1
        4 15.2 15.0
        5 19.4 19.2
        6 24.0 23.6
        7 29.0 28.6
        8 34.6 33.1
       ]


r = [
        1 6.4 5.5
        2 12.7 10.9
        3 19.1 16.6
        4 24.2 23.4
        5 31.1 28.8
        6 37.7 35.0
        7 43.7 42.1
        8 50.0 47.4
        9 56.2 54.0
        10 62.2 60.2
        11 68.8 66.5
        12 74.6 73.0
   ]

function plot_diffraction_lines(table::Matrix)
    t = size(table)[1]

    scatter(table[:,1], table[:,2], label="left", xticks=1:t)
    scatter!(table[:,1], table[:,3], label="right", xticks=1:t)

    xlabel!("m (absolute from center)")
    ylabel!("Distance from center (cm)")
end

plot_diffraction_lines(e3)
