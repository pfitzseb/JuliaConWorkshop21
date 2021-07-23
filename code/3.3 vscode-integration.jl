# Display system

# inline output: normal "text/plain" mime type
struct Foo
    field1
    field2
    field3
    field4
end

# standard Julia printing
Foo(1, 2, 3, "asd")

# modified printing for your type
Base.show(io::IO, f::Foo) = print(io, f.field4)
Foo(1, 2, 3, "asd")

# plot pane: supports many image formats (png, svg, gif, ...)
struct BarPNG end
Base.show(io::IO, ::MIME"image/png", ::BarPNG) =
    print(io, read(joinpath(@__DIR__, "assets", "world_1400.png"), String))
BarPNG()

# and HTML via a special MIME type because many things can be
# shown as HTML, so explicit opt-in is required)
struct BarHTML end
Base.show(io::IO, ::MIME"juliavscode/html", ::BarHTML) =
    print(io, "<h1>Hello JuliaCon</h1><p>This can display arbitraray HTML</p><p><input type=\"number\" value=\"3\"></p>")
BarHTML()

# plot pane also supports some speical MIME types for PyPlot and VegaLite:
using VegaLite, VegaDatasets
dataset("cars") |>
    @vlplot(
        :point,
        x=:Horsepower,
        y=:Miles_per_Gallon,
        color=:Origin,
        width=400,
        height=400
    )

# dataset viewer:
data = dataset("cars")

# for very big datasets I'd recommend TableView.jl because it can lazy-load
# parts of your dataset; the VSCode extension will be able to do that soon as well

# interactivity with WebIO/JSServe is possible:
using WGLMakie
let # https://lazarusa.github.io/BeautifulMakie/surfWireLines/
    t = 0:0.1:15
    u = -1:0.1:1
    x = [u*sin(t) for t in t, u in u]
    y = [u*cos(t) for t in t, u in u]
    z = [t/4      for t in t, u in u]
    fig, _ = surface(x, y, z, colorrange = (-2,-1.1), highclip = :orangered,
    lightposition = Vec3f0(0, 0, 0), ambient = Vec3f0(0.65, 0.65, 0.65),
    backlight = 5f0) # the colorrange must be outside the range of z
    wireframe!(x,y,z, overdraw = false, linewidth = 0.1) # try overdraw = true
    fig
end

# Progress bars:
using ProgressLogging # https://github.com/JuliaLogging/ProgressLogging.jl

@progress for i in 1:10
    sleep(0.5)
    println("step $i")
end

@progress "my custom for loop" for i in 1:10
    sleep(0.5)
    println("step $i")
end
