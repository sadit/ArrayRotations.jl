struct RevRotation end

export RevRotation

"""
    rotate!(::RevRotation, A::AbstractVector, tailpos::Integer)

Rotates `A` on `tailpos` using ``O(1)`` extra memory, yet using several 2n copy-write ops (triple reversing)
"""
function rotate!(::RevRotation, A::AbstractVector, tailpos::Integer)
    reverse!(A, 1, tailpos - 1)
    reverse!(A, tailpos, length(A))
    reverse!(A)
    A
end
