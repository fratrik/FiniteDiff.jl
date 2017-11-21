mutable struct TimeGradientWrapper{fType,uType} <: Function
  f::fType
  uprev::uType
end
(p::TimeGradientWrapper)(t) = (du2 = similar(p.uprev); p.f(t,p.uprev,du2); du2)
(p::TimeGradientWrapper)(du2,t) = p.f(t,p.uprev,du2)

mutable struct UJacobianWrapper{fType,tType} <: Function
  f::fType
  t::tType
end

(p::UJacobianWrapper)(du1,uprev) = p.f(p.t,uprev,du1)
(p::UJacobianWrapper)(uprev) = (du1 = similar(uprev); p.f(p.t,uprev,du1); du1)

mutable struct TimeDerivativeWrapper{F,uType} <: Function
  f::F
  u::uType
end
(p::TimeDerivativeWrapper)(t) = p.f(t,p.u)

mutable struct UDerivativeWrapper{F,tType} <: Function
  f::F
  t::tType
end
(p::UDerivativeWrapper)(u) = p.f(p.t,u)
