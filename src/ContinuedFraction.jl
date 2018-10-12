module ContinuedFraction
#using Plots

#iterativ evaluation
function evaluate(a::Array{Int,1}, iter::Int)
    x=a[iter]
    for j = iter-1:-1:1
        x = 1//x+a[j]
    end
    return x
end

#recursive evaluation
function evaluateRec(a::Array{Int,1}, iter::Int)
    x=0
    if (iter < length(a) && a[iter] != 0) || iter==1
        x = a[iter]+(1//evaluateRec(a, iter+1))
    else
        x=a[end]
    end
    return x
end

function shorten(d::Array)
    i = 2
    while d[i] != 0
        i += 1
    end
    t = zeros(eltype(d), i-1)
    for j in 1:i-1
        t[j] = d[j]
    end
    return t
end

############################################################

function generate(x::Number, tol::Number)
    counter = 1
    store1 = zeros(Int, 100) #stores coefficients
    store2 = zeros(Number, 100) #stores remaining part of x
    konv = zeros(Rational, 100) #stores convergents
    store1[1] = Int(floor(x)) #initialize
    store2[1] = x
    konv[1] = store1[1]
    if abs(konv[1]-x) <= tol #if floor of x already approximates good enough, stop here (e.g. integer approximation)
        z = konv[1]
    else
        for i in 2:length(store1)
        counter = i
            dif = (store2[i-1]-store1[i-1])
            if dif != 0
                store2[i] = 1/dif #algorithm of wikipedia
                store1[i] = Int(floor(store2[i]))
                konv[i] =  evaluate(store1, i) #evaluateRec(shorten(store1), 1) also works but I think it's slower
                if abs(konv[i]-x) <= tol #check if fraction approximates x good enough, then break
                    z = konv[i]
                    break
                end
            else
                break
            end
        end
    end
    return z,store1,konv,counter,tol
end

export approximate #returns fraction that approximates x within tol
function approximate(x::Number, tol::Number)
    return generate(x,tol)[1]
end

export approximateSeries #returns all convergents & tolerance
function approximateSeries(x::Number, tol::Number)
    i = 2
    d = generate(x,tol)[3]
    while d[i] != 0
        i += 1
    end
    val = zeros(Rational, i-1)
    global devs = zeros(i-1)
    pl = zeros(i-1, 2)
    for j in 1:i-1
        val[j] = d[j]
        devs[j] = x - d[j]
        pl[j,:] = [j, devs[j]]
    end
    return val,tol
end

export getDeviation #returns deviation of each convergent to x
function getDeviation(x::Number, tol::Number)
    y = approximateSeries(x,tol)
    println("Needed steps: ", length(y[1]))
    return pl
end

export getCoeffs #returns coefficients that form the continued fraction
function getCoeffs(x::Number, tol::Number)
    i = 2
    d = generate(x, tol)[2]
    while d[i] != 0
        i += 1
    end
    val = zeros(Int, i-1)
    pl = zeros(i-1, 2)
    for j in 1:i-1
        val[j] = d[j]
    end
    return val
end

export getDiff #returns absolute value of difference from approximation x to value y
function getDiff(x::Rational, y::Number)
    return abs(x-y)
end

end # module
