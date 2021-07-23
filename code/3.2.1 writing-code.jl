# return values are displayed inline
x = 3

# stdout/stderr go to the terminal below
println("Hello world!")

# everything in the editor is relative to the file,
# so beware of file/pwd mismatches!
@__DIR__
pwd()

module MyModule
# There's a module selector in the status bar, currently displaying `(MyModule)`
# It will change to `MyModule` once this code has actually run

hello(name::String) = "Hello, $name"
function rationalish(x, y)
    if x == y == 0
        return 1//1
    end

    return x//y
end

struct CustomStruct
    x
    y
end
CustomStruct() = CustomStruct(1, 2)

end

MyModule.hello("JuliaCon")

# stacktraces are displayed in the editor and can be navigated with the hover popups
MyModule.rationalish(0, 0)

# Type definitions are permanent, but we can just re-define the module instead
MyModule.CustomStruct()

# Editing package code is easy:
using JuliaCon # https://github.com/JuliaCon/JuliaCon.jl

juliacon2021()
JuliaCon.now()
# let's edit that function and re-evaluate it:
JuliaCon.now()

# let's try this again with Revise.jl
# exit()
# using Revise # https://github.com/timholy/Revise.jl
# using JuliaCon

# JuliaCon.now()

##
println(2+2)
println(2+2)
println(2+2)

##
3+3
