#
# Filename: "oper_trytes.s"
#
# Project: Троичная МЦВМ "Сетунь" 1958 года на языке ассемблера RISC-V
#
# Create date: 05.03.2024
# Edit date:   11.03.2024
#
#
# Author:      Vladimir V.
# E-mail:      askfind@ya.ru
#
# GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
#

# TODO  ++++++++++++++++++++++++++++++++++++++++
# Добавить операции для троичных чисел из тритов
# trs_t mul_trs(trs_t a, trs_t b);
# trs_t div_trs(trs_t a, trs_t b);
# void mod_3_n(trs_t *t, uint8_t n);
# ++++++++++++++++++++++++++++++++++++++++++++++

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
#  Троичные числа в двоичных регистрах
#  TRITS-1  =>               
#                reg1[b0]    биты регистров  
#                reg0[b0]
#
#                if ( reg0[b0] == 1 )
#                   if ( reg1[b0] == 1 ) TRUE 
#                          trit = +1
#                    else 
#                          trit = -1     FALSE
#                    endif
#                else if ( reg0[b0] == 0 )
#                         trit = 0       NIL    
#                endif  
#
#  TRITS-32 = [t31...t0] - обозначение позиции тритов в числе
#
#                reg1[b31...b0]    биты регистров  
#                reg0[b31...b0]
#


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


# ---------------------------------------------------------------
#
# Сдвиг троичного числа на N-тритов
#
# INPUT:        ts1,ts0,shift
# OUTPUT:       ts1,ts0
# DESTROYED:    -
#
# trs_t shift_trs(trs_t t, int8_t shift);
#
.macro shift_trs ($ts1,$ts0,$shift)
        
        mv a1,$ts1      # a1=ts1  
        mv a0,$ts0      # a0=ts0
        mv a2,$shift
        
        bgez a2,m_end   # if a2 == 0 goto m_end
        bgtz a2, m_p    # if val > 0
        li a4,-31
        blt a2,a4,m_clr # if a2 < -31  goto m_end        
        not a2,a2
        addi a2,a2,1
        srl a1,a1,a2   # if val < 0
        srl a0,a0,a2  
        j m_end                
m_p:
        li  a4,31                 
        bgt a2,a4,m_clr # if a2 > 31  goto m_end
	sll a1,a1,a2
        sll a0,a0,a2
        j m_end
m_clr:  mv a1,zero
        mv a0,zero
m_end:        
.end_macro

# ---------------------------------------------------------------
#
# TRITS-32
#
# Взять из троичного числа поле тритов [pos1,pos2] и
# переместить в позицию [pos1-len(pos1,pos2),pos=0].
#
# INPUT:        ts1,ts0,pos1,pos2
# OUTPUT:       ts1,ts0
# DESTROYED:    -
#
# trs_t slice_trs(trs_t t, int8_t pos1, int8_t pos2);
#
.macro slice_trs ($ts1,$ts0,$pos1,$pos2)
        mv a1,$ts1         # a1=ts1  
        mv a0,$ts0         # a0=ts0
        mv a2,$pos1
        mv a3,$pos2
                           # проверить параметры              
        bgt a3,a2,m_end    # if a3 > a2 goto m_end
        li  a4,31          
        bgt a2,a4,m_clr    # if a2 > 31  goto m_end
        bgt a3,a4,m_clr    # if a2 > 31  goto m_end
        bltz a2,m_clr      # if a2 <  0  goto m_end
        bltz a3,m_clr      # if a2 <  0  goto m_end

        sub a4,a2,a3       # len = pos1-pos2      
        li  a5,0xFFFFFFFF  # mask  
        srl a5,a5,a4       # mask >>= len        
        srl a1,a1,a4       # tryte.1 >>= len     
        and a1,a1,a5       # tryte.1 &= mask
        srl a0,a0,a4       # tryte.0 >>= len     
        and a0,a0,a5       # tryte.0 &= mask
        j m_end             
m_clr:  nop
        nop
m_end:      
.end_macro

