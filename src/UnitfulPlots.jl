module UnitfulPlots
using Unitful
using RecipesBase

function unit_formatter(T, num)
    string(num)*string(unit(zero(T)))
end

# 2D plots (1 recipe for shorthand form)
@recipe function f(val::AbstractArray{T,N}) where {T<:Quantity,N}
    yformatter := x->unit_formatter(T,x)
    ustrip.(val)
end

# 2D plots (2^4-1 user recipes)
@recipe function f(val::AbstractArray{S,N}, val2::AbstractArray{T,M}
                  ) where {S<:Quantity, T<:Quantity, N, M}
    xformatter := x->unit_formatter(S,x)
    yformatter := x->unit_formatter(T,x)
    ustrip.(val), ustrip.(val2)
end

@recipe function f(val, val2::AbstractArray{T,N}) where {T<:Quantity, N}
    yformatter := x->unit_formatter(T,x)
    val, ustrip.(val2)
end

@recipe function f(val::AbstractArray{T,N}, val2) where {T<:Quantity, N}
    xformatter := x->unit_formatter(T,x)
    ustrip.(val), val2
end

# 3D plots (2^8-1 user recipes)
@recipe function f(val::AbstractArray{S,N}, val2::AbstractArray{T,M}, val3::AbstractArray{U,P}
                  ) where {S<:Quantity, T<:Quantity, U<:Quantity, N, M, P}
    xformatter := x->unit_formatter(S,x)
    yformatter := x->unit_formatter(T,x)
    zformatter := x->unit_formatter(U,x)
    ustrip.(val), ustrip.(val2), ustrip.(val3)
end

@recipe function f(val::AbstractArray{S,N}, val2::AbstractArray{T,M}, val3
                  ) where {S<:Quantity, T<:Quantity, N, M}
    xformatter := x->unit_formatter(S,x)
    yformatter := x->unit_formatter(T,x)
    ustrip.(val), ustrip.(val2), val3
end

@recipe function f(val::AbstractArray{S,N}, val2, val3::AbstractArray{U,P}
                  ) where {S<:Quantity, U<:Quantity, N, P}
    xformatter := x->unit_formatter(S,x)
    zformatter := x->unit_formatter(U,x)
    ustrip.(val), val2, ustrip.(val3)
end

@recipe function f(val, val2::AbstractArray{T,M}, val3::AbstractArray{U,P}
                  ) where {T<:Quantity, U<:Quantity, M, P}
    yformatter := x->unit_formatter(T,x)
    zformatter := x->unit_formatter(U,x)
    val, ustrip.(val2), ustrip.(val3)
end

@recipe function f(val::AbstractArray{T,N}, val2, val3) where {T<:Quantity, N}
    xformatter := x->unit_formatter(T,x)
    ustrip.(val), val2, val3
end

@recipe function f(val, val2::AbstractArray{T,N}, val3) where {T<:Quantity, N}
    yformatter := x->unit_formatter(T,x)
    val, ustrip.(val2), val3
end

@recipe function f(val, val2, val3::AbstractArray{T,N}) where {T<:Quantity, N}
    zformatter := x->unit_formatter(T,x)
    val, val2, ustrip.(val3)
end

end
