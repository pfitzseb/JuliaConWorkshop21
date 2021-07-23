# Basics

# @enter to step through code
@enter println(gcd(22, 10))
# @run to run code in the interpreter, which supports breakpoints
@run println(gcd(22, 10))

# Breakpoints and break-on-exception
function func(x)
    y = 10x
    0//y
end

@run func(0)

# Function breakpoints:
@run func(0)

# Debug console allows code execution and modification of locals:
@run println(func(0))

# break on caught exception:
function catchme(x)
    try
        x//x # will halt here even without a breakpoint
    catch err
        Inf
    end
end

@run catchme(0)

# conditional breakpoints:
function loop(maxiter = 100)
    for i in 1:maxiter
        println(i) # conditional breakpoint when e.g. x > 20
    end
end

@run loop()

# Advanced features:
# - local variables can be modified
# - breakpoints can be set/modified/deleted at all times
# - Run to cursor (e.g. to skip loops)
# - Step into targets (when there are multiple function calls on one line)
@enter println(gcd(22, 10))


# Dealing with debugger performance overhead:
using ImageShow, Colors

function mandel(z; maxiter = 100)
    c = z
    for n in 1:maxiter
        if abs(z) > 2
            return (n - 1)/maxiter
        end
        z = z^2 + c
    end
    return 1
end

to_color(x) = Gray(1 - x)

domain(step = 0.1) = (-2.5:step:1).-((-1.5:step:1.5)im)'

function make_mandelbrot(vals)
    t = time()
    c = to_color.(mandel.(vals))
    println(round(time() - t, sigdigits = 3), " seconds")
    return c
end

step = 0.005
length(domain(step))
make_mandelbrot(domain(step))

@run make_mandelbrot(domain(1))

step = 0.1
vals = domain(step)
length(vals)
make_mandelbrot(vals)
@run make_mandelbrot(vals)

# add Base to compiled modules, with the notable exception of Broadcase:
@run make_mandelbrot(vals)

# if that's still not fast enough, consider using Infiltrator.jl:
using Infiltrator # https://github.com/JuliaDebug/Infiltrator.jl

function mandel_infiltrated(z; maxiter = 100)
    c = z
    for n in 1:maxiter
        if abs(z) > 2
            return (n - 1)/maxiter
        end
        @infiltrate
        z = z^2 + c
    end
    return 1
end

function make_mandelbrot_infiltrated(vals)
    t = time()
    c = to_color.(mandel_infiltrated.(vals))
    println(round(time() - t, sigdigits = 3), " seconds")
    return c
end

# note that this needs to be called from the REPL
# make_mandelbrot_infiltrated(domain(step))