# ---------------------------------------------------------------
#
# ADD_trs( TRITS-32, TRITS-32)
#
# Логическое умноджение двух троичных чисел 
#
# INPUT:        tryte1_1,tryte1_0,
#               tryte2_1,tryte2_0
# OUTPUT:       a1=tryte3_1, a0=tryte3_0
# DESTROYED:    -
#
#  trs_t and_trs(trs_t a, trs_t b);
#
.macro and_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)
        
        mv t1,$tryte1_1          # t1=tryte1.1  
        mv t0,$tryte1_0          # t0=tryte1.0  
        mv t3,$tryte2_1          # t3=tryte2.1  
        mv t2,$tryte2_0          # t2=tryte2.0  
        
        li s1,0                  # i=0 счетчик номера трита        

m_loop:
                                 # параметры для вызова макроса     
        mv a1,t1                 # tmp.1 = tryte1.1  
        mv a0,t0                 # tmp.0 = tryte1.0  
        mv a3,s1                 # pos
        get_trit(a1,a0,a4)       # a0 = get_trit(...)  
        mv s2,a0                 # store trit tryte1[pos]
        
        mv a1,t3                 # tmp.1 = tryte2.1  
        mv a0,t2                 # tmp.0 = tryte2.0  
        mv a3,s1                 # pos = i
        get_trit(a1,a0,a3)       # get_trit(...)  
        mv s3,a0                 # store trit tryte2[pos]

        mv a0,s2                 # trit1
        mv a1,s3                 # trit2        
        and_t(a0,a1)                         
        mv a3,a0                 # store trit to a3

        mv a1,t5                 # set trit to tryte3[i]
        mv a0,t4                 #          
        mv a2,s1                 #
        set_trit(a1,a0,a2,a3)    # 
        mv t5,a1                 # store tryte3[i]
        mv t4,a0                 #          
        
        addi s1,s1,1             # i = i - 1
        li a0,31                 
        ble s1,a0,m_loop       # if i <= 31  goto m_loop     

        mv a1,t5                 # return tryte3
        mv a0,t4                 #                
m_end:      
.end_macro


# ---------------------------------------------------------------
#
# OR_trs( TRITS-32, TRITS-32)
#
# Логическое умноджение двух троичных чисел 
#
# INPUT:        tryte1_1,tryte1_0,
#               tryte2_1,tryte2_0
# OUTPUT:       a1=tryte3_1, a0=tryte3_0
# DESTROYED:    -
#
# trs_t or_trs(trs_t a, trs_t b);
#
.macro or_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)
        
        mv t1,$tryte1_1          # t1=tryte1.1  
        mv t0,$tryte1_0          # t0=tryte1.0  
        mv t3,$tryte2_1          # t3=tryte2.1  
        mv t2,$tryte2_0          # t2=tryte2.0  
        
        li s1,0                  # i=0 счетчик номера трита        

m_loop:
                                 # параметры для вызова макроса     
        mv a1,t1                 # tmp1.1 = tryte1.1  
        mv a0,t0                 # tmp1.0 = tryte1.0  
        mv a3,t6                 # pos
        get_trit(a1,a0,a4)       # a0 = get_trit(...)  
        mv s2,a0                 # store trit tryte1[pos]
        
        mv a1,t3                 # tmp1.1 = tryte2.1  
        mv a0,t2                 # tmp1.0 = tryte2.0  
        mv a3,s1                 # pos = i
        get_trit(a1,a0,a3)       # get_trit(...)  
        mv s3,a0                 # store trit tryte2[pos]

        mv a0,s2                 # trit1
        mv a1,s3                 # trit2        
        or_t(a0,a1)                 
        mv a3,a0                 # store trit to a3

        mv a1,t5                 # set trit to tryte3[i]
        mv a0,t4                 #          
        mv a2,s1                 #
        set_trit(a1,a0,a2,a3)    # 
        mv t5,a1                 # store tryte3[i]
        mv t4,a0                 #          
        
        addi s1,s1,1             # i = i - 1
        li a0,31                 
        ble s1,a0,m_loop           # if i <= 0  goto m_loop     

        mv a1,t5                 # return tryte3
        mv a0,t4                 #                
m_end:      
.end_macro

