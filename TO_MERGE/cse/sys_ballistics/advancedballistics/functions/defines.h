#define GRAVITY 9.80665
#define ABSOLUTE_ZERO_IN_CELSIUS -273.15
#define KELVIN(t) (t - ABSOLUTE_ZERO_IN_CELSIUS)
#define CELSIUS(t) (t + ABSOLUTE_ZERO_IN_CELSIUS)
#define UNIVERSAL_GAS_CONSTANT 8.314
#define WATER_VAPOR_MOLAR_MASS 0.018016
#define DRY_AIR_MOLAR_MASS 0.028964
#define SPECIFIC_GAS_CONSTANT_DRY_AIR 287.058
#define STD_AIR_DENSITY_ICAO 1.22498
#define STD_AIR_DENSITY_ASM 1.20885
#define GET_TEMPERATURE_AT_HEIGHT(h) (cse_AB_Temperature - 0.0065 * (h))