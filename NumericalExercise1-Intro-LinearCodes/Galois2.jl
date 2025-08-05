module Galois2

export Gf2_1,GF2,gffieldsize,gfzero,gfone,gfprimitive,gflog,gfexp,gforder,gffieldextensiondegree,isprimitive,rref!,rref,rref_transform,Gf2

# composite types of binary Galois field elements (Gf2)
abstract type Gf2 <: Number end

struct Gf2_1 <: Gf2
    value::Int
    Gf2_1(x::Int) = (-1 < x <= 1) ? new(x) : error("the allowed range is 0 .. 1 .")
end

GF2 = Gf2_1

# List of log-tables, exponential-tables and inversion-tables
const GF__2_1_EXP = Gf2_1[1,0,0,]

const GF__2_1_LOG = Int[1,0,]

const GF__2_1_INV = Gf2_1[1,]

const GF__2_1_ORD = Int[1,]

# This allows the REPL to show values of type Gf2.
Base.show(io::IO, x::Gf2_1) = print(io, x.value)

# Show binary representation of each element
Base.bitstring(x::Gf2_1) = bitstring(x.value)[(end-1+1):end]

# Promotion rules

# Conversions
Base.convert(::Type{Gf2_1}, x::Gf2_1) = x

# Definition of methods for extending comparison operators
Base.:(==)(x::Gf2_1, y::Gf2_1) = x.value == y.value

Base.:(!=)(x::Gf2_1, y::Gf2_1) = !(x.value == y.value)

# Definition of methods for extending bitwise operators
Base.:~(x::Gf2_1) = Gf2_1(xor(x.value,  1))

Base.:&(x::Gf2_1, y::Gf2_1) = Gf2_1(x.value & y.value)

Base.:|(x::Gf2_1, y::Gf2_1) = Gf2_1(x.value | y.value)

Base.xor(x::Gf2_1, y::Gf2_1) = Gf2_1(xor(x.value, y.value))

# Definition of methods for extending arithmetic operators
Base.:+(x::Gf2_1) = x

Base.:-(x::Gf2_1) = x

Base.:+(x::Gf2_1, y::Gf2_1) = Gf2_1(xor(x.value, y.value))

Base.:-(x::Gf2_1, y::Gf2_1) = Gf2_1(xor(x.value, y.value))


Base.:*(x::Gf2_1, y::Gf2_1) = GF__2_1_EXP[GF__2_1_LOG[x.value + 1] + GF__2_1_LOG[y.value + 1] + 1]

Base.:/(x::Gf2_1, y::Gf2_1) = y.value != 0 ? (x * GF__2_1_INV[y.value]) : throw(ArgumentError("division by zero!"))

Base.:inv(x::Gf2_1) = x.value != 0 ? GF__2_1_INV[x.value] : throw(ArgumentError("impossible to invert the zero element!"))

# Utility functions
gffieldsize(x::Gf2_1) = 2

gffieldsize(::Type{Gf2_1}) = 2

gffieldextensiondegree(x::Gf2_1) = 1

gffieldextensiondegree(::Type{Gf2_1}) = 1

function gfzero(T::Int)
    if T==1 Gf2_1(0)
    else error("the input argument to gfzero() must be in this list: [1]")
    end
end

gfzero(::Type{Gf2_1}) = Gf2_1(0)

function gfone(T::Int)
    if T==1 Gf2_1(1)
    else error("the input argument to gfone() must be in this list: [1]")
    end
end

gfone(::Type{Gf2_1}) = Gf2_1(1)

function gfprimitive(T::Int)
    if T==1 Gf2_1(1)
    else error("the input parameter to gfprimitive() must be in this list: [1]")
    end
end

gfprimitive(::Type{Gf2_1}) = Gf2_1(1)

isprimitive(x::Gf2_1) = x.value == 0 ? false : (gforder(x) == 1 ? true : false)

gflog(x::Gf2_1) = x.value != 0 ? (GF__2_1_LOG[x.value + 1]) : throw(ArgumentError("gflog(0) is undefined!"))

function gfexp(T::Int, x::Int) 
    if T==1 GF__2_1_EXP[(x % 1) + 1]
    else error("the first input parameter to gfexp(T::Int, x::Int) must be in this list: [1]")
    end
end

gfexp(::Type{Gf2_1}, x::Int) = Gf2_1(1)

gforder(x::Gf2_1) = x.value != 0 ? GF__2_1_ORD[x.value] : throw(ArgumentError("gforder(0) is undefined!"))

Base.zero(x::Gf2_1) = Gf2_1(0)

Base.zero(::Type{Gf2_1}) = Gf2_1(0)

Base.one(x::Gf2_1) = Gf2_1(1)

Base.one(::Type{Gf2_1}) = Gf2_1(1)

#Matrix operations
function rref!(A::Matrix{T}) where {T <: Gf2}
    r, c = size(A)
    i = j = 1
    while i <= r && j <= c
        mi = findfirst(A[i:r,j] .!= gfzero(T))
        if mi == nothing
            j += 1
        else
            mi = mi+i - 1
            for k=j:c
                A[i, k], A[mi, k] = A[mi, k], A[i, k]
            end
            d = A[i,j]
            for k = j:c
                A[i,k] /= d
            end
            for k = 1:r
                if k != i
                    d = A[k,j]
                    for l = j:c
                        A[k,l] -= d*A[i,l]
                    end
                end
            end
            i += 1
            j += 1
        end
    end
    A
end

rref(A::Matrix{T}) where {T <: Gf2} = rref!(copy(A))

function Base.inv(A::Matrix{T}) where {T <: Gf2}
    r, c = size(A)
    if r != c error("matrix inversion is defined only for square matrices of types Gf2")
    elseif r == 1 inv(A[1])
    else
        iden = zeros(T, r, r)
        for k in 1:r iden[k, k] = gfone(T) end
        B = rref!([A iden])
        if B[:, 1:r] != iden
            error("matrix is not invertible!")
        else
            B[:, r+1:end]
        end
    end
end

function rref_transform(A::Matrix{T}) where {T <: Gf2}
    r, c = size(A)
    iden = zeros(T, r, r)
    for k in 1:r iden[k, k] = gfone(T) end
    B = rref!([A iden])
    return B[:, 1:c], B[:, c+1:end]
end


#End of module
end
