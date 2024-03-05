#
# Filename: "oper_trytes_test.s"
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

.macro trs_t_test

.data
trs_t_tests:
.string	"TRS_t tests(...) :\n"        
.text   
        logs(trs_t_tests)
#
.data
clean_trs_t1:
.string	"a0=0xAAAA, a1=0xBBBB; clean_trs(a0,a1)->"
.text
        logs(clean_trs_t1)
        li a0,0xAAAA
        li a1,0xBBBB
        clean_trs(a0,a1)
        logi
        mv a0,a1
        logi
        loglf
#
.data
get_trit_t2:
.string	"ts1=0x1, ts0=0x1,pos=0; get_trit(ts1,ts0,pos)->"
.text
        logs(get_trit_t2)
        li a1,0x1
        li a0,0x1
        li a3,0
        get_trit(a1,a0,a3)
        logi
        loglf
#
.data
get_trit_t3:
.string	"ts1=0x0, ts0=0x1,pos=0; get_trit(ts1,ts0,pos)->"
.text
        logs(get_trit_t3)
        li a1,0x0
        li a0,0x1
        li a3,0
        get_trit(a1,a0,a3)
        logi
        loglf

#
.data
get_trit_t4:
.string	"ts1=0x0, ts0=0x0,pos=0; get_trit(ts1,ts0,pos)->"
.text
        logs(get_trit_t4)
        li a1,0x0
        li a0,0x0
        li a3,0
        get_trit(a1,a0,a3)
        logi
        loglf

#
.data
get_trit_t5:
.string	"ts1=0x4, ts0=0x4,pos=2; get_trit(ts1,ts0,pos)->"
.text
        logs(get_trit_t5)
        li a1,0x4
        li a0,0x4
        li a3,2
        get_trit(a1,a0,a3)
        logi
        loglf

#
.data
get_trit_t6:
.string	"ts1=0x0, ts0=0x4,pos=2; get_trit(ts1,ts0,pos)->"
.text
        logs(get_trit_t6)
        li a1,0x0
        li a0,0x4
        li a3,2
        get_trit(a1,a0,a3)
        logi
        loglf

#
.data
get_trit_t7:
.string	"ts1=0x0, ts0=0x0,pos=2; get_trit(ts1,ts0,pos)->"
.text
        logs(get_trit_t7)
        li a1,0x0
        li a0,0x0
        li a3,2
        get_trit(a1,a0,a3)
        logi
        loglf

#        
.end_macro