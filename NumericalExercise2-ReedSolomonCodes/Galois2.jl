module Galois2

export Gf2_1,GF2,Gf2_2,GF4,Gf2_3,GF8,Gf2_4,GF16,Gf2_5,GF32,Gf2_6,GF64,Gf2_7,GF128,Gf2_8,GF256,gffieldsize,gfzero,gfone,gfprimitive,gflog,gfexp,gforder,gffieldextensiondegree,isprimitive,rref!,rref,rref_transform,Gf2

# composite types of binary Galois field elements (Gf2)
abstract type Gf2 <: Number end

struct Gf2_1 <: Gf2
    value::Int
    Gf2_1(x::Int) = (-1 < x <= 1) ? new(x) : error("the allowed range is 0 .. 1 .")
end

struct Gf2_2 <: Gf2
    value::Int
    Gf2_2(x::Int) = (-1 < x <= 3) ? new(x) : error("the allowed range is 0 .. 3 .")
end

struct Gf2_3 <: Gf2
    value::Int
    Gf2_3(x::Int) = (-1 < x <= 7) ? new(x) : error("the allowed range is 0 .. 7 .")
end

struct Gf2_4 <: Gf2
    value::Int
    Gf2_4(x::Int) = (-1 < x <= 15) ? new(x) : error("the allowed range is 0 .. 15 .")
end

struct Gf2_5 <: Gf2
    value::Int
    Gf2_5(x::Int) = (-1 < x <= 31) ? new(x) : error("the allowed range is 0 .. 31 .")
end

struct Gf2_6 <: Gf2
    value::Int
    Gf2_6(x::Int) = (-1 < x <= 63) ? new(x) : error("the allowed range is 0 .. 63 .")
end

struct Gf2_7 <: Gf2
    value::Int
    Gf2_7(x::Int) = (-1 < x <= 127) ? new(x) : error("the allowed range is 0 .. 127 .")
end

struct Gf2_8 <: Gf2
    value::Int
    Gf2_8(x::Int) = (-1 < x <= 255) ? new(x) : error("the allowed range is 0 .. 255 .")
end

GF2 = Gf2_1

GF4 = Gf2_2

GF8 = Gf2_3

GF16 = Gf2_4

GF32 = Gf2_5

GF64 = Gf2_6

GF128 = Gf2_7

GF256 = Gf2_8

# List of log-tables, exponential-tables and inversion-tables
const GF__2_1_EXP = Gf2_1[1,0,0,]

const GF__2_1_LOG = Int[1,0,]

const GF__2_1_INV = Gf2_1[1,]

const GF__2_1_ORD = Int[1,]

const GF__2_2_EXP = Gf2_2[1,2,3,1,2,0,0,0,0,0,0,]

const GF__2_2_LOG = Int[5,0,1,2,]

const GF__2_2_INV = Gf2_2[1,3,2,]

const GF__2_2_ORD = Int[1,3,3,]

const GF__2_3_EXP = Gf2_3[1,2,4,3,6,7,5,1,2,4,3,6,7,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,]

const GF__2_3_LOG = Int[13,0,1,3,2,6,4,5,]

const GF__2_3_INV = Gf2_3[1,5,6,7,2,3,4,]

const GF__2_3_ORD = Int[1,7,7,7,7,7,7,]

const GF__2_4_EXP = Gf2_4[1,2,4,8,3,6,12,11,5,10,7,14,15,13,
    9,1,2,4,8,3,6,12,11,5,10,7,14,15,13,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,]

const GF__2_4_LOG = Int[29,0,1,4,2,8,5,10,3,14,9,7,6,13,
    11,12,]

const GF__2_4_INV = Gf2_4[1,9,14,13,11,7,6,15,2,12,5,10,4,3,
    8,]

const GF__2_4_ORD = Int[1,15,15,15,15,3,3,5,15,5,15,5,15,
    15,5,]

const GF__2_5_EXP = Gf2_5[1,2,4,8,16,5,10,20,13,26,17,7,14,28,
    29,31,27,19,3,6,12,24,21,15,30,25,23,11,22,
    9,18,1,2,4,8,16,5,10,20,13,26,17,7,14,
    28,29,31,27,19,3,6,12,24,21,15,30,25,23,11,
    22,9,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,]

const GF__2_5_LOG = Int[61,0,1,18,2,5,19,11,3,29,6,27,20,8,
    12,23,4,10,30,17,7,22,28,26,21,25,9,16,13,
    14,24,15,]

const GF__2_5_INV = Gf2_5[1,18,28,9,23,14,12,22,4,25,16,7,15,6,
    13,11,24,2,29,30,26,8,5,17,10,21,31,3,19,
    20,27,]

const GF__2_5_ORD = Int[1,31,31,31,31,31,31,31,31,31,31,31,31,
    31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,
    31,31,31,]

const GF__2_6_EXP = Gf2_6[1,2,4,8,16,32,27,54,55,53,49,57,41,9,
    18,36,19,38,23,46,7,14,28,56,43,13,26,52,51,
    61,33,25,50,63,37,17,34,31,62,39,21,42,15,30,
    60,35,29,58,47,5,10,20,40,11,22,44,3,6,12,
    24,48,59,45,1,2,4,8,16,32,27,54,55,53,49,
    57,41,9,18,36,19,38,23,46,7,14,28,56,43,13,
    26,52,51,61,33,25,50,63,37,17,34,31,62,39,21,
    42,15,30,60,35,29,58,47,5,10,20,40,11,22,44,
    3,6,12,24,48,59,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,]

const GF__2_6_LOG = Int[125,0,1,56,2,49,57,20,3,13,50,53,58,25,
    21,42,4,35,14,16,51,40,54,18,59,31,26,6,22,
    46,43,37,5,30,36,45,15,34,17,39,52,12,41,24,
    55,62,19,48,60,10,32,28,27,9,7,8,23,11,47,
    61,44,29,38,33,]

const GF__2_6_INV = Gf2_6[1,45,54,59,18,27,30,48,10,9,49,32,62,15,
    14,24,51,5,58,41,56,53,35,16,50,31,6,42,38,
    7,26,12,63,52,23,47,61,29,43,57,20,28,39,55,
    2,60,36,8,11,25,17,34,22,3,44,21,40,19,4,
    46,37,13,33,]

