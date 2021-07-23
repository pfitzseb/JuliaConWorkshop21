using ImageShow, Colors

const MAXITER = 100

function mandel(z; maxiter = MAXITER)
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

step = 0.1
length(domain(step))
make_mandelbrot(domain(step))
