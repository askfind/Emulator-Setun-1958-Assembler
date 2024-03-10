#
# Filename: "setun1958asm.s"
#
# Project: Троичная МЦВМ "Сетунь" 1958 года на языке ассемблера RISC-V
#
# Create date: 01.03.2024
# Edit date:   10.03.2024
#
# Version:     0.14
#
# Author:      Vladimir V.
# E-mail:      askfind@ya.ru
#
# GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
#

#
#  Использование ресурсов RISC-V для "Сетунь-1958"
#
#
# K(1:9)     - код команды (адрес ячейки оперативной памяти)
# F(1:5)     - индекс регистр
# C(1:5)     - программный счетчик
# W(1:1)     - знак троичного числа
#
# S(1:18)    - аккумулятор
# R(1:18)    - регистр множителя
#
# ph1(1:1)   - 1 разряд переполнения
# ph2(1:1)   - 1 разряд переполнения
#
# MB(1:4)    - троичное число зоны магнитного барабана
#
# Дополнительные троичные переменные
#
# MR(1:9)    - временный регистр для обмена с FRAM
# BRPNT(1:5) - точка остановки по значению программного счетчика
#
# TMP(1:36)  - временная переменная для троичного числа
#

#
# Троичные типы данных памяти "Сетунь-1958"
#
# Описание тритов в троичном числе в поле бит
#
#  W(1)	 	W, {t1,t0} = {t1:[b0],t0:[b0]}
#  A(1...5) 	A, {t1,t0} = {t1:[b4...b0],t0:[b4...b0]}
#  K(1...9)	K, {t1,t0} = {t1:[b8...b0],t0:[b8...b0]}
#  S(1...18)	S, {t1,t0} = {t1:[b17...b0],t0:[b17...b0]}
#
#
# SIZE_WORD_SHORT (9)		 /* короткое слово 9-трит  */
# SIZE_WORD_LONG (18)		 /* длинное слово  18-трит */
# SIZE_WORD_LONG_LONG (36) /* двойное длинное слово  36-трит */

#
# Описание ферритовой памяти FRAM
#
# NUMBER_ZONE_FRAM (3)	 /* количество зон ферритовой памяти */
# SIZE_ZONE_TRIT_FRAM (54) /* количнество коротких 9-тритных слов в зоне */
# SIZE_ALL_TRIT_FRAM (162) /* всего количество коротких 9-тритных слов */
#
# SIZE_GRFRAM (2)		   /* количнество груп (0...2) в FRAM */
# SIZE_GR_TRIT_FRAM (81) /* количнество коротких 9-тритных слов в зоне */

#
# Адреса зон ферритовой памяти FRAM
#
# ZONE_M_FRAM_BEG (-120) ' ----0 '
# ZONE_M_FRAM_END (-41)  ' -++++ '
# ZONE_0_FRAM_BEG (-40)  ' 0---0 '
# ZONE_0_FRAM_END (40)   ' 0++++ '
# ZONE_P_FRAM_BEG (42)   ' +---0 '
# ZONE_P_FRAM_END (121)  ' +++++ '
#
#
# Описание магнитного барабана DRUM
#
# SIZE_TRIT_DRUM (1944)	 /* количество хранения коротких слов из 9-тритов */
# SIZE_ZONE_TRIT_DRUM (54) /* количество 9-тритных слов в зоне */
# NUMBER_ZONE_DRUM (36)	 /* количество зон на магнитном барабане */
# ZONE_DRUM_BEG (5)		 /* 01-- */
# ZONE_DRUM_END (40)		 /* ++++ */
#
#
# Типы данных для виртуальной троичной машины "Сетунь-1958"
#
# typedef uintptr_t addr;
#
# typedef struct trs
# {
#	uint8_t l;	 /* длина троичного числа в тритах */
#	uint32_t t1; /* троичное число FALSE,TRUE */
#	uint32_t t0; /* троичное число NIL */
# } trs_t;

# typedef struct long_trs
# {
#	uint8_t l;	 /* длина троичного числа в тритах			*/
#	uint64_t t1; /* троичное число FALSE,TRUE */
#	uint64_t t0; /* троичное число NIL */
# } long_trs_t;
#


# Таб.1 Алфавит троичной симметричной системы счисления
# +--------------------------+-------+-------+-------+
# | Числа                    |  -1   |   0   |   1   |
# +--------------------------+-------+-------+-------+
# | Логика                   | false |  nil  | true  |
# +--------------------------+-------+-------+-------+
# | Логика                   |   f   |   n   |   t   |
# +--------------------------+-------+-------+-------+
# | Символы                  |   -   |	  0   |	  +   |
# +--------------------------+-------+-------+-------+
# | Символы                  |   N   |	  Z   |	  P   |
# +--------------------------+-------+-------+-------+
# | Символы                  |   N   |	  O   |	  P   |
# +--------------------------+-------+-------+-------+
# | Символы                  |   0   |	  i   |	  1   |
# +--------------------------+-------+-------+-------+
# | Символы                  |   v   |	  0   |	  ^   |
# +--------------------------+-------+-------+-------+
#
#   trit = {-1,0,1}  - трит значения трита
#
# -----------------------------------------------------
#   Операции с тритами 
#

.include "logging.s"  # файл с макросами вывода сообщений и отладчоной информации
.include "oper_trit.s"  	 # файл с макросами операций над тритами
.include "oper_trit_test.s" 	 # файл с макросами тестирование операций над тритами
.include "oper_trytes.s"  	 # файл с макросами операций над тритами
.include "oper_trytes_test.s" 	 # файл с макросами тестирование операций над тритами
.include "oper_setun_trs.s"  	 # файл с макросами операций Setun-1958
.include "oper_setun_trs_test.s" # файл с макросами тестирование операций Setun-1958

# ---------------------------------------
# Работа троичной МЦВМ 'Сетунь' 1958 года
#
.globl  main

.data
project: # Название проекта
.string "Ternary small digital computer 'Setun' on RISC-V\n"
begin_emu:
.string "\nBegin emulator 'Setun-1958'\n"
end_emu:
.string "\nEnd emulator 'Setun-1958'\n"


# ------------------------------------------
# Стартовая точка входа
# ------------------------------------------
.text
main:
	puts (project) # Сообщение о проекте

# ------------------------------------------
# Тест фрагмента на ассемблера

# ------------------------------------------
# Запуск тестов

	and_t_test     	# AND_t Тестирование операция над тритами
	or_t_test      	# OR_t: Тестирование операция над тритами
	xor_t_test     	# XOR_t: Тестирование операция над тритами
	not_t_test     	# XOR_t: Тестирование операция над тритами
	sum_half_t_test # SUM_HALF_t Тестирование операция над тритами
	sum_t_test      # SUM_t Тестирование операция над тритами
	trs_t_test      # TRS_t Тестирование операций с троичными числами

        setun_trs_test   # SETUN_TRS Тестирование операций с троичными числами
        view_trs(a1,a0) # вывод троичного числа

# ------------------------------------------
# Запуск эмулятора 'СЕТУНЬ'        

	puts (begin_emu) #
        setun_reset   	 # Сброс эмулятор setun1958asm
	puts (end_emu)   #	


success:
	li a0, 42
	li a7, 93
	ecall