const GF__2_6_ORD = Int[1,63,9,63,9,21,63,21,63,63,63,63,63,
    3,3,63,9,9,63,21,63,7,7,63,63,63,21,63,
    63,63,63,63,21,7,7,21,63,63,21,63,21,63,21,
    63,63,63,21,21,63,63,9,7,7,9,63,63,63,63,
    63,63,63,63,21,]

const GF__2_7_EXP = Gf2_7[1,2,4,8,16,32,64,3,6,12,24,48,96,67,
    5,10,20,40,80,35,70,15,30,60,120,115,101,73,17,
    34,68,11,22,44,88,51,102,79,29,58,116,107,85,41,
    82,39,78,31,62,124,123,117,105,81,33,66,7,14,28,
    56,112,99,69,9,18,36,72,19,38,76,27,54,108,91,
    53,106,87,45,90,55,110,95,61,122,119,109,89,49,98,
    71,13,26,52,104,83,37,74,23,46,92,59,118,111,93,
    57,114,103,77,25,50,100,75,21,42,84,43,86,47,94,
    63,126,127,125,121,113,97,65,1,2,4,8,16,32,64,
    3,6,12,24,48,96,67,5,10,20,40,80,35,70,15,
    30,60,120,115,101,73,17,34,68,11,22,44,88,51,102,
    79,29,58,116,107,85,41,82,39,78,31,62,124,123,117,
    105,81,33,66,7,14,28,56,112,99,69,9,18,36,72,
    19,38,76,27,54,108,91,53,106,87,45,90,55,110,95,
    61,122,119,109,89,49,98,71,13,26,52,104,83,37,74,
    23,46,92,59,118,111,93,57,114,103,77,25,50,100,75,
    21,42,84,43,86,47,94,63,126,127,125,121,113,97,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,]

const GF__2_7_LOG = Int[253,0,1,7,2,14,8,56,3,63,15,31,9,90,
    57,21,4,28,64,67,16,112,32,97,10,108,91,70,58,
    38,22,47,5,54,29,19,65,95,68,45,17,43,113,115,
    33,77,98,117,11,87,109,35,92,74,71,79,59,104,39,
    100,23,82,48,119,6,126,55,13,30,62,20,89,66,27,
    96,111,69,107,46,37,18,53,44,94,114,42,116,76,34,
    86,78,73,99,103,118,81,12,125,88,61,110,26,36,106,
    93,52,75,41,72,85,80,102,60,124,105,25,40,51,101,
    84,24,123,83,50,49,122,120,121,]

const GF__2_7_INV = Gf2_7[1,65,126,97,42,63,54,113,18,21,74,94,79,27,
    103,121,92,9,112,75,10,37,68,47,35,102,14,76,71,
    114,110,125,91,46,25,69,22,56,61,100,119,5,96,83,
    123,34,24,86,116,80,52,51,81,7,62,38,60,98,73,
    57,39,55,6,127,2,108,84,23,36,77,29,99,59,11,
    20,28,70,95,13,50,53,122,44,67,109,48,117,104,107,
    124,33,17,120,12,78,43,4,58,72,40,118,26,15,88,
    106,105,89,66,85,31,115,19,8,30,111,49,87,101,41,
    93,16,82,45,90,32,3,64,]

const GF__2_7_ORD = Int[1,127,127,127,127,127,127,127,127,127,127,127,127,
    127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,
    127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,
    127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,
    127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,
    127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,
    127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,
    127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,
    127,127,127,127,127,127,127,127,127,]

const GF__2_8_EXP = Gf2_8[1,2,4,8,16,32,64,128,29,58,116,232,205,135,
    19,38,76,152,45,90,180,117,234,201,143,3,6,12,24,
    48,96,192,157,39,78,156,37,74,148,53,106,212,181,119,
    238,193,159,35,70,140,5,10,20,40,80,160,93,186,105,
    210,185,111,222,161,95,190,97,194,153,47,94,188,101,202,
    137,15,30,60,120,240,253,231,211,187,107,214,177,127,254,
    225,223,163,91,182,113,226,217,175,67,134,17,34,68,136,
    13,26,52,104,208,189,103,206,129,31,62,124,248,237,199,
    147,59,118,236,197,151,51,102,204,133,23,46,92,184,109,
    218,169,79,158,33,66,132,21,42,84,168,77,154,41,82,
    164,85,170,73,146,57,114,228,213,183,115,230,209,191,99,
    198,145,63,126,252,229,215,179,123,246,241,255,227,219,171,
    75,150,49,98,196,149,55,110,220,165,87,174,65,130,25,
    50,100,200,141,7,14,28,56,112,224,221,167,83,166,81,
    162,89,178,121,242,249,239,195,155,43,86,172,69,138,9,
    18,36,72,144,61,122,244,245,247,243,251,235,203,139,11,
    22,44,88,176,125,250,233,207,131,27,54,108,216,173,71,
    142,1,2,4,8,16,32,64,128,29,58,116,232,205,135,
    19,38,76,152,45,90,180,117,234,201,143,3,6,12,24,
    48,96,192,157,39,78,156,37,74,148,53,106,212,181,119,
    238,193,159,35,70,140,5,10,20,40,80,160,93,186,105,
    210,185,111,222,161,95,190,97,194,153,47,94,188,101,202,
    137,15,30,60,120,240,253,231,211,187,107,214,177,127,254,
    225,223,163,91,182,113,226,217,175,67,134,17,34,68,136,
    13,26,52,104,208,189,103,206,129,31,62,124,248,237,199,
    147,59,118,236,197,151,51,102,204,133,23,46,92,184,109,
    218,169,79,158,33,66,132,21,42,84,168,77,154,41,82,
    164,85,170,73,146,57,114,228,213,183,115,230,209,191,99,
    198,145,63,126,252,229,215,179,123,246,241,255,227,219,171,
    75,150,49,98,196,149,55,110,220,165,87,174,65,130,25,
    50,100,200,141,7,14,28,56,112,224,221,167,83,166,81,
    162,89,178,121,242,249,239,195,155,43,86,172,69,138,9,
    18,36,72,144,61,122,244,245,247,243,251,235,203,139,11,
    22,44,88,176,125,250,233,207,131,27,54,108,216,173,71,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,]