# ---------------------------------------------------------------
#
# NOT_trs( TRITS-32 )
#
# Логическое умноджение двух троичных чисел 
#
# INPUT:        tryte1_1,tryte1_0               
# OUTPUT:       a1=tryte3_1, a0=tryte3_0
# DESTROYED:    -
#
# trs_t not_trs(trs_t a);
#
.macro not_trs ($tryte1_1,$tryte1_0)
        mv t1,$tryte1_1          # t1=tryte1.1  
        mv t0,$tryte1_0          # t0=tryte1.0  
        not t1,t1
        mv a1,t1
        mv a0,t0
.end_macro


# ---------------------------------------------------------------
#
# XOR_trs( TRITS-32, TRITS-32)
#
# Логическое умноджение двух троичных чисел 
#
# INPUT:        tryte1_1,tryte1_0,
#               tryte2_1,tryte2_0
# OUTPUT:       a1=tryte3_1, a0=tryte3_0
# DESTROYED:    -
#
# trs_t xor_trs(trs_t a, trs_t b);
#
.macro xor_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)
        
        mv t1,$tryte1_1          # t1=tryte1.1  
        mv t0,$tryte1_0          # t0=tryte1.0  
        mv t3,$tryte2_1          # t3=tryte2.1  
        mv t2,$tryte2_0          # t2=tryte2.0  
        
        li s1,0                  # i=0 счетчик номера трита        

m_loop:
                                 # параметры для вызова макроса     
        mv a1,t1                 # tmp1.1 = tryte1.1  
        mv a0,t0                 # tmp1.0 = tryte1.0  
        mv a3,t6                 # pos
        get_trit(a1,a0,a4)       # a0 = get_trit(...)  
        mv s2,a0                 # store trit tryte1[pos]
        
        mv a1,t3                 # tmp1.1 = tryte2.1  
        mv a0,t2                 # tmp1.0 = tryte2.0  
        mv a3,s1                 # pos = i
        get_trit(a1,a0,a3)       # get_trit(...)  
        mv s3,a0                 # store trit tryte2[pos]

        mv a0,s2                 # trit1
        mv a1,s3                 # trit2        
        xor_t(a0,a1)                 
        mv a3,a0                 # store trit to a3

        mv a1,t5                 # set trit to tryte3[i]
        mv a0,t4                 #          
        mv a2,s1                 #
        set_trit(a1,a0,a2,a3)    # 
        mv t5,a1                 # store tryte3[i]
        mv t4,a0                 #          
        
        addi s1,s1,1             # i = i - 1
        li a0,31                 
        ble s1,a0,m_loop         # if i <= 0  goto m_loop     

        mv a1,t5                 # return tryte3
        mv a0,t4                 #                
m_end:      
.end_macro


# ---------------------------------------------------------------
#
# ADD_trs( TRITS-32, TRITS-32)  
#
# Сложить два троичных числа
#
# INPUT:        tryte1_1,tryte1_0,
#               tryte2_1,tryte2_0
# OUTPUT:       a1=tryte3_1, a0=tryte3_0, a2=p 
# DESTROYED:    -
#
#  trs_t and_trs(trs_t a, trs_t b);
#
.macro add_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)
        
        mv t1,$tryte1_1          # t1=tryte1.1  
        mv t0,$tryte1_0          # t0=tryte1.0  
        mv t3,$tryte2_1          # t3=tryte2.1  
        mv t2,$tryte2_0          # t2=tryte2.0  
        
        li s1,0                  # i=0 счетчик номера трита
        li s4,0                  # p=0 перенос при сложении тритов

m_loop:
                                 # параметры для вызова макроса             
        mv a1,t1                 # tmp1.1 = tryte1.1  
        mv a0,t0                 # tmp1.0 = tryte1.0  
        mv a3,s1                 # pos
        get_trit(a1,a0,a3)       # a0 = get_trit(...)  
        mv s2,a0                 # store trit tryte1[pos]
       	
        mv a1,t3                 # tmp1.1 = tryte2.1  
        mv a0,t2                 # tmp1.0 = tryte2.0  
        mv a3,s1                 # pos = i
        get_trit(a1,a0,a3)       # get_trit(...)  
        mv s3,a0                 # store trit tryte2[pos]
	
        mv a0,s2                 # trit1
        mv a1,s3                 # trit2
        mv a2,s4                 # p
        sum_t(a0,a1,a2)         
        mv s4,a1                 # store p 
        mv a3,a0                 # store trit to a3
	
        mv a1,t5                 # set trit to tryte3[i]
        mv a0,t4                 #          
        mv a2,s1                 #
        set_trit(a1,a0,a2,a3)    # 
        mv t5,a1                 # store tryte3[i]
        mv t4,a0                 #           
        
        addi s1,s1,1             # i = i - 1
        li a0,31                 # len max
        ble s1,a0,m_loop         # if i <= 31  goto m_loop     
        
        mv a1,t5                 # return tryte3
        mv a0,t4                 #        
        mv a2,s4                 # return p перенос при переполнении       
