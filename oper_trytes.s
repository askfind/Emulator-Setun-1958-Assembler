#
# Filename: "oper_trytes.s"
#
# Project: Троичная МЦВМ "Сетунь" 1958 года на языке ассемблера RISC-V
#
# Create date: 05.03.2024
# Edit date:   06.03.2024
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

# -----------------------------------------------------------
# Троичные числа
#
#  TRITS-1  = [t0]       - обозначение позиции тритов в числе
#  TRITS-32 = [t31...t0] - обозначение позиции тритов в числе
#

# TODO add
#  int8_t get_trit(trs_t t, uint8_t pos);
#  trs_t set_trit(trs_t t, uint8_t pos, int8_t trit);
#  trs_t slice_trs(trs_t t, int8_t p1, int8_t p2);
#  void copy_trs(trs_t *src, trs_t *dst);
#  void clean_trs(trs_t *src);


# -----------------------------------------------------------
#
# Очистить троичное число 
#
# INPUT:        ts1,ts0      
# OUTPUT:       - 
# DESTROYED:    - 
#
# void clean_trs(trs_t *src);
#
.macro clean_trs ($ts1,$ts0)
    mv $ts1,zero
    mv $ts0,zero
.end_macro

# -----------------------------------------------------------
#
# Получить трит из позиции троичного числа
#
# INPUT:        ts1,ts0,pos      
# OUTPUT:       r = {-1,0,+1}   
# DESTROYED:    - 
#
# int8_t get_trit(trs_t t, uint8_t pos)
#
.macro get_trit ($ts1,$ts0,$pos)
        mv a1,$ts1  # a1=ts1  
        mv a0,$ts0  # a0=ts0
        mv a3,$pos
        li a4,1
        sll a4,a4,a3    
        and a5,a0,a4
        beqz a5, m_z
        and a5,a1,a4
        beqz a5, m_m
m_p:    li a0,1         # if trs[pos] == +1  
        j m_end
m_z:    li a0,0         # if trs[pos] ==  0   
        j m_end
m_m:    li a0,-1        # if trs[pos] == -1  
m_end:
.end_macro

# -----------------------------------------------------------
#
# Установить трит  в позиции троичного числа
#
# INPUT:        ts1,ts0,pos,val      
# OUTPUT:       ts1,ts0
# DESTROYED:    - 
#
# trs_t set_trit(trs_t t, uint8_t pos, int8_t val);
#
.macro set_trit ($ts1,$ts0,$pos,$val)
        mv a1,$ts1      # a1=ts1  
        mv a0,$ts0      # a0=ts0
        mv a2,$pos
        mv a3,$val        
        li a4,1
        sll a4,a4,a2    
        bgtz  a3, m_p   # if val > 0
        bltz  a3, m_m   # if val < 0
        not a4,a4       # if val == 0      
        and a1,a1,a4    # trs[pos] = 0      
        and a0,a0,a4      
        j m_end           
m_p:    or a1,a1,a4     # trs[pos] = +1      
        or a0,a0,a4                 
        j m_end
m_m:    or a0,a0,a4                         
        not a4,a4         
        and a1,a1,a4    # trs[pos] = -1      
m_end:
.end_macro