const GF__2_8_LOG = Int[509,0,1,25,2,50,26,198,3,223,51,238,27,104,
    199,75,4,100,224,14,52,141,239,129,28,193,105,248,200,
    8,76,113,5,138,101,47,225,36,15,33,53,147,142,218,
    240,18,130,69,29,181,194,125,106,39,249,185,201,154,9,
    120,77,228,114,166,6,191,139,98,102,221,48,253,226,152,
    37,179,16,145,34,136,54,208,148,206,143,150,219,189,241,
    210,19,92,131,56,70,64,30,66,182,163,195,72,126,110,
    107,58,40,84,250,133,186,61,202,94,155,159,10,21,121,
    43,78,212,229,172,115,243,167,87,7,112,192,247,140,128,
    99,13,103,74,222,237,49,197,254,24,227,165,153,119,38,
    184,180,124,17,68,146,217,35,32,137,46,55,63,209,91,
    149,188,207,205,144,135,151,178,220,252,190,97,242,86,211,
    171,20,42,93,158,132,60,57,83,71,109,65,162,31,45,
    67,216,183,123,164,118,196,23,73,236,127,12,111,246,108,
    161,59,82,41,157,85,170,251,96,134,177,187,204,62,90,
    203,89,95,176,156,169,160,81,11,245,22,235,122,117,44,
    215,79,174,213,233,230,231,173,232,116,214,244,234,168,80,
    88,175,]

const GF__2_8_INV = Gf2_8[1,142,244,71,167,122,186,173,157,221,152,61,170,93,
    150,216,114,192,88,224,62,76,102,144,222,85,128,160,131,
    75,42,108,237,57,81,96,86,44,138,112,208,31,74,38,
    139,51,110,72,137,111,46,164,195,64,94,80,34,207,169,
    171,12,21,225,54,95,248,213,146,78,166,4,48,136,43,
    30,22,103,69,147,56,35,104,140,129,26,37,97,19,193,
    203,99,151,14,55,65,36,87,202,91,185,196,23,77,82,
    141,239,179,32,236,47,50,40,209,17,217,233,251,218,121,
    219,119,6,187,132,205,254,252,27,84,161,29,124,204,228,
    176,73,49,39,45,83,105,2,245,24,223,68,79,155,188,
    15,92,11,220,189,148,172,9,199,162,28,130,159,198,52,
    194,70,5,206,59,13,60,156,8,190,183,135,229,238,107,
    235,242,191,175,197,100,7,123,149,154,174,182,18,89,165,
    53,101,184,163,158,210,247,98,90,133,125,168,58,41,113,
    200,246,249,67,215,214,16,115,118,120,153,10,25,145,20,
    63,230,240,134,177,226,241,250,116,243,180,109,33,178,106,
    227,231,181,234,3,143,211,201,66,212,232,117,127,255,126,
    253,]

const GF__2_8_ORD = Int[1,255,51,255,51,255,85,85,255,5,15,85,255,
    255,17,255,51,255,255,255,85,255,85,255,255,17,255,51,
    255,255,255,51,85,255,255,17,85,17,85,255,85,255,255,
    17,85,51,85,255,255,255,51,255,85,85,51,85,255,85,
    17,255,85,85,255,85,255,255,255,5,15,85,255,255,255,
    255,255,255,51,15,15,85,255,255,255,255,17,85,85,255,
    17,255,255,255,255,51,255,17,85,255,255,17,85,85,51,
    255,255,51,85,51,255,85,255,255,255,51,85,51,85,255,
    255,85,255,255,255,51,85,255,85,255,255,85,255,51,255,
    85,255,255,255,85,85,255,255,255,85,255,17,5,15,255,
    255,17,255,15,15,255,255,51,255,255,255,51,85,255,255,
    255,255,85,51,85,17,255,255,51,85,51,255,255,255,255,
    85,51,85,85,255,85,17,85,255,255,255,51,85,255,17,
    255,85,85,85,255,255,255,255,255,255,255,85,85,85,85,
    255,255,255,255,255,3,3,255,85,255,85,15,5,255,17,
    255,255,51,255,85,255,51,85,255,51,255,51,255,85,255,
    51,255,85,85,255,51,85,255,255,255,255,255,85,85,51,
    255,51,]

# This allows the REPL to show values of type Gf2.
Base.show(io::IO, x::Gf2_1) = print(io, x.value)
Base.show(io::IO, x::Gf2_2) = print(io, x.value)
Base.show(io::IO, x::Gf2_3) = print(io, x.value)
Base.show(io::IO, x::Gf2_4) = print(io, x.value)
Base.show(io::IO, x::Gf2_5) = print(io, x.value)
Base.show(io::IO, x::Gf2_6) = print(io, x.value)
Base.show(io::IO, x::Gf2_7) = print(io, x.value)
Base.show(io::IO, x::Gf2_8) = print(io, x.value)

# Show binary representation of each element
Base.bitstring(x::Gf2_1) = bitstring(x.value)[(end-1+1):end]
Base.bitstring(x::Gf2_2) = bitstring(x.value)[(end-2+1):end]
Base.bitstring(x::Gf2_3) = bitstring(x.value)[(end-3+1):end]
Base.bitstring(x::Gf2_4) = bitstring(x.value)[(end-4+1):end]
Base.bitstring(x::Gf2_5) = bitstring(x.value)[(end-5+1):end]
Base.bitstring(x::Gf2_6) = bitstring(x.value)[(end-6+1):end]
Base.bitstring(x::Gf2_7) = bitstring(x.value)[(end-7+1):end]
Base.bitstring(x::Gf2_8) = bitstring(x.value)[(end-8+1):end]

