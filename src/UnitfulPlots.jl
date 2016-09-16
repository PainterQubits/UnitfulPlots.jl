module UnitfulPlots
using Unitful
importall RecipesBase

function unit_formatter(T, num)
    string(num)*string(unit(zero(T)))
end

# 2D plots (1 recipe for shorthand form)
@recipe function f{T<:Quantity}(val::AbstractVector{T})
    yformatter := x->unit_formatter(T,x)
    ustrip(val)
end

# 2D plots (2^4-1 user recipes)
@recipe function f{S<:Quantity, T<:Quantity}(val::AbstractVector{S}, val2::AbstractVector{T})
    xformatter := x->unit_formatter(S,x)
    yformatter := x->unit_formatter(T,x)
    ustrip(val), ustrip(val2)
end

@recipe function f{S<:Number, T<:Quantity}(val::AbstractVector{S}, val2::AbstractVector{T})
    yformatter := x->unit_formatter(T,x)
    val, ustrip(val2)
end

@recipe function f{S<:Number, T<:Quantity}(val::AbstractVector{T}, val2::AbstractVector{S})
    xformatter := x->unit_formatter(T,x)
    ustrip(val), val2
end

# 3D plots (2^8-1 user recipes)
@recipe function f{S<:Quantity, T<:Quantity, U<:Quantity}(
    val::AbstractVector{S}, val2::AbstractVector{T}, val3::AbstractMatrix{U})
    xformatter := x->unit_formatter(S,x)
    yformatter := x->unit_formatter(T,x)
    zformatter := x->unit_formatter(U,x)
    ustrip(val), ustrip(val2), ustrip(val3)
end

@recipe function f{S<:Quantity, T<:Quantity, U<:Number}(
    val::AbstractVector{S}, val2::AbstractVector{T}, val3::AbstractMatrix{U})
    xformatter := x->unit_formatter(S,x)
    yformatter := x->unit_formatter(T,x)
    ustrip(val), ustrip(val2), val3
end

@recipe function f{S<:Quantity, T<:Number, U<:Quantity}(
    val::AbstractVector{S}, val2::AbstractVector{T}, val3::AbstractMatrix{U})
    xformatter := x->unit_formatter(S,x)
    zformatter := x->unit_formatter(U,x)
    ustrip(val), val2, ustrip(val3)
end

@recipe function f{S<:Number, T<:Quantity, U<:Quantity}(
    val::AbstractVector{S}, val2::AbstractVector{T}, val3::AbstractMatrix{U})
    yformatter := x->unit_formatter(T,x)
    zformatter := x->unit_formatter(U,x)
    val, ustrip(val2), ustrip(val3)
end

@recipe function f{S<:Quantity, T<:Number, U<:Number}(
    val::AbstractVector{S}, val2::AbstractVector{T}, val3::AbstractMatrix{U})
    xformatter := x->unit_formatter(S,x)
    ustrip(val), val2, val3
end

@recipe function f{S<:Number, T<:Quantity, U<:Number}(
    val::AbstractVector{S}, val2::AbstractVector{T}, val3::AbstractMatrix{U})
    yformatter := x->unit_formatter(T,x)
    val, ustrip(val2), val3
end

@recipe function f{S<:Number, T<:Number, U<:Quantity}(
    val::AbstractVector{S}, val2::AbstractVector{T}, val3::AbstractMatrix{U})
    zformatter := x->unit_formatter(U,x)
    val, val2, ustrip(val3)
end

end
