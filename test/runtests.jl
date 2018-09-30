using ContinuedFraction
using Test

@testset "Testing rational approximation" begin
tol = 1e-14
for i in 1:100000
  x = rand(-1000000:1000000)
  y = rand(1:1000000)
  z = x//y
  appro = getApproxSeries(z,tol)
  @test abs(z-getApprox(z,tol)) <= tol
  if length(appro) > 1
    @test abs(z-getApproxSeries(z,tol)[end-1]) >= tol
  end
end

#testing e and pi, to be perfected
@test abs(log(getApprox(exp(1),tol))) <= 1.001
@test abs(cos(getApprox(pi/2, tol))) <= 0.001
end