# Promotion rules
Base.promote_rule(::Type{Gf2_2}, ::Type{Gf2_1}) = Gf2_2
Base.promote_rule(::Type{Gf2_3}, ::Type{Gf2_1}) = Gf2_3
Base.promote_rule(::Type{Gf2_4}, ::Type{Gf2_1}) = Gf2_4
Base.promote_rule(::Type{Gf2_4}, ::Type{Gf2_2}) = Gf2_4
Base.promote_rule(::Type{Gf2_5}, ::Type{Gf2_1}) = Gf2_5
Base.promote_rule(::Type{Gf2_6}, ::Type{Gf2_1}) = Gf2_6
Base.promote_rule(::Type{Gf2_6}, ::Type{Gf2_2}) = Gf2_6
Base.promote_rule(::Type{Gf2_6}, ::Type{Gf2_3}) = Gf2_6
Base.promote_rule(::Type{Gf2_7}, ::Type{Gf2_1}) = Gf2_7
Base.promote_rule(::Type{Gf2_8}, ::Type{Gf2_1}) = Gf2_8
Base.promote_rule(::Type{Gf2_8}, ::Type{Gf2_2}) = Gf2_8
Base.promote_rule(::Type{Gf2_8}, ::Type{Gf2_4}) = Gf2_8

# Conversions
Base.convert(::Type{Gf2_1}, x::Gf2_1) = x
Base.convert(::Type{Gf2_1}, x::Gf2_2) = x.value < 2 ? Gf2_1(x.value) : error("the element $(x.value) from the field of size 2^2 is not a member of the subfield of size 2.")
Base.convert(::Type{Gf2_1}, x::Gf2_3) = x.value < 2 ? Gf2_1(x.value) : error("the element $(x.value) from the field of size 2^3 is not a member of the subfield of size 2.")
Base.convert(::Type{Gf2_1}, x::Gf2_4) = x.value < 2 ? Gf2_1(x.value) : error("the element $(x.value) from the field of size 2^4 is not a member of the subfield of size 2.")
Base.convert(::Type{Gf2_1}, x::Gf2_5) = x.value < 2 ? Gf2_1(x.value) : error("the element $(x.value) from the field of size 2^5 is not a member of the subfield of size 2.")
Base.convert(::Type{Gf2_1}, x::Gf2_6) = x.value < 2 ? Gf2_1(x.value) : error("the element $(x.value) from the field of size 2^6 is not a member of the subfield of size 2.")
Base.convert(::Type{Gf2_1}, x::Gf2_7) = x.value < 2 ? Gf2_1(x.value) : error("the element $(x.value) from the field of size 2^7 is not a member of the subfield of size 2.")
Base.convert(::Type{Gf2_1}, x::Gf2_8) = x.value < 2 ? Gf2_1(x.value) : error("the element $(x.value) from the field of size 2^8 is not a member of the subfield of size 2.")
Base.convert(::Type{Gf2_2}, x::Gf2_1) = x.value == 0 ? Gf2_2(0) : gfexp(2, gflog(x) * 3)
Base.convert(::Type{Gf2_2}, x::Gf2_2) = x
Base.convert(::Type{Gf2_2}, x::Gf2_4) = x.value == 0 ? Gf2_2(0) : (3 % gforder(x) == 0 ? gfexp(2, div(gflog(x) * 3, 15)) : error("the element $(x.value) from the field of size 2^4 is not a member of the subfield of size 2^2."))
Base.convert(::Type{Gf2_2}, x::Gf2_6) = x.value == 0 ? Gf2_2(0) : (3 % gforder(x) == 0 ? gfexp(2, div(gflog(x) * 3, 63)) : error("the element $(x.value) from the field of size 2^6 is not a member of the subfield of size 2^2."))
Base.convert(::Type{Gf2_2}, x::Gf2_8) = x.value == 0 ? Gf2_2(0) : (3 % gforder(x) == 0 ? gfexp(2, div(gflog(x) * 3, 255)) : error("the element $(x.value) from the field of size 2^8 is not a member of the subfield of size 2^2."))
Base.convert(::Type{Gf2_3}, x::Gf2_1) = x.value == 0 ? Gf2_3(0) : gfexp(3, gflog(x) * 7)
Base.convert(::Type{Gf2_3}, x::Gf2_3) = x
Base.convert(::Type{Gf2_3}, x::Gf2_6) = x.value == 0 ? Gf2_3(0) : (7 % gforder(x) == 0 ? gfexp(3, div(gflog(x) * 7, 63)) : error("the element $(x.value) from the field of size 2^6 is not a member of the subfield of size 2^3."))
Base.convert(::Type{Gf2_4}, x::Gf2_1) = x.value == 0 ? Gf2_4(0) : gfexp(4, gflog(x) * 15)
Base.convert(::Type{Gf2_4}, x::Gf2_2) = x.value == 0 ? Gf2_4(0) : gfexp(4, gflog(x) * 5)
Base.convert(::Type{Gf2_4}, x::Gf2_4) = x
Base.convert(::Type{Gf2_4}, x::Gf2_8) = x.value == 0 ? Gf2_4(0) : (15 % gforder(x) == 0 ? gfexp(4, div(gflog(x) * 15, 255)) : error("the element $(x.value) from the field of size 2^8 is not a member of the subfield of size 2^4."))
Base.convert(::Type{Gf2_5}, x::Gf2_1) = x.value == 0 ? Gf2_5(0) : gfexp(5, gflog(x) * 31)
Base.convert(::Type{Gf2_5}, x::Gf2_5) = x
Base.convert(::Type{Gf2_6}, x::Gf2_1) = x.value == 0 ? Gf2_6(0) : gfexp(6, gflog(x) * 63)
Base.convert(::Type{Gf2_6}, x::Gf2_2) = x.value == 0 ? Gf2_6(0) : gfexp(6, gflog(x) * 21)
Base.convert(::Type{Gf2_6}, x::Gf2_3) = x.value == 0 ? Gf2_6(0) : gfexp(6, gflog(x) * 9)
Base.convert(::Type{Gf2_6}, x::Gf2_6) = x
Base.convert(::Type{Gf2_7}, x::Gf2_1) = x.value == 0 ? Gf2_7(0) : gfexp(7, gflog(x) * 127)
Base.convert(::Type{Gf2_7}, x::Gf2_7) = x
Base.convert(::Type{Gf2_8}, x::Gf2_1) = x.value == 0 ? Gf2_8(0) : gfexp(8, gflog(x) * 255)
Base.convert(::Type{Gf2_8}, x::Gf2_2) = x.value == 0 ? Gf2_8(0) : gfexp(8, gflog(x) * 85)
Base.convert(::Type{Gf2_8}, x::Gf2_4) = x.value == 0 ? Gf2_8(0) : gfexp(8, gflog(x) * 17)
Base.convert(::Type{Gf2_8}, x::Gf2_8) = x

