using ForwardDiff
using Plots
using Plots.PlotMeasures
pyplot(size=(1200,600))

f(x,y) = -5*x*y*exp(-x^2-y^2)
x = -1:.02:1
y = -1:.02:1
z = [f(i,j) for i in x, j in y]
p = plot(
    x,
    y,
    z,
    linetype=:surface,
    color=:blues,
    legend=false,
    xlabel="x",
    ylabel="y",
    zlabel="z",
    camera=(-20,30),
    title="f(x,y) = -5*x*y*exp(-x^2-y^2)"
)
p1 = contour(
    x,
    y,
    z,
    color=:blues,
    legend=false,
    xlabel="x",
    ylabel="y",
    title="Countour With Jacobians"
)
# Get all of the xy coordinates in the space
xy = [(i,j) for i in x for j in y]
# This is the same function as above, just modified so that it will work with ForwardDiff
g(x,y) = [-5*x*y*exp(-x^2-y^2)]
# Jacobians are scaled by 0.05 so that the vector arrows aren't too long when plotted
J = .05 .* [ForwardDiff.jacobian(x -> g(x[1], x[2]), [i[1],i[2]]) for i in xy]
# All the x coordinates
xs = [xy[i][1] for i in 1:7:length(xy)]
# All the y coordinates
ys = [xy[i][2] for i in 1:7:length(xy)]
# We need u,v for the quiver plot
u = [J[i][1] for i in 1:7:length(J)]
v = [J[i][2] for i in 1:7:length(J)]
quiver!(xs,ys,quiver=(u,v),color=:lightblue,linewidth=0.5)
plot(p,p1,layout=2,left_margin=5mm)