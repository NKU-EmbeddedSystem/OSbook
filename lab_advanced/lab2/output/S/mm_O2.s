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
	.p2align 4,,15
	.globl	read_csv
	.type	read_csv, @function
read_csv:
.LFB22:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$10008, %rsp
	.cfi_def_cfa_offset 10048
	testl	%edi, %edi
	je	.L17
	cmpl	$1, %edi
	je	.L18
	cmpl	$2, %edi
	jne	.L5
	movl	$.LC0, %esi
	movl	$.LC3, %edi
	call	fopen
	movq	%rax, %r12
.L3:
	testq	%r12, %r12
	je	.L19
	xorl	%r13d, %r13d
	.p2align 4,,10
	.p2align 3
.L6:
	movq	%r12, %rdx
	movl	$10000, %esi
	movq	%rsp, %rdi
	call	fgets
	testq	%rax, %rax
	je	.L20
	movl	$.LC6, %esi
	movq	%rax, %rdi
	call	strtok
	testq	%rax, %rax
	je	.L6
	leal	1(%r13), %ebx
	movslq	%ebx, %rbx
	.p2align 4,,10
	.p2align 3
.L8:
	movl	$10, %edx
	xorl	%esi, %esi
	movq	%rax, %rdi
	movl	%ebx, %r13d
	call	strtol
	pxor	%xmm0, %xmm0
	movl	$.LC6, %esi
	xorl	%edi, %edi
	cvtsi2ssq	%rax, %xmm0
	movss	%xmm0, -4(%rbp,%rbx,4)
	addq	$1, %rbx
	call	strtok
	testq	%rax, %rax
	jne	.L8
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L20:
	addq	$10008, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L17:
	.cfi_restore_state
	movl	$.LC0, %esi
	movl	$.LC1, %edi
	call	fopen
	movq	%rax, %r12
	jmp	.L3
.L18:
	movl	$.LC0, %esi
	movl	$.LC2, %edi
	call	fopen
	movq	%rax, %r12
	jmp	.L3
.L5:
	movl	$__PRETTY_FUNCTION__.3245, %ecx
	movl	$24, %edx
	movl	$.LC4, %esi
	movl	$.LC5, %edi
	call	__assert_fail
.L19:
	movl	$__PRETTY_FUNCTION__.3245, %ecx
	movl	$27, %edx
	movl	$.LC4, %esi
	movl	$.LC5, %edi
	call	__assert_fail
	.cfi_endproc
.LFE22:
	.size	read_csv, .-read_csv
	.p2align 4,,15
	.globl	test_result
	.type	test_result, @function
test_result:
.LFB23:
	.cfi_startproc
	testl	%edx, %edx
	jle	.L25
	movss	(%rdi), %xmm0
	ucomiss	(%rsi), %xmm0
	jp	.L27
	jne	.L27
	subl	$1, %edx
	movl	$1, %eax
	addq	$1, %rdx
	jmp	.L23
	.p2align 4,,10
	.p2align 3
.L24:
	movss	(%rdi,%rax,4), %xmm0
	addq	$1, %rax
	ucomiss	-4(%rsi,%rax,4), %xmm0
	jp	.L27
	jne	.L27
.L23:
	cmpq	%rax, %rdx
	jne	.L24
.L25:
	movl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L27:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE23:
	.size	test_result, .-test_result
	.p2align 4,,15
	.globl	matrix_mul
	.type	matrix_mul, @function
matrix_mul:
.LFB24:
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
	movslq	%r8d, %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r12
	xorl	%esi, %esi
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movslq	%edx, %rdx
	movq	%rdi, %rbp
	movq	%r10, %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	salq	$2, %rdx
	movslq	%r9d, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movl	%ecx, 4(%rsp)
	movl	%r8d, 12(%rsp)
	movl	%r9d, 8(%rsp)
	call	memset
	movl	4(%rsp), %ecx
	testl	%ecx, %ecx
	jle	.L28
	movl	8(%rsp), %r9d
	movl	12(%rsp), %r8d
	movq	%rax, %r10
	xorl	%r13d, %r13d
	salq	$2, %rbx
	salq	$2, %r14
	leal	-1(%r9), %eax
	leal	-1(%r8), %edx
	leaq	4(%r10,%rax,4), %r11
	notq	%rax
	leaq	4(%rbp,%rdx,4), %r10
	leaq	0(,%rax,4), %r15
	.p2align 4,,10
	.p2align 3
