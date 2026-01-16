{\rtf1\ansi\ansicpg1252\cocoartf2759
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww29740\viewh15820\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 .data\
\
Matrix_1:\
	.word 0, 3, 2, 7\
	.word 0, 3, 1, 4\
	.word 0, 3, 2, 1\
    .word 0, 9, 6, 3\
\
Matrix_2:\
	.word 1, 1, 0, 6\
	.word 3, 1, 2, 0\
	.word 0, 0, 0, 4\
	.word 0, 1, 3, 5\
Matrix_3:\
	.word 0, 0, 0, 0\
	.word 0, 0, 0, 0\
	.word 0, 0, 0, 0\
	.word 0, 0, 0, 0\
.text\
#\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\
MATRIX_MULTIPLICATION:\
\
\
Init:\
	MV x15, x0						#zero x15 (M3 pointer)\
\
	#loop 1 regs\
	MV x18, x0						#store 0 in x18 (i)\
\
	#loop 2 regs\
	MV x19, x0						#store 0 in x19 (j)\
\
\
	#loop 3 regs\
	MV x20, x0						#store 0 in x20 (k)\
	\
	#output reg\
	MV x24, x0						#stores answer b4 saving to memory\
\
\
\
	#CONSTANTS\
	MV x30, x0\
	ADDI x30, x30, 48					#clear and set x30 to 4*width^2\
	MV x31, x0												#4 is size of the word\
	ADDI x31, x31, 16					#clear and set x31 to 4*width\
\
#\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\
\
\
#\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\
	LA x15, Matrix_3\
\
\
Loop:\
\
\
	#load m1 val\
	MV x12, x0					#zero x12\
	LA x12, Matrix_1\
	ADD x12, x12, x18				#add offset in matrix1 to the offset of matrix1\
	ADD x12, x12, x20				#add column. offset of k_m1\
	LW  x12, 0(x12)\
    \
	#load m2 val\
	MV x13, x0					#zero x13\
	LA x13, Matrix_2\
	ADD x13, x13, x20				#add K and Matrix_2 offset\
    ADD x13, x13, x20				#add K and Matrix_2 offset\
	ADD x13, x13, x20				#add K and Matrix_2 offset\
\
	ADD x13, x13, x19				#add J offset\
	LW  x13, 0(x13)\
\
#\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\
\
	CALL Multiply				#go to multiply function\
#\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\
	#x14 populated with the multiplication of x12 and x13\
	ADD x24, x24, x14				#add x14 to the sum total of the row\
	MV x12, x0					#Clear x12\
	MV x13, x0					#clear x13\
    MV x14, x0					#clear x14\
    ADDI x20, x20, 4				#incr K\
	BLT x20, x31, Loop	#jump to loop 3   \
    \
	SW x24, 0(x15)				#store answer\
	ADDI x15, x15, 4				#incr matrix 3 pos\
    MV x24, x0					#clear result reg\
    MV x20, x0					#clear K\
    ADDI x19, x19, 4				#incr J\
    BLT x19, x31, Loop	#jump to 2nd loop\
    MV x19, x0					#clear J\
	ADDI x18, x18, 12			#incr I\
    BLT x18, x30, Loop	#jump to loop 3\
    MV x18, x0			#clear I\
    J Done				#return\
	\
#\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\
\
	\
\
\
#\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\
Multiply:\
	#set multiplier to x12\
	#set multiplied to x13\
	#saves to x14\
M_loop:\
	BEQ x12, x0, The_Return				#when multiply done, send it back\
	ADD x14, x13, x14					#add 13 to 14, save in 14\
	ADDI x12, x12, -1					#decement x12\
	J M_loop						#loop back when done\
#\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\'97\
\
Done:\
	J Done\
\
\
The_Return:\
	ret							#when u want to ret just come here (in case of BEQ or smthn)}