module ContinuedFraction
using Plots
function evaluate(x::Number, a::Array{Int,1}, iter::Int)
    for j = iter-1:-1:1
        x = 1//x+a[j]
    end
    return x
end

function generate(x::Number, tol::Number)
    counter = 1
    z = 0
    store1 = zeros(Int, 100)
    store2 = zeros(Number, 100)
    konv = zeros(Rational, 100)
    store1[1] = Int(floor(x))
    store2[1] = x
    konv[1] = store1[1]
    if abs(konv[1]-x) <= tol
        z = konv[1]
    else
        for i in 2:length(store1)
            counter = i
            try
                store2[i] = 1/(store2[i-1]-store1[i-1])
                store1[i] = Int(floor(store2[i]))
                konv[i] = evaluate(store1[i], store1, i)
                if abs(konv[i]-x) <= tol
                    z = konv[i]
                    break
                end
            catch #have a feeling that's never gonna happen
                store2[i] = 0
                store1[i] = Int(floor(store2[i])) # =0
                konv[i] = evaluate(store1[i], store1, i)
                println("reached deadend")
            end
        end
    end
    return z,store1,konv,counter,tol
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
    stats = zeros(i-1)
    global pl = zeros(i-1, 2)
    for j in 1:i-1
        val[j] = d[j]
        stats[j] = x - d[j]
        pl[j,:] = [j, stats[j]]
    end
    return val,tol
end

export getStatistics
function getStatistics(x::Number, tol::Number)
    z = getApproxSeries(x,tol)
    println("Needed steps: ", length(z[1]))
    return pl
end

end # module
