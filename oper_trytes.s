#
# Filename: "oper_trytes.s"
#
# Project: Троичная МЦВМ "Сетунь" 1958 года на языке ассемблера RISC-V
#
# Create date: 05.03.2024
# Edit date:   05.03.2024
#
#
# Author:      Vladimir V.
# E-mail:      askfind@ya.ru
#
# GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
#

#
# Максимальные и минимальные значения тритов
#  TRIT1_MAX (+1)
#  TRIT1_MIN (-1)
#  TRIT3_MAX (+13)
#  TRIT3_MIN (-13)
#  TRIT4_MAX (+40)
#  TRIT4_MIN (-40)
#  TRIT5_MAX (+121)
#  TRIT5_MIN (-121)
#  TRIT9_MAX (+9841)
#  TRIT9_MIN (-9841)
#  TRIT18_MAX (+193710244L)
#  TRIT18_MIN (-193710244L)
#
#  SIZE_TRITS_MAX (32) максимальная количество тритов троичного числа	
#
#  SIZE_WORD_SHORT (9)		 короткое слово 9-трит
#  SIZE_WORD_LONG (18)		 длинное слово  18-трит
#  SIZE_WORD_LONG_LONG (36)  двойное длинное слово  36-трит

#
# Типы данных для виртуальной троичной машины "Сетунь-1958"
#
# typedef uintptr_t addr;
#
# typedef struct trs
# {
#	uint32_t ts1; /* троичное число FALSE,TRUE */
#	uint32_t ts0; /* троичное число NIL */
# } trs_t;
#