# Definition of methods for extending comparison operators
Base.:(==)(x::Gf2_1, y::Gf2_1) = x.value == y.value
Base.:(==)(x::Gf2_2, y::Gf2_2) = x.value == y.value
Base.:(==)(x::Gf2_3, y::Gf2_3) = x.value == y.value
Base.:(==)(x::Gf2_4, y::Gf2_4) = x.value == y.value
Base.:(==)(x::Gf2_5, y::Gf2_5) = x.value == y.value
Base.:(==)(x::Gf2_6, y::Gf2_6) = x.value == y.value
Base.:(==)(x::Gf2_7, y::Gf2_7) = x.value == y.value
Base.:(==)(x::Gf2_8, y::Gf2_8) = x.value == y.value
Base.:(==)(x::Gf2, y::Gf2) = try ==(promote(x, y)...) catch ME false end

Base.:(!=)(x::Gf2_1, y::Gf2_1) = !(x.value == y.value)
Base.:(!=)(x::Gf2_2, y::Gf2_2) = !(x.value == y.value)
Base.:(!=)(x::Gf2_3, y::Gf2_3) = !(x.value == y.value)
Base.:(!=)(x::Gf2_4, y::Gf2_4) = !(x.value == y.value)
Base.:(!=)(x::Gf2_5, y::Gf2_5) = !(x.value == y.value)
Base.:(!=)(x::Gf2_6, y::Gf2_6) = !(x.value == y.value)
Base.:(!=)(x::Gf2_7, y::Gf2_7) = !(x.value == y.value)
Base.:(!=)(x::Gf2_8, y::Gf2_8) = !(x.value == y.value)
Base.:(!=)(x::Gf2, y::Gf2) = try !=(promote(x, y)...) catch ME true end

# Definition of methods for extending bitwise operators
Base.:~(x::Gf2_1) = Gf2_1(xor(x.value,  1))
Base.:~(x::Gf2_2) = Gf2_2(xor(x.value,  3))
Base.:~(x::Gf2_3) = Gf2_3(xor(x.value,  7))
Base.:~(x::Gf2_4) = Gf2_4(xor(x.value,  15))
Base.:~(x::Gf2_5) = Gf2_5(xor(x.value,  31))
Base.:~(x::Gf2_6) = Gf2_6(xor(x.value,  63))
Base.:~(x::Gf2_7) = Gf2_7(xor(x.value,  127))
Base.:~(x::Gf2_8) = Gf2_8(xor(x.value,  255))

Base.:&(x::Gf2_1, y::Gf2_1) = Gf2_1(x.value & y.value)
Base.:&(x::Gf2_2, y::Gf2_2) = Gf2_2(x.value & y.value)
Base.:&(x::Gf2_3, y::Gf2_3) = Gf2_3(x.value & y.value)
Base.:&(x::Gf2_4, y::Gf2_4) = Gf2_4(x.value & y.value)
Base.:&(x::Gf2_5, y::Gf2_5) = Gf2_5(x.value & y.value)
Base.:&(x::Gf2_6, y::Gf2_6) = Gf2_6(x.value & y.value)
Base.:&(x::Gf2_7, y::Gf2_7) = Gf2_7(x.value & y.value)
Base.:&(x::Gf2_8, y::Gf2_8) = Gf2_8(x.value & y.value)
Base.:&(x::Gf2, y::Gf2) = (&)(promote(x, y)...)

Base.:|(x::Gf2_1, y::Gf2_1) = Gf2_1(x.value | y.value)
Base.:|(x::Gf2_2, y::Gf2_2) = Gf2_2(x.value | y.value)
Base.:|(x::Gf2_3, y::Gf2_3) = Gf2_3(x.value | y.value)
Base.:|(x::Gf2_4, y::Gf2_4) = Gf2_4(x.value | y.value)
Base.:|(x::Gf2_5, y::Gf2_5) = Gf2_5(x.value | y.value)
Base.:|(x::Gf2_6, y::Gf2_6) = Gf2_6(x.value | y.value)
Base.:|(x::Gf2_7, y::Gf2_7) = Gf2_7(x.value | y.value)
Base.:|(x::Gf2_8, y::Gf2_8) = Gf2_8(x.value | y.value)
Base.:|(x::Gf2, y::Gf2) = (|)(promote(x, y)...)

Base.xor(x::Gf2_1, y::Gf2_1) = Gf2_1(xor(x.value, y.value))
Base.xor(x::Gf2_2, y::Gf2_2) = Gf2_2(xor(x.value, y.value))
Base.xor(x::Gf2_3, y::Gf2_3) = Gf2_3(xor(x.value, y.value))
Base.xor(x::Gf2_4, y::Gf2_4) = Gf2_4(xor(x.value, y.value))
Base.xor(x::Gf2_5, y::Gf2_5) = Gf2_5(xor(x.value, y.value))
Base.xor(x::Gf2_6, y::Gf2_6) = Gf2_6(xor(x.value, y.value))
Base.xor(x::Gf2_7, y::Gf2_7) = Gf2_7(xor(x.value, y.value))
Base.xor(x::Gf2_8, y::Gf2_8) = Gf2_8(xor(x.value, y.value))
Base.xor(x::Gf2, y::Gf2) = xor(promote(x, y)...)

# Definition of methods for extending arithmetic operators
Base.:+(x::Gf2_1) = x
Base.:+(x::Gf2_2) = x
Base.:+(x::Gf2_3) = x
Base.:+(x::Gf2_4) = x
Base.:+(x::Gf2_5) = x
Base.:+(x::Gf2_6) = x
Base.:+(x::Gf2_7) = x
Base.:+(x::Gf2_8) = x

Base.:-(x::Gf2_1) = x
Base.:-(x::Gf2_2) = x
Base.:-(x::Gf2_3) = x
Base.:-(x::Gf2_4) = x
Base.:-(x::Gf2_5) = x
Base.:-(x::Gf2_6) = x
Base.:-(x::Gf2_7) = x
Base.:-(x::Gf2_8) = x