.L30:
	testl	%r9d, %r9d
	jle	.L32
	movq	%r12, %rdi
	leaq	(%r15,%r11), %rsi
	.p2align 4,,10
	.p2align 3
.L35:
	testl	%r8d, %r8d
	jle	.L34
	movss	(%rsi), %xmm1
	movq	%rdi, %rdx
	movq	%rbp, %rax
	.p2align 4,,10
	.p2align 3
.L31:
	movss	(%rax), %xmm0
	mulss	(%rdx), %xmm0
	addq	$4, %rax
	addq	%rbx, %rdx
	addss	%xmm0, %xmm1
	movss	%xmm1, (%rsi)
	cmpq	%r10, %rax
	jne	.L31
.L34:
	addq	$4, %rsi
	addq	$4, %rdi
	cmpq	%r11, %rsi
	jne	.L35
.L32:
	addl	$1, %r13d
	addq	%rbx, %r11
	addq	%r14, %rbp
	addq	%r14, %r10
	cmpl	%r13d, %ecx
	jne	.L30
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
.LFE24:
	.size	matrix_mul, .-matrix_mul
	.section	.rodata.str1.1
.LC8:
	.string	"%fs\n"
.LC9:
	.string	"answer wrong!"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB25:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movl	$4194304, %edi
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	call	malloc
	movl	$4194304, %edi
	movq	%rax, %r12
	call	malloc
	movl	$4194304, %edi
	movq	%rax, %r13
	call	malloc
	movl	$4194304, %edi
	movq	%rax, %rbx
	call	malloc
	movq	%r12, %rsi
	xorl	%edi, %edi
	movq	%rax, %rbp
	call	read_csv
	movq	%r13, %rsi
	movl	$1, %edi
	call	read_csv
	movq	%rbp, %rsi
	movl	$2, %edi
	call	read_csv
	call	clock
	movq	%rbx, %rdx
	movl	$1024, %ecx
	movq	%r13, %rsi
	movl	$1024, %r9d
	movl	$1024, %r8d
	movq	%r12, %rdi
	movq	%rax, %r14
	call	matrix_mul
	call	clock
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L40:
	movss	(%rbx,%rdx), %xmm0
	ucomiss	0(%rbp,%rdx), %xmm0
	jp	.L39
	jne	.L39
	addq	$4, %rdx
	cmpq	$4194304, %rdx
	jne	.L40
	subl	%r14d, %eax
	pxor	%xmm0, %xmm0
	movl	$.LC8, %edi
	cvtsi2ss	%eax, %xmm0
	movl	$1, %eax
	divss	.LC7(%rip), %xmm0
	cvtss2sd	%xmm0, %xmm0
	call	printf
.L42:
	movq	%r12, %rdi
	call	free
	movq	%r13, %rdi
	call	free
	movq	%rbx, %rdi
	call	free
	movq	%rbp, %rdi
	call	free
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	xorl	%eax, %eax
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L39:
	.cfi_restore_state
	movl	$.LC9, %edi
	call	puts
	jmp	.L42
	.cfi_endproc
.LFE25:
	.size	main, .-main
	.section	.rodata
	.align 8
	.type	__PRETTY_FUNCTION__.3245, @object
	.size	__PRETTY_FUNCTION__.3245, 9
__PRETTY_FUNCTION__.3245:
	.string	"read_csv"
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC7:
	.long	1232348160
	.ident	"GCC: (Uos 8.3.0.3-3+rebuild) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
