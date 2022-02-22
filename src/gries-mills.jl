struct GriesMillsRotation end

export GriesMillsRotation

"""
    rotate!(aux::GriesMillsRotation, A::AbstractVector, tailpos::Integer)

Rotates `A` on `tailpos` using a O(1) extra memory
"""
function rotate!(::GriesMillsRotation, A::AbstractVector, tailpos::Integer)
    sp = 1
    ep = length(A)   
    while sp < tailpos #sp < ep
        mid = (ep+sp) >> 1
        if tailpos > mid  # right is shorter
            n = ep - tailpos + 1
            @inbounds for i in 0:n-1
                tmp = A[sp+i]
                A[sp+i] = A[tailpos+i]
                A[tailpos+i] = tmp
            end
            sp = sp + n
        else # left is shorter
            n = tailpos - sp
            p = ep - n + 1
            @inbounds for i in 0:n-1
                tmp = A[sp+i]
                A[sp+i] = A[p+i]
                A[p+i] = tmp
            end

            ep = p - 1
            tailpos = sp + n
        end        
    end

    A
end
