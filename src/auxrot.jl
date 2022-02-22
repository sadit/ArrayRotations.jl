struct AuxRotation{T}
    buff::Vector{T}  # each Thread must have an AuxRotation struct
end

export AuxRotation
export rotate!

"""
    rotate!(::AuxRotation, A::AbstractVector, tailpos::Integer)

Rotates `A` on `tailpos` using at most `n / 2` extra memory, 3n/2 copy-write ops.
"""
function rotate!(aux::AuxRotation, A::AbstractVector, tailpos::Integer)
    m = tailpos - 1
    n = length(A) - m
    if m <= n
        resize!(aux.buff, m)
        _copy!(aux.buff, 1, A, 1, m)
        _left_shift!(A, tailpos)
        _copy!(A, n+1, aux.buff, 1, m)
    else
        resize!(aux.buff, n)
        _copy!(aux.buff, 1, A, tailpos, n)
        _right_shift!(A, m)
        _copy!(A, 1, aux.buff, 1, n)
    end

    A
end
