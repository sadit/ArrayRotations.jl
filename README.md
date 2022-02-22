# Rotations1

This a small package with array rotation algorithms or block swap. Only 1D arrays (vectors).

## Usage:

Simply call `rotate!(rot::Rotation, A::AbstractVector, tailpos::Integer)` to rotate the array `A` on the given tail position. 

A few algorithms are implemented:

- AuxRotation
- BridgeRotation
- RevRotation
- GriesMillsRotation