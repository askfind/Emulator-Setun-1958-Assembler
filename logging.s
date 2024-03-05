#
# Filename: "logging.s"
#
# Project: Троичная МЦВМ "Сетунь" 1958 года на языке ассемблера RISC-V
#
# Create date: 03.03.2024
# Edit date:   05.03.2024
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
    li  a7, 1
    ecall
    li a0,' '
    li  a7, 11
    ecall
.end_macro

.macro put                 # print integer
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

