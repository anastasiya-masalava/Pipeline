! Spring 2023 Revisions by Calvin Khiddee-Wu & Andrej Vrtanoski

! This program executes pow as a test program using the LC 2200-pipe calling convention
! Check your registers ($v0) and memory to see if it is consistent with this program

main:	lea $sp, initsp                         ! 
        lw $sp, 0($sp)                          ! sp = 0xA000
                                                ! WORKS
						
	addi $t0, $zero, 0			
	addi $t0, $zero, 2200                   
	addi $t1, $zero, 42                     
                                                ! WORKS

	blt $t0, $t1, END			
	lea $t2, magic
	lw $t2, 0($t2)			        ! t2 = x002a
	blt $t1, $t2, END			
	blt $t2, $t1, END                       

	blt $zero, $t1, START			
                                                ! WORKS
	halt

START: 

        lea $a0, BASE                          
        lw $a0, 0($a0)                          ! a0 = 2
        lea $a1, EXP                            
        lw $a1, 0($a1)                          ! a1 = 8
                                                ! WORKS

        lea $at, POW                            ! load address of pow
        jalr $ra, $at                           ! WORKS
        lea $a0, ANS                            ! load base for pow
        sw $v0, 0($a0)

END:
        halt                                    ! stop the program here
        addi $v0, $zero, -1                     ! load a bad value on failure to halt

BASE:   .fill 2
EXP:    .fill 8
ANS:	.fill 0                                 ! should come out to 256 (BASE^EXP)

POW:    
        addi $sp, $sp, -1                       
        sw $fp, 0($sp)

        addi $fp, $sp, 0                        ! WORKS

        blt $zero, $a1, BASECHK                 
                                                ! WORKS
        br RET1                                 ! if the exponent is 0, return 1
        
BASECHK:
        blt $zero, $a0, WORK                    ! WORKS
        br RET0

WORK:
        addi $a1, $a1, -1                       ! WORKS

        lea $at, POW                            ! Seems to work
        addi $sp, $sp, -1                       ! 
        sw $ra, 0($sp)
        addi $sp, $sp, -1                       ! 
        sw $a0, 0($sp)
        jalr $ra, $at                           ! recursively call POW
        add $a1, $v0, $zero                     ! store return value in arg 1
        lw $a0, -2($fp)                         ! load the base into arg 0
        lea $at, MULT                           ! load the address of MULT
        jalr $ra, $at                           ! multiply arg 0 (base) and arg 1 (running product)
        lw $a0, 0($sp)
        addi $sp, $sp, 1
        lw $ra, 0($sp)
        addi $sp, $sp, 1

        br FIN                                  ! unconditional branch to FIN

RET1:   add $v0, $zero, $zero                   ! return a value of 0
	addi $v0, $v0, 1                        ! increment and return 1
        br FIN                                  ! unconditional branch to FIN

RET0:   add $v0, $zero, $zero                   ! return a value of 0

FIN:	lw $fp, 0($sp)                          ! restore old frame pointer
        addi $sp, $sp, 1
        jalr $zero, $ra

MULT:   add $v0, $zero, $zero                   ! return value = 0
        addi $t0, $zero, 0                      ! sentinel = 0
AGAIN:  add $v0, $v0, $a0                       ! return value += argument0
        addi $t0, $t0, 1                        ! increment sentinel
        blt $t0, $a1, AGAIN                     ! while sentinel < argument, loop again
        jalr $zero, $ra                         ! return from mult

initsp: .fill 0xA000
magic:  .fill 0x002A
