struct BridgeRotation{T}
    buff::Vector{T} 
end

export BridgeRotation

"""
    rotate!(bridge::BridgeRotation, A::AbstractVector, tailpos::Integer)

Rotates `A` on `tailpos` using a small extra memory. ≤ a third of A and ≤ than n+n/3 copy-write ops.
"""
function rotate!(bridge::BridgeRotation, A::AbstractVector, tailpos::Integer)
    m = tailpos - 1
    n = length(A) - m
    if m <= n
        _interchange_right_large!(A, bridge.buff, tailpos)
    else
        _interchange_left_large!(A, bridge.buff, tailpos)
    end

    A
end


"""
    _interchange_left_large!(A::AbstractVector, buff::AbstractVector, tail::Integer)

Interchange and shift two subarrays

```
      
      buffer
      -----
4 5 6 7 8 9 1 2 3
-----       |
head        tail
```

must produce
```
      prev head
      -----
1 2 3 4 5 6 1 2 3
-----       -----
prev tail   untouched
```

and finally, the buffer should be copied-back
```
      prev head
      -----
1 2 3 4 5 6 7 8 9
-----       -----
prev tail   from buffer
```
"""
@inline function _interchange_left_large!(A::AbstractVector, buff::AbstractVector, tail::Integer)
    m = length(A)
    n = m - tail + 1  # number of elements
    p = 2n
    resize!(buff, m - p)
    _copy!(buff, 1, A, n + 1, length(buff))
    @inbounds for i in 1:n    
        n += 1
        A[n] = A[i]
        A[i] = A[tail]
        tail += 1
    end
    _copy!(A, p + 1, buff, 1, length(buff))
    A
end

"""
    _interchange_right_large!(A::AbstractVector, buff::AbstractVector, tail::Integer)

Interchange and shift two subarrays

```

head        buffer
-----       -----
7 8 9 1 2 3 4 5 6
      |
      tail
```

must produce
```
prev tail   prev head
-----       -----
1 2 3 1 2 3 7 8 9
      -----
     untouched
```

The centering block is then filled with the buffer.
"""
@inline function _interchange_right_large!(A::AbstractVector, buff::AbstractVector, tail::Integer)
    m = length(A)
    n = tail - 1  # number of elements
    p = 2n
    resize!(buff, m - p)
    _copy!(buff, 1, A, p + 1, length(buff))
    
    @inbounds for i in n:-1:1
        A[m] = A[i]
        A[i] = A[p]
        p -= 1
        m -= 1
    end
    _copy!(A, n + 1, buff, 1, length(buff))
    A
end