Base.:+(x::Gf2_1, y::Gf2_1) = Gf2_1(xor(x.value, y.value))
Base.:+(x::Gf2_2, y::Gf2_2) = Gf2_2(xor(x.value, y.value))
Base.:+(x::Gf2_3, y::Gf2_3) = Gf2_3(xor(x.value, y.value))
Base.:+(x::Gf2_4, y::Gf2_4) = Gf2_4(xor(x.value, y.value))
Base.:+(x::Gf2_5, y::Gf2_5) = Gf2_5(xor(x.value, y.value))
Base.:+(x::Gf2_6, y::Gf2_6) = Gf2_6(xor(x.value, y.value))
Base.:+(x::Gf2_7, y::Gf2_7) = Gf2_7(xor(x.value, y.value))
Base.:+(x::Gf2_8, y::Gf2_8) = Gf2_8(xor(x.value, y.value))
Base.:+(x::Gf2, y::Gf2) = +(promote(x, y)...)

Base.:-(x::Gf2_1, y::Gf2_1) = Gf2_1(xor(x.value, y.value))
Base.:-(x::Gf2_2, y::Gf2_2) = Gf2_2(xor(x.value, y.value))
Base.:-(x::Gf2_3, y::Gf2_3) = Gf2_3(xor(x.value, y.value))
Base.:-(x::Gf2_4, y::Gf2_4) = Gf2_4(xor(x.value, y.value))
Base.:-(x::Gf2_5, y::Gf2_5) = Gf2_5(xor(x.value, y.value))
Base.:-(x::Gf2_6, y::Gf2_6) = Gf2_6(xor(x.value, y.value))
Base.:-(x::Gf2_7, y::Gf2_7) = Gf2_7(xor(x.value, y.value))
Base.:-(x::Gf2_8, y::Gf2_8) = Gf2_8(xor(x.value, y.value))
Base.:-(x::Gf2, y::Gf2) = -(promote(x, y)...)


Base.:*(x::Gf2_1, y::Gf2_1) = GF__2_1_EXP[GF__2_1_LOG[x.value + 1] + GF__2_1_LOG[y.value + 1] + 1]
Base.:*(x::Gf2_2, y::Gf2_2) = GF__2_2_EXP[GF__2_2_LOG[x.value + 1] + GF__2_2_LOG[y.value + 1] + 1]
Base.:*(x::Gf2_3, y::Gf2_3) = GF__2_3_EXP[GF__2_3_LOG[x.value + 1] + GF__2_3_LOG[y.value + 1] + 1]
Base.:*(x::Gf2_4, y::Gf2_4) = GF__2_4_EXP[GF__2_4_LOG[x.value + 1] + GF__2_4_LOG[y.value + 1] + 1]
Base.:*(x::Gf2_5, y::Gf2_5) = GF__2_5_EXP[GF__2_5_LOG[x.value + 1] + GF__2_5_LOG[y.value + 1] + 1]
Base.:*(x::Gf2_6, y::Gf2_6) = GF__2_6_EXP[GF__2_6_LOG[x.value + 1] + GF__2_6_LOG[y.value + 1] + 1]
Base.:*(x::Gf2_7, y::Gf2_7) = GF__2_7_EXP[GF__2_7_LOG[x.value + 1] + GF__2_7_LOG[y.value + 1] + 1]
Base.:*(x::Gf2_8, y::Gf2_8) = GF__2_8_EXP[GF__2_8_LOG[x.value + 1] + GF__2_8_LOG[y.value + 1] + 1]
Base.:*(x::Gf2, y::Gf2) = *(promote(x, y)...)

Base.:/(x::Gf2_1, y::Gf2_1) = y.value != 0 ? (x * GF__2_1_INV[y.value]) : throw(ArgumentError("division by zero!"))
Base.:/(x::Gf2_2, y::Gf2_2) = y.value != 0 ? (x * GF__2_2_INV[y.value]) : throw(ArgumentError("division by zero!"))
Base.:/(x::Gf2_3, y::Gf2_3) = y.value != 0 ? (x * GF__2_3_INV[y.value]) : throw(ArgumentError("division by zero!"))
Base.:/(x::Gf2_4, y::Gf2_4) = y.value != 0 ? (x * GF__2_4_INV[y.value]) : throw(ArgumentError("division by zero!"))
Base.:/(x::Gf2_5, y::Gf2_5) = y.value != 0 ? (x * GF__2_5_INV[y.value]) : throw(ArgumentError("division by zero!"))
Base.:/(x::Gf2_6, y::Gf2_6) = y.value != 0 ? (x * GF__2_6_INV[y.value]) : throw(ArgumentError("division by zero!"))
Base.:/(x::Gf2_7, y::Gf2_7) = y.value != 0 ? (x * GF__2_7_INV[y.value]) : throw(ArgumentError("division by zero!"))
Base.:/(x::Gf2_8, y::Gf2_8) = y.value != 0 ? (x * GF__2_8_INV[y.value]) : throw(ArgumentError("division by zero!"))
Base.:/(x::Gf2, y::Gf2) = /(promote(x, y)...)

Base.:inv(x::Gf2_1) = x.value != 0 ? GF__2_1_INV[x.value] : throw(ArgumentError("impossible to invert the zero element!"))
Base.:inv(x::Gf2_2) = x.value != 0 ? GF__2_2_INV[x.value] : throw(ArgumentError("impossible to invert the zero element!"))
Base.:inv(x::Gf2_3) = x.value != 0 ? GF__2_3_INV[x.value] : throw(ArgumentError("impossible to invert the zero element!"))
Base.:inv(x::Gf2_4) = x.value != 0 ? GF__2_4_INV[x.value] : throw(ArgumentError("impossible to invert the zero element!"))
Base.:inv(x::Gf2_5) = x.value != 0 ? GF__2_5_INV[x.value] : throw(ArgumentError("impossible to invert the zero element!"))
Base.:inv(x::Gf2_6) = x.value != 0 ? GF__2_6_INV[x.value] : throw(ArgumentError("impossible to invert the zero element!"))
Base.:inv(x::Gf2_7) = x.value != 0 ? GF__2_7_INV[x.value] : throw(ArgumentError("impossible to invert the zero element!"))
Base.:inv(x::Gf2_8) = x.value != 0 ? GF__2_8_INV[x.value] : throw(ArgumentError("impossible to invert the zero element!"))