m_end:     

.end_macro

# ---------------------------------------------------------------
#
# SUB_trs( TRITS-32, TRITS-32)  
#
# Сложить два троичных числа
#
# INPUT:        tryte1_1,tryte1_0,
#               tryte2_1,tryte2_0
# OUTPUT:       a1=tryte3_1, a0=tryte3_0, a2=p 
# DESTROYED:    -
#
#  trs_t and_trs(trs_t a, trs_t b);
#
.macro sub_trs ($tryte1_1,$tryte1_0,$tryte2_1,$tryte2_0)
        
        mv t1,$tryte1_1          # t1=tryte1.1  
        mv t0,$tryte1_0          # t0=tryte1.0  
        
        mv t3,$tryte2_1          # t3=tryte2.1  
        mv t2,$tryte2_0          # t2=tryte2.0
        not t3,t3                # tryte2 = 0 - tryte2
        
        li s1,0                  # i=0 счетчик номера трита
        li s4,0                  # p=0 перенос при сложении тритов

m_loop:
                                 # параметры для вызова макроса     
        mv a1,t1                 # tmp1.1 = tryte1.1  
        mv a0,t0                 # tmp1.0 = tryte1.0  
        mv a3,s1                 # pos
        get_trit(a1,a0,a3)       # a0 = get_trit(...)  
        mv s2,a0                 # store trit tryte1[pos]
        
        mv a1,t3                 # tmp1.1 = tryte2.1  
        mv a0,t2                 # tmp1.0 = tryte2.0  
        mv a3,s1                 # pos = i
        get_trit(a1,a0,a3)       # get_trit(...)  
        mv s3,a0                 # store trit tryte2[pos]

        mv a0,s2                 # trit1
        mv a1,s3                 # trit2
        mv a2,s4                 # p
        sum_t(a0,a1,a2)         
        mv s4,a1                 # store p 
        mv a3,a0                 # store trit to a3

        mv a1,t5                 # set trit to tryte3[i]
        mv a0,t4                 #          
        mv a2,s1                 #
        set_trit(a1,a0,a2,a3)    # 
        mv t5,a1                 # store tryte3[i]
        mv t4,a0                 #          
        
        addi s1,s1,1             # i = i - 1
        li a0,31                 
        ble s1,a0,m_loop           # if i <= 31  goto m_loop     

        mv a1,t5                 # return tryte3
        mv a0,t4                 #        
        mv a2,s4                 # return p перенос при переполнении       
m_end:      
.end_macro


# ---------------------------------------------------------------
#
# INC_trs( TRITS-32 )  
#
# Сложить два троичных числа
#
# INPUT:        tryte1_1,tryte1_0,
# OUTPUT:       a1=tryte2_1, a0=tryte2_0, a3=p 
# DESTROYED:    -
#
#  void inc_trs(trs_t *tr);
#
.macro inc_trs ($tryte1_1,$tryte1_0)
        
        mv t1,$tryte1_1          # t1=tryte1.1  
        mv t0,$tryte1_0          # t0=tryte1.0  

        mv t3,zero               # t3=tryte2.1=0  
        mv t2,zero               # t2=tryte2.0=0          

        mv a1,t3                 # set trit to tryte2[i]
        mv a0,t2                 #          
        li a2,0                  # pos=0
        li a3,1                  # set trit=1 to tryte2
        set_trit(a1,a0,a2,a3)    # 
        mv t3,a1                 # store tryte2
        mv t2,a0                 #          

        li s1,0                  # i=0 счетчик номера трита
        li s4,0                  # p=0 перенос при сложении тритов
        
