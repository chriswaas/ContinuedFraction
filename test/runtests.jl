using ContinuedFraction
using Test

@testset "Testing rational approximation" begin
tol = 1e-14
for i in 1:100000
  x = rand(-1000000:1000000)
  y = rand(1:1000000)
  t = rand(2:20)
  z = x//y
  appro = getApproxSeries(z,tol)
  @test abs(x-getApprox(x,tol)) <= tol
  @test abs(z-getApprox(z,tol)) <= tol
  if length(appro) > 1
    @test abs(z-getApproxSeries(z,tol)[end-1]) >= tol
  end
  @test abs(abs(z)^(1//t)-getApprox(abs(z)^(1//t),tol)) <= tol
end

#testing e and pi, to be perfected
@test isapprox(abs(log(getApprox(exp(1),tol))), 1)
@test isapprox(abs(cos(getApprox(pi/2, tol))), 0, atol = 1e-14)
@test abs(0-getApprox(0,tol)) <= tol 
end