# Utility functions
gffieldsize(x::Gf2_1) = 2
gffieldsize(x::Gf2_2) = 4
gffieldsize(x::Gf2_3) = 8
gffieldsize(x::Gf2_4) = 16
gffieldsize(x::Gf2_5) = 32
gffieldsize(x::Gf2_6) = 64
gffieldsize(x::Gf2_7) = 128
gffieldsize(x::Gf2_8) = 256

gffieldsize(::Type{Gf2_1}) = 2
gffieldsize(::Type{Gf2_2}) = 4
gffieldsize(::Type{Gf2_3}) = 8
gffieldsize(::Type{Gf2_4}) = 16
gffieldsize(::Type{Gf2_5}) = 32
gffieldsize(::Type{Gf2_6}) = 64
gffieldsize(::Type{Gf2_7}) = 128
gffieldsize(::Type{Gf2_8}) = 256

gffieldextensiondegree(x::Gf2_1) = 1
gffieldextensiondegree(x::Gf2_2) = 2
gffieldextensiondegree(x::Gf2_3) = 3
gffieldextensiondegree(x::Gf2_4) = 4
gffieldextensiondegree(x::Gf2_5) = 5
gffieldextensiondegree(x::Gf2_6) = 6
gffieldextensiondegree(x::Gf2_7) = 7
gffieldextensiondegree(x::Gf2_8) = 8

gffieldextensiondegree(::Type{Gf2_1}) = 1
gffieldextensiondegree(::Type{Gf2_2}) = 2
gffieldextensiondegree(::Type{Gf2_3}) = 3
gffieldextensiondegree(::Type{Gf2_4}) = 4
gffieldextensiondegree(::Type{Gf2_5}) = 5
gffieldextensiondegree(::Type{Gf2_6}) = 6
gffieldextensiondegree(::Type{Gf2_7}) = 7
gffieldextensiondegree(::Type{Gf2_8}) = 8

function gfzero(T::Int)
    if T==1 Gf2_1(0)
    elseif T==2 Gf2_2(0)
    elseif T==3 Gf2_3(0)
    elseif T==4 Gf2_4(0)
    elseif T==5 Gf2_5(0)
    elseif T==6 Gf2_6(0)
    elseif T==7 Gf2_7(0)
    elseif T==8 Gf2_8(0)
    else error("the input argument to gfzero() must be in this list: [1, 2, 3, 4, 5, 6, 7, 8]")
    end
end

gfzero(::Type{Gf2_1}) = Gf2_1(0)
gfzero(::Type{Gf2_2}) = Gf2_2(0)
gfzero(::Type{Gf2_3}) = Gf2_3(0)
gfzero(::Type{Gf2_4}) = Gf2_4(0)
gfzero(::Type{Gf2_5}) = Gf2_5(0)
gfzero(::Type{Gf2_6}) = Gf2_6(0)
gfzero(::Type{Gf2_7}) = Gf2_7(0)
gfzero(::Type{Gf2_8}) = Gf2_8(0)

function gfone(T::Int)
    if T==1 Gf2_1(1)
    elseif T==2 Gf2_2(1)
    elseif T==3 Gf2_3(1)
    elseif T==4 Gf2_4(1)
    elseif T==5 Gf2_5(1)
    elseif T==6 Gf2_6(1)
    elseif T==7 Gf2_7(1)
    elseif T==8 Gf2_8(1)
    else error("the input argument to gfone() must be in this list: [1, 2, 3, 4, 5, 6, 7, 8]")
    end
end

gfone(::Type{Gf2_1}) = Gf2_1(1)
gfone(::Type{Gf2_2}) = Gf2_2(1)
gfone(::Type{Gf2_3}) = Gf2_3(1)
gfone(::Type{Gf2_4}) = Gf2_4(1)
gfone(::Type{Gf2_5}) = Gf2_5(1)
gfone(::Type{Gf2_6}) = Gf2_6(1)
gfone(::Type{Gf2_7}) = Gf2_7(1)
gfone(::Type{Gf2_8}) = Gf2_8(1)

function gfprimitive(T::Int)
    if T==1 Gf2_1(1)
    elseif T==2 Gf2_2(2)
    elseif T==3 Gf2_3(2)
    elseif T==4 Gf2_4(2)
    elseif T==5 Gf2_5(2)
    elseif T==6 Gf2_6(2)
    elseif T==7 Gf2_7(2)
    elseif T==8 Gf2_8(2)
    else error("the input parameter to gfprimitive() must be in this list: [1, 2, 3, 4, 5, 6, 7, 8]")
    end
end

gfprimitive(::Type{Gf2_1}) = Gf2_1(1)
gfprimitive(::Type{Gf2_2}) = Gf2_2(2)
gfprimitive(::Type{Gf2_3}) = Gf2_3(2)
gfprimitive(::Type{Gf2_4}) = Gf2_4(2)
gfprimitive(::Type{Gf2_5}) = Gf2_5(2)
gfprimitive(::Type{Gf2_6}) = Gf2_6(2)
gfprimitive(::Type{Gf2_7}) = Gf2_7(2)
gfprimitive(::Type{Gf2_8}) = Gf2_8(2)

isprimitive(x::Gf2_1) = x.value == 0 ? false : (gforder(x) == 1 ? true : false)
isprimitive(x::Gf2_2) = x.value == 0 ? false : (gforder(x) == 3 ? true : false)
isprimitive(x::Gf2_3) = x.value == 0 ? false : (gforder(x) == 7 ? true : false)
isprimitive(x::Gf2_4) = x.value == 0 ? false : (gforder(x) == 15 ? true : false)
isprimitive(x::Gf2_5) = x.value == 0 ? false : (gforder(x) == 31 ? true : false)
isprimitive(x::Gf2_6) = x.value == 0 ? false : (gforder(x) == 63 ? true : false)
isprimitive(x::Gf2_7) = x.value == 0 ? false : (gforder(x) == 127 ? true : false)
isprimitive(x::Gf2_8) = x.value == 0 ? false : (gforder(x) == 255 ? true : false)

