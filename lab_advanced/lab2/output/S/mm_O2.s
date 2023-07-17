	.file	"mm.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"r"
.LC1:
	.string	"./input/A_1024.csv"
.LC2:
	.string	"./input/B_1024.csv"
.LC3:
	.string	"./input/C_1024.csv"
.LC4:
	.string	"mm.c"
.LC5:
	.string	"0"
.LC6:
	.string	","
	.text
	.p2align 4,,15
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
	subq	$10040, %rsp
	.cfi_def_cfa_offset 10096
	movq	%fs:40, %rax
	movq	%rax, 10024(%rsp)
	xorl	%eax, %eax
	testl	%edi, %edi
	movq	%rsi, 8(%rsp)
	je	.L18
	cmpl	$1, %edi
	je	.L19
	cmpl	$2, %edi
	jne	.L5
	leaq	.LC0(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	call	fopen@PLT
	movq	%rax, %r14
.L3:
	testq	%r14, %r14
	je	.L20
	leaq	16(%rsp), %r15
	leaq	.LC6(%rip), %r12
	xorl	%ebp, %ebp
	.p2align 4,,10
	.p2align 3
.L6:
	movq	%r14, %rdx
	movl	$10000, %esi
	movq	%r15, %rdi
	call	fgets@PLT
	testq	%rax, %rax
	je	.L21
	movq	%r12, %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	testq	%rax, %rax
	je	.L6
	leal	1(%rbp), %ebx
	movq	8(%rsp), %rcx
	movslq	%ebx, %rbx
	subq	%rbx, %rbp
	leaq	(%rcx,%rbp,4), %r13
	.p2align 4,,10
	.p2align 3
.L8:
	xorl	%esi, %esi
	movl	$10, %edx
	movq	%rax, %rdi
	call	strtol@PLT
	pxor	%xmm0, %xmm0
	xorl	%edi, %edi
	movq	%r12, %rsi
	movslq	%ebx, %rbp
	cvtsi2ssq	%rax, %xmm0
	movss	%xmm0, 0(%r13,%rbx,4)
	addq	$1, %rbx
	call	strtok@PLT
	testq	%rax, %rax
	jne	.L8
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L21:
	movq	%r14, %rdi
	call	fclose@PLT
	movq	10024(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L22
	addq	$10040, %rsp
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
	.p2align 4,,10
	.p2align 3
.L18:
	.cfi_restore_state
	leaq	.LC0(%rip), %rsi
	leaq	.LC1(%rip), %rdi
	call	fopen@PLT
	movq	%rax, %r14
	jmp	.L3
.L19:
	leaq	.LC0(%rip), %rsi
	leaq	.LC2(%rip), %rdi
	call	fopen@PLT
	movq	%rax, %r14
	jmp	.L3
.L20:
	leaq	__PRETTY_FUNCTION__.3463(%rip), %rcx
	leaq	.LC4(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$27, %edx
	call	__assert_fail@PLT
.L5:
	leaq	__PRETTY_FUNCTION__.3463(%rip), %rcx
	leaq	.LC4(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$24, %edx
	call	__assert_fail@PLT
.L22:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE52:
	.size	read_csv, .-read_csv
	.p2align 4,,15
	.globl	test_result
	.type	test_result, @function
test_result:
.LFB53:
	.cfi_startproc
	testl	%edx, %edx
	jle	.L27
	movss	(%rdi), %xmm0
	ucomiss	(%rsi), %xmm0
	jp	.L29
	jne	.L29
	leal	-1(%rdx), %eax
	leaq	4(,%rax,4), %rdx
	movl	$4, %eax
	jmp	.L25
	.p2align 4,,10
	.p2align 3
.L26:
	movss	(%rdi,%rax), %xmm0
	addq	$4, %rax
	ucomiss	-4(%rsi,%rax), %xmm0
	jp	.L29
	jne	.L29
.L25:
	cmpq	%rdx, %rax
	jne	.L26
.L27:
	movl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L29:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE53:
	.size	test_result, .-test_result
	.p2align 4,,15
	.globl	matrix_mul
	.type	matrix_mul, @function
matrix_mul:
.LFB54:
	.cfi_startproc
	movq	%rdx, %r10
	movl	%r9d, %edx
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	imull	%ecx, %edx
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
	movl	%ecx, %r14d
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbp
	movq	%rsi, %r13
	movslq	%edx, %rdx
	xorl	%esi, %esi
	movq	%r10, %rdi
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	salq	$2, %rdx
	movslq	%r8d, %r15
	movslq	%r9d, %rbx
	movl	%r9d, 12(%rsp)
	call	memset@PLT
	testl	%r14d, %r14d
	jle	.L30
	movl	12(%rsp), %r9d
	movq	%rax, %r10
	movq	%r15, %r12
	leal	-1(%r12), %edx
	salq	$2, %r15
	salq	$2, %rbx
	xorl	%r8d, %r8d
	leal	-1(%r9), %eax
	leaq	4(%r10,%rax,4), %rdi
	negq	%rax
	leaq	4(%rbp,%rdx,4), %r10
	leaq	-4(,%rax,4), %r11
	.p2align 4,,10
	.p2align 3
.L32:
	testl	%r9d, %r9d
	jle	.L34
	leaq	(%r11,%rdi), %rsi
	movq	%r13, %rcx
	.p2align 4,,10
	.p2align 3
.L37:
	testl	%r12d, %r12d
	jle	.L36
	movss	(%rsi), %xmm1
	movq	%rcx, %rdx
	movq	%rbp, %rax
	.p2align 4,,10
	.p2align 3
.L33:
	movss	(%rax), %xmm0
	addq	$4, %rax
	mulss	(%rdx), %xmm0
	addq	%rbx, %rdx
	cmpq	%r10, %rax
	addss	%xmm0, %xmm1
	movss	%xmm1, (%rsi)
	jne	.L33
.L36:
	addq	$4, %rsi
	addq	$4, %rcx
	cmpq	%rdi, %rsi
	jne	.L37
.L34:
	addl	$1, %r8d
	addq	%rbx, %rdi
	addq	%r15, %rbp
	addq	%r15, %r10
	cmpl	%r8d, %r14d
	jne	.L32
.L30:
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
	.string	"w"
.LC9:
	.string	"./output/result/result.txt"
.LC10:
	.string	"a"
.LC11:
	.string	"%d "
.LC12:
	.string	"./output/time/time.txt"
.LC13:
	.string	"%fs\n"
.LC14:
	.string	"check pass! %fs\n"
.LC15:
	.string	"answer wrong!"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
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
	movl	$4194304, %edi
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
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	call	malloc@PLT
	movl	$4194304, %edi
	movq	%rax, %rbp
	movq	%rax, 16(%rsp)
	call	malloc@PLT
	movl	$4194304, %edi
	movq	%rax, %r15
	movq	%rax, 24(%rsp)
	call	malloc@PLT
	movl	$4194304, %edi
	movq	%rax, %r14
	call	malloc@PLT
	movq	%rbp, %rsi
	xorl	%edi, %edi
	movq	%rax, %rbx
	movq	%rax, (%rsp)
	call	read_csv
	movq	%r15, %rsi
	movl	$1, %edi
	call	read_csv
	movq	%rbx, %rsi
	movl	$2, %edi
	call	read_csv
	call	clock@PLT
	movl	$1024, %r9d
	movl	$1024, %r8d
	movl	$1024, %ecx
	movq	%r14, %rdx
	movq	%r15, %rsi
	movq	%rbp, %rdi
	movq	%rax, %rbx
	call	matrix_mul
	call	clock@PLT
	pxor	%xmm0, %xmm0
	subl	%ebx, %eax
	cvtsi2ss	%eax, %xmm0
	xorl	%eax, %eax
	divss	.LC7(%rip), %xmm0
	jmp	.L42
.L54:
	addq	$4, %rax
	cmpq	$4194304, %rax
	je	.L53
.L42:
	movq	(%rsp), %rdx
	movss	(%r14,%rax), %xmm1
	ucomiss	(%rdx,%rax), %xmm1
	jp	.L41
	je	.L54
.L41:
	leaq	.LC15(%rip), %rdi
	movss	%xmm0, 8(%rsp)
	call	puts@PLT
	pxor	%xmm3, %xmm3
	movss	8(%rsp), %xmm0
	cvtss2sd	%xmm0, %xmm3
	movsd	%xmm3, 8(%rsp)
.L47:
	leaq	.LC8(%rip), %rsi
	leaq	.LC9(%rip), %rdi
	leaq	4194304(%r14), %r13
	leaq	.LC11(%rip), %r12
	movq	%r14, %r15
	call	fopen@PLT
	movq	%rax, %rdi
	call	fclose@PLT
	leaq	.LC10(%rip), %rsi
	leaq	.LC9(%rip), %rdi
	call	fopen@PLT
	movq	%rax, %rbp
	.p2align 4,,10
	.p2align 3
.L44:
	leaq	4096(%r15), %rbx
	.p2align 4,,10
	.p2align 3
.L45:
	cvttss2si	(%r15), %ecx
	xorl	%eax, %eax
	movq	%r12, %rdx
	movl	$1, %esi
	movq	%rbp, %rdi
	addq	$4, %r15
	call	__fprintf_chk@PLT
	cmpq	%r15, %rbx
	jne	.L45
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	cmpq	%r13, %rbx
	jne	.L44
	movq	%rbp, %rdi
	call	fclose@PLT
	leaq	.LC10(%rip), %rsi
	leaq	.LC12(%rip), %rdi
	call	fopen@PLT
	movsd	8(%rsp), %xmm0
	leaq	.LC13(%rip), %rdx
	movl	$1, %esi
	movq	%rax, %rbx
	movq	%rax, %rdi
	movl	$1, %eax
	call	__fprintf_chk@PLT
	movq	%rbx, %rdi
	call	fclose@PLT
	movq	16(%rsp), %rdi
	call	free@PLT
	movq	24(%rsp), %rdi
	call	free@PLT
	movq	%r14, %rdi
	call	free@PLT
	movq	(%rsp), %rdi
	call	free@PLT
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
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
.L53:
	.cfi_restore_state
	pxor	%xmm2, %xmm2
	leaq	.LC14(%rip), %rsi
	movl	$1, %edi
	movl	$1, %eax
	cvtss2sd	%xmm0, %xmm2
	movapd	%xmm2, %xmm0
	movsd	%xmm2, 8(%rsp)
	call	__printf_chk@PLT
	jmp	.L47
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
