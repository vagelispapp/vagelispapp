# Calculate sums of positive odd and negative even values in an array
#   in MIPS assembly using MARS
# for MYΥ-402 - Computer Architecture
# Department of Computer Engineering, University of Ioannina
# Aris Efthymiou

        .globl main # declare the label main as global. 
        
        .text 
     
main:
        la         $a0, length       		# get address of length to $a0
        lw         $a0, 0($a0)       		# get the length in to $a0

        la         $a1, input        		# get address of array to $a1

        addiu      $s0, $zero, 0     		# sum of positive odd values starts as 0
        addiu      $s1, $zero, 0     		# sum of negative even values starts as 0
	
	add	   $s2, $zero, $zero 		# $s2 set to 0, that is the counter
    	 
    	la         $a2, length       		# get address of length to $a2
        lw         $a2, 0($a2) 			# get the length in to $a2
    	    	          	      	 
        la  	   $a0, input			# get address of input to $a0
        		   		   		   		   
loop:
	beq	 $s2, $a2, exitloop		# while $s2 != length of arrey dont break the loop
	addi	 $s2, $s2, 1			# count how many times the loop is repeated
	lw 	 $s3, 0($a0)			# sets $s3 to the current element in input 
	slti	 $t6, $s3, 0			# if $s3<0 $t6=1	
	bne	 $t6, $zero, negative		# if $t6!=0 goto negative
	j	 positive			# else goto positive
negative:
	andi 	 $t7, $s3, 1			# if $t7=0 $s3 is equal
	beq	 $t7, $zero, even		# goto equal	
	j	 skip2				# if $t7!=0 goto skip2
even:
	add 	 $s1, $s1, $s3			# counts negative even elements
	j	 skip2				# if the element is negative even number it is not necessary to check the other cases
skip1:
positive:
	andi	 $t8, $s3, 1			# if $t8!=0 $s3 is odd
	bne	 $t8, $zero, odd		# goto odd
	j	 skip2				# if $t8=0 goto skip2
odd:
	add 	 $s0, $s0, $s3			# counts positive odd elements
skip2:
	addi	 $a0, $a0, 4			# advance the array to start at the next location from last time
	j	 loop				# start the loop again
exitloop:

exit: 
        addiu      $v0, $zero, 10    		# system service 10 is exit
        syscall                      		# we are outta here.
        
        ###############################################################################
        # Data input.
        ###############################################################################
        .data
length: .word 5 # Number of values in the input array
input:  .word 3, -2, 0, 4, -1
