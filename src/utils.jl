
"""
    _copy!(dst::AbstractVector, dst_sp::Integer, src::AbstractVector, src_sp::Integer, n::Integer)

Copies `n` contiguous elements from  `src` (starting at `src_sp`) into `dst` (starting at `dst_sp`).
"""
@inline function _copy!(dst::AbstractVector, dst_sp::Integer, src::AbstractVector, src_sp::Integer, n::Integer)
    @inbounds for i in 1:n
        dst[dst_sp] = src[src_sp]
        dst_sp += 1
        src_sp += 1
    end
    
    dst
end

"""
    _left_shift!(A::AbstractVector, sp)

Shifts `A[sp:end]` to the beggining of `A`
"""
@inline function _left_shift!(A::AbstractVector, sp)
    i = 1
    @inbounds for j in sp:length(A)
        A[i] = A[j]
        i += 1
    end

    A
end

"""
    _right_shift!(A::AbstractVector, ep)

Shifts `A[1:ep]` to the end of `A`
"""
@inline function _right_shift!(A::AbstractVector, ep)
    i = length(A)
    @inbounds for j in ep:-1:1
        A[i] = A[j]
        i -= 1
    end

    A
end
#=
@inline function _interchange!(A::AbstractVector, head, tail, n)
    @inbounds for i in 1:n
        tmp = A[head]
        A[head] = A[tail]
        A[tail] = tmp
        head += 1
        tail += 1
    end

    A
end
=#