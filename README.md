# ContinuedFraction

This is my final project. It is a program to approximate any number with a rational number.

## Status
Test status: [![Build status](https://ci.appveyor.com/api/projects/status/a8s3e1pd8070x2y9/branch/master?svg=true)](https://ci.appveyor.com/project/chriswaas/continuedfraction)

At the moment, there are still issues with 32-bit systems because the tests exceed the Int32 range

## Description
**Any** function takes any real numbers as input in combination with a tolerance. There are different functions available:
* **getApprox(x::Number, tol::Number)**: returns rational output that approximates *x* within a tolerance of *tol*
* **getApproxSeries(x::Number, tol::Number)**: returns an array of rationals (*convergents*) that shows the chronological order of fractions that were used to approximate *x* within *tol*
* **getDeviation(x::Number, tol::Number)** returns an array with the deviations from each convergent to *x*
* **getCoeffs(x::Number, tol::Number)** returns coefficients with which the continued fraction was built

## Math
Implemented algorithm can be found e.g. on Wikipedia [Wikipedia - Continued Fraction](https://en.wikipedia.org/wiki/Continued_fraction#Calculating_continued_fraction_representations)