gflog(x::Gf2_1) = x.value != 0 ? (GF__2_1_LOG[x.value + 1]) : throw(ArgumentError("gflog(0) is undefined!"))
gflog(x::Gf2_2) = x.value != 0 ? (GF__2_2_LOG[x.value + 1]) : throw(ArgumentError("gflog(0) is undefined!"))
gflog(x::Gf2_3) = x.value != 0 ? (GF__2_3_LOG[x.value + 1]) : throw(ArgumentError("gflog(0) is undefined!"))
gflog(x::Gf2_4) = x.value != 0 ? (GF__2_4_LOG[x.value + 1]) : throw(ArgumentError("gflog(0) is undefined!"))
gflog(x::Gf2_5) = x.value != 0 ? (GF__2_5_LOG[x.value + 1]) : throw(ArgumentError("gflog(0) is undefined!"))
gflog(x::Gf2_6) = x.value != 0 ? (GF__2_6_LOG[x.value + 1]) : throw(ArgumentError("gflog(0) is undefined!"))
gflog(x::Gf2_7) = x.value != 0 ? (GF__2_7_LOG[x.value + 1]) : throw(ArgumentError("gflog(0) is undefined!"))
gflog(x::Gf2_8) = x.value != 0 ? (GF__2_8_LOG[x.value + 1]) : throw(ArgumentError("gflog(0) is undefined!"))

function gfexp(T::Int, x::Int) 
    if T==1 GF__2_1_EXP[(x % 1) + 1]
    elseif T==2 GF__2_2_EXP[(x % 3) + 1]
    elseif T==3 GF__2_3_EXP[(x % 7) + 1]
    elseif T==4 GF__2_4_EXP[(x % 15) + 1]
    elseif T==5 GF__2_5_EXP[(x % 31) + 1]
    elseif T==6 GF__2_6_EXP[(x % 63) + 1]
    elseif T==7 GF__2_7_EXP[(x % 127) + 1]
    elseif T==8 GF__2_8_EXP[(x % 255) + 1]
    else error("the first input parameter to gfexp(T::Int, x::Int) must be in this list: [1, 2, 3, 4, 5, 6, 7, 8]")
    end
end

gfexp(::Type{Gf2_1}, x::Int) = Gf2_1(1)
gfexp(::Type{Gf2_2}, x::Int) = GF__2_2_EXP[(x % 3) + 1]
gfexp(::Type{Gf2_3}, x::Int) = GF__2_3_EXP[(x % 7) + 1]
gfexp(::Type{Gf2_4}, x::Int) = GF__2_4_EXP[(x % 15) + 1]
gfexp(::Type{Gf2_5}, x::Int) = GF__2_5_EXP[(x % 31) + 1]
gfexp(::Type{Gf2_6}, x::Int) = GF__2_6_EXP[(x % 63) + 1]
gfexp(::Type{Gf2_7}, x::Int) = GF__2_7_EXP[(x % 127) + 1]
gfexp(::Type{Gf2_8}, x::Int) = GF__2_8_EXP[(x % 255) + 1]

gforder(x::Gf2_1) = x.value != 0 ? GF__2_1_ORD[x.value] : throw(ArgumentError("gforder(0) is undefined!"))
gforder(x::Gf2_2) = x.value != 0 ? GF__2_2_ORD[x.value] : throw(ArgumentError("gforder(0) is undefined!"))
gforder(x::Gf2_3) = x.value != 0 ? GF__2_3_ORD[x.value] : throw(ArgumentError("gforder(0) is undefined!"))
gforder(x::Gf2_4) = x.value != 0 ? GF__2_4_ORD[x.value] : throw(ArgumentError("gforder(0) is undefined!"))
gforder(x::Gf2_5) = x.value != 0 ? GF__2_5_ORD[x.value] : throw(ArgumentError("gforder(0) is undefined!"))
gforder(x::Gf2_6) = x.value != 0 ? GF__2_6_ORD[x.value] : throw(ArgumentError("gforder(0) is undefined!"))
gforder(x::Gf2_7) = x.value != 0 ? GF__2_7_ORD[x.value] : throw(ArgumentError("gforder(0) is undefined!"))
gforder(x::Gf2_8) = x.value != 0 ? GF__2_8_ORD[x.value] : throw(ArgumentError("gforder(0) is undefined!"))

Base.zero(x::Gf2_1) = Gf2_1(0)
Base.zero(x::Gf2_2) = Gf2_2(0)
Base.zero(x::Gf2_3) = Gf2_3(0)
Base.zero(x::Gf2_4) = Gf2_4(0)
Base.zero(x::Gf2_5) = Gf2_5(0)
Base.zero(x::Gf2_6) = Gf2_6(0)
Base.zero(x::Gf2_7) = Gf2_7(0)
Base.zero(x::Gf2_8) = Gf2_8(0)

Base.zero(::Type{Gf2_1}) = Gf2_1(0)
Base.zero(::Type{Gf2_2}) = Gf2_2(0)
Base.zero(::Type{Gf2_3}) = Gf2_3(0)
Base.zero(::Type{Gf2_4}) = Gf2_4(0)
Base.zero(::Type{Gf2_5}) = Gf2_5(0)
Base.zero(::Type{Gf2_6}) = Gf2_6(0)
Base.zero(::Type{Gf2_7}) = Gf2_7(0)
Base.zero(::Type{Gf2_8}) = Gf2_8(0)

Base.one(x::Gf2_1) = Gf2_1(1)
Base.one(x::Gf2_2) = Gf2_2(1)
Base.one(x::Gf2_3) = Gf2_3(1)
Base.one(x::Gf2_4) = Gf2_4(1)
Base.one(x::Gf2_5) = Gf2_5(1)
Base.one(x::Gf2_6) = Gf2_6(1)
Base.one(x::Gf2_7) = Gf2_7(1)
Base.one(x::Gf2_8) = Gf2_8(1)

Base.one(::Type{Gf2_1}) = Gf2_1(1)
Base.one(::Type{Gf2_2}) = Gf2_2(1)
Base.one(::Type{Gf2_3}) = Gf2_3(1)
Base.one(::Type{Gf2_4}) = Gf2_4(1)
Base.one(::Type{Gf2_5}) = Gf2_5(1)
Base.one(::Type{Gf2_6}) = Gf2_6(1)
Base.one(::Type{Gf2_7}) = Gf2_7(1)
Base.one(::Type{Gf2_8}) = Gf2_8(1)

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
