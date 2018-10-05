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
    #z = 0
    store1 = zeros(Int, 100) #stores coefficients
    store2 = zeros(Number, 100) #stores remaining number of x
    konv = zeros(Rational, 100) #stores convergents
    store1[1] = Int(floor(x)) #initialize
    store2[1] = x
    konv[1] = store1[1]
    if abs(konv[1]-x) <= tol #if floor of x already approximates good enough, stop here
        z = konv[1]
    else
        for i in 2:length(store1)
            counter = i
            try #calculation of the next konvergent
                store2[i] = 1/(store2[i-1]-store1[i-1])
                store1[i] = Int(floor(store2[i]))
                konv[i] = evaluate(store1, i) #evaluateRec(shorten(store1), 1) also works but I think it's slower
                if abs(konv[i]-x) <= tol #check if fraction approximates x good enough, then break
                    z = konv[i]
                    break
                end
            catch
                break
            end
            #println(store1[i],store2[i]) #debug
        end
    end
    return z,store1,konv,counter,tol
end

export getApprox #returns fraction that approximates x within tol
function getApprox(x::Number, tol::Number)
    return generate(x,tol)[1]
end

export getApproxSeries #returns all convergents & tolerance
function getApproxSeries(x::Number, tol::Number)
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
    y = getApproxSeries(x,tol)
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

end # module