m_loop:
                                 # параметры для вызова макроса     
        mv a1,t1                 # tmp1.1 = tryte1.1  
        mv a0,t0                 # tmp1.0 = tryte1.0  
        mv a3,s1                 # pos
        get_trit(a1,a0,a3)       # a0 = get_trit(...)  
        mv s2,a0                 # store trit tryte1[pos]
        
        mv a1,t3                 # tmp1.1 = tryte2.1  
        mv a0,t2                 # tmp1.0 = tryte2.0  
        mv a3,s1                 # pos = i
        get_trit(a1,a0,a3)       # get_trit(...)  
        mv s3,a0                 # store trit tryte2[pos]

        mv a0,s2                 # trit1
        mv a1,s3                 # trit2
        mv a2,s4                 # p
        sum_t(a0,a1,a2)         
        mv s4,a1                 # store p 
        mv a3,a0                 # store trit to a3

        mv a1,t5                 # set trit to tryte3[i]
        mv a0,t4                 #          
        mv a2,s1                 #
        set_trit(a1,a0,a2,a3)    # 
        mv t5,a1                 # store tryte3[i]
        mv t4,a0                 #          
        
        addi s1,s1,1             # i = i - 1
        li a0,31                 
        ble s1,a0,m_loop           # if i <= 0  goto m_loop     

        mv a1,t5                 # return tryte3
        mv a0,t4                 #        
        mv a2,s4                 # return p перенос при переполнении       
m_end:      
.end_macro

# ---------------------------------------------------------------
#
# INC_trs( TRITS-32 )  
#
# Сложить два троичных числа
#
# INPUT:        tryte1_1,tryte1_0,
# OUTPUT:       a1=tryte2_1, a0=tryte2_0, a3=p 
# DESTROYED:    -
#
#  void inc_trs(trs_t *tr);
#
.macro dec_trs ($tryte1_1,$tryte1_0)
        
        mv t1,$tryte1_1          # t1=tryte1.1  
        mv t0,$tryte1_0          # t0=tryte1.0  

        mv t3,zero               # t3=tryte2.1=0  
        mv t2,zero               # t2=tryte2.0=0          

        mv a1,t3                 # set trit to tryte2[i]
        mv a0,t2                 #          
        li a2,0                  # pos=0
        li a3,-1                  # set trit=-1 to tryte2
        set_trit(a1,a0,a2,a3)    # 
        mv t3,a1                 # store tryte2
        mv t2,a0                 #          

        li s1,0                  # i=0 счетчик номера трита
        li s4,0                  # p=0 перенос при сложении тритов

m_loop:
                                 # параметры для вызова макроса     
        mv a1,t1                 # tmp1.1 = tryte1.1  
        mv a0,t0                 # tmp1.0 = tryte1.0  
        mv a3,s1                 # pos
        get_trit(a1,a0,a3)       # a0 = get_trit(...)  
        mv s2,a0                 # store trit tryte1[pos]
        
        mv a1,t3                 # tmp1.1 = tryte2.1  
        mv a0,t2                 # tmp1.0 = tryte2.0  
        mv a3,s1                 # pos = i
        get_trit(a1,a0,a3)       # get_trit(...)  
        mv s3,a0                 # store trit tryte2[pos]

        mv a0,s2                 # trit1
        mv a1,s3                 # trit2
        mv a2,s4                 # p
        sum_t(a0,a1,a2)         
        mv s4,a1                 # store p 
        mv a3,a0                 # store trit to a3

        mv a1,t5                 # set trit to tryte3[i]
        mv a0,t4                 #          
        mv a2,s1                 #
        set_trit(a1,a0,a2,a3)    # 
        mv t5,a1                 # store tryte3[i]
        mv t4,a0                 #          
        
        addi s1,s1,1             # i = i - 1
        li a0,31                 
        ble s1,a0,m_loop           # if i <= 0  goto m_loop     

        mv a1,t5                 # return tryte3
        mv a0,t4                 #        
        mv a2,s4                 # return p перенос при переполнении       
m_end:      
.end_macro
