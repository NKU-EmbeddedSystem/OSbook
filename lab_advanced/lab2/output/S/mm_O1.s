	.file	"mm.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"r"
.LC1:
	.string	"./input/shape_1024/A_1024.csv"
.LC2:
	.string	"./input/shape_1024/B_1024.csv"
.LC3:
	.string	"./input/shape_1024/C_1024.csv"
.LC4:
	.string	"mm.c"
.LC5:
	.string	"0"
.LC6:
	.string	","
	.text
	.globl	read_csv
	.type	read_csv, @function
read_csv:
.LFB52:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$10024, %rsp
	.cfi_def_cfa_offset 10080
	movq	%rsi, %r13
	movq	%fs:40, %rax
	movq	%rax, 10008(%rsp)
	xorl	%eax, %eax
	testl	%edi, %edi
	je	.L15
	cmpl	$1, %edi
	je	.L16
	cmpl	$2, %edi
	jne	.L5
	leaq	.LC0(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	call	fopen@PLT
	movq	%rax, %r14
.L3:
	testq	%r14, %r14
	je	.L17
	movl	$0, %ebx
	movq	%rsp, %r15
	jmp	.L6
.L15:
	leaq	.LC0(%rip), %rsi
	leaq	.LC1(%rip), %rdi
	call	fopen@PLT
	movq	%rax, %r14
	jmp	.L3
.L16:
	leaq	.LC0(%rip), %rsi
	leaq	.LC2(%rip), %rdi
	call	fopen@PLT
	movq	%rax, %r14
	jmp	.L3
.L5:
	leaq	__PRETTY_FUNCTION__.3463(%rip), %rcx
	movl	$24, %edx
	leaq	.LC4(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	call	__assert_fail@PLT
.L17:
	leaq	__PRETTY_FUNCTION__.3463(%rip), %rcx
	movl	$27, %edx
	leaq	.LC4(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	call	__assert_fail@PLT
.L12:
	movl	%ebx, %ebp
.L7:
	movl	%ebp, %ebx
.L6:
	movq	%r14, %rdx
	movl	$10000, %esi
	movq	%r15, %rdi
	call	fgets@PLT
	testq	%rax, %rax
	je	.L18
	leaq	.LC6(%rip), %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	testq	%rax, %rax
	je	.L12
	leaq	.LC6(%rip), %r12
.L8:
	movl	$10, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	strtol@PLT
	leal	1(%rbx), %ebp
	movslq	%ebx, %rbx
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	movss	%xmm0, 0(%r13,%rbx,4)
	movq	%r12, %rsi
	movl	$0, %edi
	call	strtok@PLT
	movl	%ebp, %ebx
	testq	%rax, %rax
	jne	.L8
	jmp	.L7
.L18:
	movq	10008(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L19
	addq	$10024, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L19:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE52:
	.size	read_csv, .-read_csv
	.globl	test_result
	.type	test_result, @function
test_result:
.LFB53:
	.cfi_startproc
	testl	%edx, %edx
	jle	.L24
	movss	(%rdi), %xmm0
	ucomiss	(%rsi), %xmm0
	jp	.L25
	jne	.L25
	leal	-1(%rdx), %eax
	leaq	4(,%rax,4), %rdx
	movl	$4, %eax
.L22:
	cmpq	%rdx, %rax
	je	.L27
	movss	(%rdi,%rax), %xmm0
	addq	$4, %rax
	ucomiss	-4(%rsi,%rax), %xmm0
	jp	.L26
	je	.L22
.L26:
	movl	$0, %eax
	ret
.L27:
	movl	$1, %eax
	ret
.L24:
	movl	$1, %eax
	ret
.L25:
	movl	$0, %eax
	ret
	.cfi_endproc
.LFE53:
	.size	test_result, .-test_result
	.globl	matrix_mul
	.type	matrix_mul, @function
matrix_mul:
.LFB54:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movq	%rdi, %r14
	movq	%rsi, %r15
	movq	%rdx, %r11
	movl	%ecx, %r13d
	movl	%r8d, %ebx
	movl	%r9d, %r12d
	movslq	%r8d, %rbp
	movslq	%r9d, %rax
	movq	%rax, (%rsp)
	movl	%r9d, %esi
	imull	%ecx, %esi
	movslq	%esi, %rdx
	salq	$2, %rdx
	movl	$0, %esi
	movq	%r11, 8(%rsp)
	movq	%r11, %rdi
	call	memset@PLT
	testl	%r13d, %r13d
	jle	.L28
	salq	$2, %rbp
	movq	(%rsp), %rdi
	salq	$2, %rdi
	leal	-1(%r12), %eax
	movq	8(%rsp), %r11
	leaq	4(%r11,%rax,4), %r9
	movq	%r14, %r10
	leal	-1(%rbx), %edx
	leaq	4(%r14,%rdx,4), %rsi
	negq	%rax
	movl	$0, %r11d
	leaq	-4(,%rax,4), %r14
	jmp	.L30
.L31:
	movss	(%rax), %xmm0
	mulss	(%rdx), %xmm0
	addss	(%rcx), %xmm0
	movss	%xmm0, (%rcx)
	addq	$4, %rax
	addq	%rdi, %rdx
	cmpq	%rsi, %rax
	jne	.L31
.L33:
	addq	$4, %r8
	addq	$4, %rcx
	cmpq	%r9, %rcx
	je	.L32
.L34:
	movq	%r8, %rdx
	movq	%r10, %rax
	testl	%ebx, %ebx
	jg	.L31
	jmp	.L33
.L32:
	addl	$1, %r11d
	addq	%rdi, %r9
	addq	%rbp, %r10
	addq	%rbp, %rsi
	cmpl	%r11d, %r13d
	je	.L28
.L30:
	testl	%r12d, %r12d
	jle	.L32
	movq	%r15, %r8
	leaq	(%r14,%r9), %rcx
	jmp	.L34
.L28:
	addq	$24, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE54:
	.size	matrix_mul, .-matrix_mul
	.section	.rodata.str1.1
.LC8:
	.string	"check pass! %fs\n"
.LC9:
	.string	"answer wrong!"
	.text
	.globl	main
	.type	main, @function
main:
.LFB55:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	movl	$4194304, %edi
	call	malloc@PLT
	movq	%rax, %r14
	movl	$4194304, %edi
	call	malloc@PLT
	movq	%rax, %r13
	movl	$4194304, %edi
	call	malloc@PLT
	movq	%rax, %r12
	movl	$4194304, %edi
	call	malloc@PLT
	movq	%rax, %rbp
	movq	%r14, %rsi
	movl	$0, %edi
	call	read_csv
	movq	%r13, %rsi
	movl	$1, %edi
	call	read_csv
	movq	%rbp, %rsi
	movl	$2, %edi
	call	read_csv
	call	clock@PLT
	movq	%rax, %r15
	movl	$1024, %r9d
	movl	$1024, %r8d
	movl	$1024, %ecx
	movq	%r12, %rdx
	movq	%r13, %rsi
	movq	%r14, %rdi
	call	matrix_mul
	call	clock@PLT
	movq	%rax, %rbx
	movl	$1048576, %edx
	movq	%rbp, %rsi
	movq	%r12, %rdi
	call	test_result
	testl	%eax, %eax
	jne	.L45
	leaq	.LC9(%rip), %rdi
	call	puts@PLT
.L43:
	movq	%r14, %rdi
	call	free@PLT
	movq	%r13, %rdi
	call	free@PLT
	movq	%r12, %rdi
	call	free@PLT
	movq	%rbp, %rdi
	call	free@PLT
	movl	$0, %eax
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L45:
	.cfi_restore_state
	subl	%r15d, %ebx
	pxor	%xmm0, %xmm0
	cvtsi2ss	%ebx, %xmm0
	divss	.LC7(%rip), %xmm0
	cvtss2sd	%xmm0, %xmm0
	leaq	.LC8(%rip), %rsi
	movl	$1, %edi
	movl	$1, %eax
	call	__printf_chk@PLT
	jmp	.L43
	.cfi_endproc
.LFE55:
	.size	main, .-main
	.section	.rodata
	.align 8
	.type	__PRETTY_FUNCTION__.3463, @object
	.size	__PRETTY_FUNCTION__.3463, 9
__PRETTY_FUNCTION__.3463:
	.string	"read_csv"
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC7:
	.long	1232348160
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
