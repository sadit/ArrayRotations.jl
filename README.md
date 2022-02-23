# Array rotations

A small package with array rotation algorithms (block swap). Only 1D arrays (vectors).

## Usage:

Call `rotate!(rot::Rotation, A::AbstractVector, tailpos::Integer)` to rotate the array `A` on the given tail position. 

A few algorithms are implemented:

- AuxRotation: rotates using at most n/2 extra memory
- BridgeRotation: rotates using at most n/3 extra memory
- RevRotation: rotates using O(1) extra memory
- GriesMillsRotation: Gries Mills algorithm, rotates using O(1) extra memory