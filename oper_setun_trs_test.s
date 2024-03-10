#
# Filename: "oper_setun_trs_test.s"
#
# Project: Троичная МЦВМ "Сетунь" 1958 года на языке ассемблера RISC-V
#
# Create date: 10.03.2024
# Edit date:   10.03.2024
#
# Author:      Vladimir V.
# E-mail:      askfind@ya.ru
#
# GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
#

.macro setun_trs_test

.data
setun_trs_tests:
.string	"SETUN_trs tests(...) :\n"
.text   
        logs(setun_trs_tests)
#
#.data
#clean_trs_t1:
#.string	"a0=0xAAAA, a1=0xBBBB; clean_trs(a0,a1)->"
#.text
#      logs(clean_trs_t1)
#      TODO add code
##
  nop  
# --------
.end_macro

