using ContinuedFraction
using Test

@testset "Testing rational approximation" begin
tol = 1e-14
for i in 1:100000
  x = rand(-1000000:1000000)
  y = rand(1:1000000)
  t = rand(2:20)
  z = x//y
  appro = getApproxSeries(z,tol)[:][1]
  @test abs(x-getApprox(x,tol)) <= tol #test for whole numbers
  @test abs(z-getApprox(z,tol)) <= tol #test for rational numbers
  if length(appro) > 1
    @test abs(z-appro[end-1]) >= tol #test if approximation could have been stopped earlier
  end
  @test abs(abs(z)^(1//t)-getApprox(abs(z)^(1//t),tol)) <= tol #test of irrational numbers
end

#testing e and pi, to be perfected
@test abs(getApprox(exp(1),tol)-exp(1)) <= tol #test of e
@test abs(getApprox(pi, tol)-pi) <= tol #test of pi
@test abs(0-getApprox(0,tol)) <= tol #test of 0
end
