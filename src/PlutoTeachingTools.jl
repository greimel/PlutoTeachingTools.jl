module PlutoTeachingTools

using PlutoUI

using PlutoLinks: @ingredients
export @ingredients

include("admonitions.jl")
export hint, tip, protip, almost, warning_box, danger 
export correct, still_missing, still_nothing, wrong_type
export var_not_defined, func_not_defined, keep_working
export not_defined  # deprecated
#export keep_working_if_var_contains_substr
export type_isa, type_eq
export code_for_check_type_funcs
export TODO
export display_msg_if_fail

include("present.jl")
include("latex.jl")
include("other.jl")

end # module
