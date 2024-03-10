#
# Filename: "logging.s"
#
# Project: Троичная МЦВМ "Сетунь" 1958 года на языке ассемблера RISC-V
#
# Create date: 03.03.2024
# Edit date:   11.03.2024
#
# Author:      Vladimir V.
# E-mail:      askfind@ya.ru
#
# GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
#

#
# Логирование тестирования и работы эмулятора
#
.macro loglf                 # print integer
    li a0,'\n'
    li  a7, 11
    ecall
.end_macro

.macro logi                 # print integer
    mv  a1,a0
    bgez a0,m_p
m_m:    
    li a0,'-'
    li  a7, 11
    ecall
    not a0,a1
    addi a0,a0,1    
m_p:
    li  a7, 1
    ecall
    li a0,' '
    li  a7, 11
    ecall
.end_macro

.macro put                 # print integer    
    mv  t0,a0
    bgez t0,m_p
    li a0,'-'
    li  a7, 11
    ecall
    not t0,t0
    addi a0,t0,1    
m_p:
    li  a7, 1
    ecall
    li a0,'\n'
    li  a7, 11
    ecall
.end_macro

.macro logs (%str)         # print string 
    li a0,' '
    li  a7, 11
    ecall
    la a0,%str
    li  a7, 4
    ecall
.end_macro

.macro logstr (%str)         # print string 
    la a0,%str
    li  a7, 4
    ecall
.end_macro


.macro puts (%str)         # print string 
    li a0,' '
    li  a7, 11
    ecall
    la a0,%str
    li  a7, 4
    ecall
    li a0,'\n'
    li  a7, 11
    ecall
.end_macro

.macro view_trs ($tryte1_1,$tryte1_0) # печать трайта TRITS-32
      #TODO add code
      #
      # TRS : [+0++0+---000000000], (148547601)

# test ----------------
#.data
#test_view_trs: # образец вывода троичного числа
#.string "TRS : [+0++0+---000000000], (148547601)\n"
#.text
#      puts (test_view_trs)
# end test ------------

.data
pre_view_trs: # образец вывода троичного числа
.string "trs : ["
.text
        mv t1,$tryte1_1          # t1=tryte1.1  
        mv t0,$tryte1_0          # t0=tryte1.0  

        li t2,0                  # i=0 счетчик номера трита

        logstr (pre_view_trs)

m_loop:                          # параметры для вызова макроса     
        mv a1,t1                 # tmp1.1 = tryte1.1  
        mv a0,t0                 # tmp1.0 = tryte1.0  
        li t3,31
        sub a3,t3,t2             # 31-pos
        get_trit(a1,a0,a3)       # a0 = get_trit(...)  
        beqz a0, m_z
	bltz a0, m_m
m_p:
        li a0,'+'
        li  a7, 11
        ecall	 	
        j m_next 
m_z:                
        li a0,'0'
        li  a7, 11
        ecall
        j m_next 
m_m:
        li a0,'-'
        li  a7, 11
        ecall
m_next:
        addi t2,t2,1             # i = i - 1
        li a0,31                 
        ble t2,a0,m_loop           # if i <= 0  goto m_loop     

m_end:      
.data
post_view_trs: # образец вывода троичного числа
.string "]\n"
.text
         logstr (post_view_trs)
.end_macro
