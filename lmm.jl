## ISSUES
## * difficulty using readtable: 32-bit build problem?
## * difficulty finding examples that are (1) reading data from CSV files
##   (2) using header names
## * difficulty using MixedModels package: advised that support for stable version (0.2.1) in packages is not great, should upgrade to 0.3.0-prerelease
## * installing 0.3.0-prelease breaks ESS (apparently); while it surprisingly Just Worked with 0.2.1 (open .jl file , M-x julia starts Julia instance), now I get "no such file or directory, julia-basic"
## * installing 0.3.0-prerelease makes readtable Just Work
## * ?readtable gives "readtable (generic function with 3 methods)" -- how do I get more help???  (I'm interested in the analogue of "colClasses")
## https://github.com/JuliaStats/DataFrames.jl/blob/master/doc/sections/03_io.md  gives eltypes

readtable (generic function with 3 methods)


## Pkg.add("MixedModels")
## Pkg.add("DataFrames")
using MixedModels, DataFrames
mm0 = read_rda("mm0.RData")["mm0"];  ## produces an 'RList' object
x = readtable("mm0.csv",eltypes=[Float64,UTF8String,UTF8String,Float64,UTF8String])
    ## error; http://stackoverflow.com/questions/20534563/dataframes-package-functions-using-wrong-types

lmm(mean~ambiguity+(1|subj),x)
## with 0.3-0:
## ERROR: ArgumentError("float64(String): invalid number format")
##  in float64 at string.jl:1572
##  in map at abstractarray.jl:1265
##  in cols at /home/bolker/.julia/v0.3/DataFrames/src/statsmodels/formula.jl:198
##  in ModelMatrix at /home/bolker/.julia/v0.3/DataFrames/src/statsmodels/formula.jl:233
##  in lmm at /home/bolker/.julia/v0.3/MixedModels/src/lmm.jl:10 (repeats 2 times)


## same even after reading in more explicitly

## ?help gives useful help
## help("readtable") gives "No help information found."

using RDatasets
inst = dataset("lme4","InstEval")
lmm(Y~Studage+Lectage+(1|S)+(1|D),inst)
ds = dataset("lme4","Dyestuff")
lmm(Yield ~ 1|Batch,ds)

quit()
