using ContinuedFraction
using Test

@testset "Testing rational approximation" begin
counter = 0
tol = 1e-13
for i in 1:100000
  x = rand(-100000:100000)
  y = rand(1:1000000)
  t = rand(2:20)
  z = x//y
  appro = approximateSeries(z,tol)[:][1]
  @test abs(x-approximate(x,tol)) <= tol #test for whole numbers
  @test abs(z-approximate(z,tol)) <= tol #test for rational numbers
  if length(appro) > 1
    @test abs(z-appro[end-1]) >= tol #test if approximation could have been stopped earlier
    counter += 1
  end
  @test abs(abs(z)^(1//t)-approximate(abs(z)^(1//t),tol)) <= tol #test of irrational numbers
end

#testing e and pi, to be perfected
@test abs(approximate(exp(1),tol)-exp(1)) <= tol #test of e
@test abs(approximate(pi, tol)-pi) <= tol #test of pi
@test abs(0-approximate(0,tol)) <= tol #test of 0
@show counter
end
