#include <asm.h>
#include <regdef.h>
#include <inst_test.h>

LEAF(n21_bne_ds_test)
    .set noreorder
    addiu s0, s0 ,1
    li  s2, 0x00
###test inst
    TEST_BNE_DS(lui,   a0,0x800d)
    TEST_BNE_DS(addiu, a1, a0, 0x8123)
    TEST_BNE_DS(sw,    a1, 0x0120(a0) )
    TEST_BNE_DS(lw,    a2, 0x0120(a0) )
    TEST_BNE_DS(addu,  a3, a1, a2)
    TEST_BNE_DS(or,    t1, s1, s2)
    TEST_BNE_DS(slt,   t2, s2, s3)
    TEST_BNE_DS(sltu,  t8, s2, s3)
    TEST_BNE_DS(sll,   t1, s2, 0x11)
    TEST_BNE_DS(subu,  t5, t0, s0)
    TEST_BNE_DS(and,   t6, t0, s0)
    TEST_BNE_DS(nor,   t8, t0, s0)
    TEST_BNE_DS(xor,   t2, t0, s0)
    TEST_BNE_DS(sra,   t5, s0, 0x8)
    TEST_BNE_DS(srl,   t7, s0, 0x8)
###detect exception
    bne s2, zero, inst_error
    nop
###score ++
    addiu s3, s3, 1
###output (s0<<24)|s3
inst_error:  
    sll t1, s0, 24
    NOP4
    or t0, t1, s3 
    NOP4
    sw t0, 0(s1)
    jr ra
    nop
END(n21_bne_ds_test)
