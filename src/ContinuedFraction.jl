module ContinuedFraction

function evaluate(x::Number, a::Array{Int,1}, iter::Int)
    for j = iter-1:-1:1
        x = 1//x+a[j]
    end
    return x
end

function generate(x::Number, tol::Number)
    counter = 1
    z = 0
    a = zeros(Int, 100)
    b = zeros(Number, 100)
    konv = zeros(Rational, 100)
    a[1] = Int(floor(x))
    b[1] = x
    konv[1] = a[1]
    if abs(konv[1]-x)<=tol
        z = konv[1]
    else
        for i in 2:length(a)
            try
                b[i] = 1/(b[i-1]-a[i-1])
                a[i] = Int(floor(b[i]))
                konv[i] = evaluate(a[i],a,i)
            catch
                b[i] = 0
                a[i] = Int(floor(b[i]))
                konv[i] = evaluate(a[i],a,i)
            end
            counter = i
            if abs(konv[i]-x)<=tol
                z = konv[i]
                break
            end
        end
    end
    return z,a,konv,counter
end

export getApprox
function getApprox(x::Number, tol::Number)
    return generate(x,tol)[1]
end

export getApproxSeries
function getApproxSeries(x::Number, tol::Number)
    i = 2
    d = generate(x,tol)[3]
    while d[i] != 0
        i += 1
    end
    val = zeros(Rational, i-1)
    for j in 1:i-1
        val[j] = d[j]
    end
    return val
end
end
