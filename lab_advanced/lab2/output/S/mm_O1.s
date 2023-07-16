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
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$10008, %rsp
	.cfi_def_cfa_offset 10048
	movq	%rsi, %r12
	testl	%edi, %edi
	je	.L13
	cmpl	$1, %edi
	je	.L14
	cmpl	$2, %edi
	jne	.L5
	movl	$.LC0, %esi
	movl	$.LC3, %edi
	call	fopen
	movq	%rax, %r13
.L3:
	testq	%r13, %r13
	je	.L15
	movl	$0, %ebp
.L6:
	movq	%r13, %rdx
	movl	$10000, %esi
	movq	%rsp, %rdi
	call	fgets
	testq	%rax, %rax
	je	.L16
	movl	$.LC6, %esi
	movq	%rax, %rdi
	call	strtok
	testq	%rax, %rax
	je	.L6
	leal	1(%rbp), %ebx
	movslq	%ebx, %rbx
.L8:
	movl	$10, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	strtol
	movl	%ebx, %ebp
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	movss	%xmm0, -4(%r12,%rbx,4)
	movl	$.LC6, %esi
	movl	$0, %edi
	call	strtok
	addq	$1, %rbx
	testq	%rax, %rax
	jne	.L8
	jmp	.L6
.L13:
	movl	$.LC0, %esi
	movl	$.LC1, %edi
	call	fopen
	movq	%rax, %r13
	jmp	.L3
.L14:
	movl	$.LC0, %esi
	movl	$.LC2, %edi
	call	fopen
	movq	%rax, %r13
	jmp	.L3
.L5:
	movl	$__PRETTY_FUNCTION__.3245, %ecx
	movl	$24, %edx
	movl	$.LC4, %esi
	movl	$.LC5, %edi
	call	__assert_fail
.L15:
	movl	$__PRETTY_FUNCTION__.3245, %ecx
	movl	$27, %edx
	movl	$.LC4, %esi
	movl	$.LC5, %edi
	call	__assert_fail
.L16:
	addq	$10008, %rsp
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
	.cfi_endproc
.LFE22:
	.size	read_csv, .-read_csv
	.globl	test_result
	.type	test_result, @function
test_result:
.LFB23:
	.cfi_startproc
	testl	%edx, %edx
	jle	.L21
	movss	(%rdi), %xmm0
	ucomiss	(%rsi), %xmm0
	jp	.L22
	jne	.L22
	leal	-1(%rdx), %edx
	addq	$1, %rdx
	movl	$1, %eax
.L19:
	cmpq	%rax, %rdx
	je	.L24
	movss	(%rdi,%rax,4), %xmm0
	addq	$1, %rax
	ucomiss	-4(%rsi,%rax,4), %xmm0
	jp	.L23
	je	.L19
.L23:
	movl	$0, %eax
	ret
.L24:
	movl	$1, %eax
	ret
.L21:
	movl	$1, %eax
	ret
.L22:
	movl	$0, %eax
	ret
	.cfi_endproc
.LFE23:
	.size	test_result, .-test_result
	.globl	matrix_mul
	.type	matrix_mul, @function
matrix_mul:
.LFB24:
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
	movq	%rsi, %r13
	movq	%rdx, %rdi
	movl	%ecx, %r12d
	movl	%r8d, %ebx
	movl	%r9d, %ebp
	movslq	%r8d, %r15
	movslq	%r9d, %rax
	movq	%rax, (%rsp)
	movl	%r9d, %esi
	imull	%ecx, %esi
	movslq	%esi, %rdx
	salq	$2, %rdx
	movl	$0, %esi
	movq	%rdi, 8(%rsp)
	call	memset
	testl	%r12d, %r12d
	jle	.L25
	movq	(%rsp), %rax
	salq	$2, %rax
	movq	%rax, %rdi
	leal	-1(%rbp), %eax
	movq	8(%rsp), %rsi
	leaq	4(%rsi,%rax,4), %r9
	salq	$2, %r15
	movq	%r14, %r10
	leal	-1(%rbx), %edx
	leaq	4(%r14,%rdx,4), %rsi
	movl	$0, %r11d
	notq	%rax
	leaq	0(,%rax,4), %r14
	jmp	.L27
.L30:
	addq	$4, %r8
	addq	$4, %rcx
	cmpq	%r9, %rcx
	je	.L29
.L31:
	movq	%r8, %rdx
	movq	%r10, %rax
	testl	%ebx, %ebx
	jle	.L30
.L28:
	movss	(%rax), %xmm0
	mulss	(%rdx), %xmm0
	addss	(%rcx), %xmm0
	movss	%xmm0, (%rcx)
	addq	$4, %rax
	addq	%rdi, %rdx
	cmpq	%rsi, %rax
	jne	.L28
	jmp	.L30
.L29:
	addl	$1, %r11d
	addq	%rdi, %r9
	addq	%r15, %r10
	addq	%r15, %rsi
	cmpl	%r11d, %r12d
	je	.L25
.L27:
	testl	%ebp, %ebp
	jle	.L29
	movq	%r13, %r8
	leaq	(%r14,%r9), %rcx
	jmp	.L31
.L25:
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
	.text
	.globl	main
	.type	main, @function
main:
.LFB25:
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
	call	malloc
	movq	%rax, %r14
	movl	$4194304, %edi
	call	malloc
	movq	%rax, %r13
	movl	$4194304, %edi
	call	malloc
	movq	%rax, %r12
	movl	$4194304, %edi
	call	malloc
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
	call	clock
	movq	%rax, %r15
	movl	$1024, %r9d
	movl	$1024, %r8d
	movl	$1024, %ecx
	movq	%r12, %rdx
	movq	%r13, %rsi
	movq	%r14, %rdi
	call	matrix_mul
	call	clock
	movq	%rax, %rbx
	movl	$1048576, %edx
	movq	%rbp, %rsi
	movq	%r12, %rdi
	call	test_result
	testl	%eax, %eax
	je	.L39
	subl	%r15d, %ebx
	pxor	%xmm0, %xmm0
	cvtsi2ss	%ebx, %xmm0
	divss	.LC7(%rip), %xmm0
	cvtss2sd	%xmm0, %xmm0
	movl	$.LC8, %edi
	movl	$1, %eax
	call	printf
.L40:
	movq	%r14, %rdi
	call	free
	movq	%r13, %rdi
	call	free
	movq	%r12, %rdi
	call	free
	movq	%rbp, %rdi
	call	free
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
.L39:
	.cfi_restore_state
	movl	$.LC9, %edi
	call	puts
	jmp	.L40
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
