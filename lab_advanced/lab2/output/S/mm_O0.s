	.file	"mm.c"
	.text
	.section	.rodata
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
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$10048, %rsp
	movl	%edi, -10036(%rbp)
	movq	%rsi, -10048(%rbp)
	movq	$0, -8(%rbp)
	movl	$0, -20(%rbp)
	cmpl	$0, -10036(%rbp)
	jne	.L2
	movl	$.LC0, %esi
	movl	$.LC1, %edi
	call	fopen
	movq	%rax, -8(%rbp)
	jmp	.L3
.L2:
	cmpl	$1, -10036(%rbp)
	jne	.L4
	movl	$.LC0, %esi
	movl	$.LC2, %edi
	call	fopen
	movq	%rax, -8(%rbp)
	jmp	.L3
.L4:
	cmpl	$2, -10036(%rbp)
	jne	.L5
	movl	$.LC0, %esi
	movl	$.LC3, %edi
	call	fopen
	movq	%rax, -8(%rbp)
	jmp	.L3
.L5:
	movl	$__PRETTY_FUNCTION__.3182, %ecx
	movl	$24, %edx
	movl	$.LC4, %esi
	movl	$.LC5, %edi
	call	__assert_fail
.L3:
	cmpq	$0, -8(%rbp)
	jne	.L7
	movl	$__PRETTY_FUNCTION__.3182, %ecx
	movl	$27, %edx
	movl	$.LC4, %esi
	movl	$.LC5, %edi
	call	__assert_fail
.L10:
	movq	-32(%rbp), %rax
	movl	$.LC6, %esi
	movq	%rax, %rdi
	call	strtok
	movq	%rax, -16(%rbp)
	jmp	.L8
.L9:
	movq	-16(%rbp), %rax
	movl	$10, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	strtol
	movq	%rax, %rcx
	movl	-20(%rbp), %eax
	leal	1(%rax), %edx
	movl	%edx, -20(%rbp)
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-10048(%rbp), %rax
	addq	%rdx, %rax
	cvtsi2ssq	%rcx, %xmm0
	movss	%xmm0, (%rax)
	movl	$.LC6, %esi
	movl	$0, %edi
	call	strtok
	movq	%rax, -16(%rbp)
.L8:
	cmpq	$0, -16(%rbp)
	jne	.L9
.L7:
	movq	-8(%rbp), %rdx
	leaq	-10032(%rbp), %rax
	movl	$10000, %esi
	movq	%rax, %rdi
	call	fgets
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.L10
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	read_csv, .-read_csv
	.globl	test_result
	.type	test_result, @function
test_result:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, -36(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L12
.L16:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movss	(%rax), %xmm0
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movss	(%rax), %xmm1
	ucomiss	%xmm1, %xmm0
	jp	.L17
	ucomiss	%xmm1, %xmm0
	je	.L18
.L17:
	movl	$0, %eax
	jmp	.L15
.L18:
	addl	$1, -4(%rbp)
.L12:
	movl	-4(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.L16
	movl	$1, %eax
.L15:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	test_result, .-test_result
	.globl	matrix_mul
	.type	matrix_mul, @function
matrix_mul:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$216, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rdi, -152(%rbp)
	movq	%rsi, -160(%rbp)
	movq	%rdx, -168(%rbp)
	movl	%ecx, -172(%rbp)
	movl	%r8d, -176(%rbp)
	movl	%r9d, -180(%rbp)
	movl	-176(%rbp), %r12d
	movslq	%r12d, %rax
	subq	$1, %rax
	movq	%rax, -72(%rbp)
	movslq	%r12d, %rax
	movq	%rax, -208(%rbp)
	movq	$0, -200(%rbp)
	movl	-176(%rbp), %eax
	movslq	%eax, %rdx
	subq	$1, %rdx
	movq	%rdx, -64(%rbp)
	cltq
	movq	%rax, -224(%rbp)
	movq	$0, -216(%rbp)
	movq	-152(%rbp), %rax
	movq	%rax, -56(%rbp)
	movl	-180(%rbp), %r13d
	movslq	%r13d, %rax
	subq	$1, %rax
	movq	%rax, -96(%rbp)
	movslq	%r13d, %rax
	movq	%rax, -240(%rbp)
	movq	$0, -232(%rbp)
	movl	-180(%rbp), %eax
	movslq	%eax, %rdx
	subq	$1, %rdx
	movq	%rdx, -104(%rbp)
	cltq
	movq	%rax, -256(%rbp)
	movq	$0, -248(%rbp)
	movq	-160(%rbp), %rax
	movq	%rax, -112(%rbp)
	movl	-180(%rbp), %ebx
	movslq	%ebx, %rax
	subq	$1, %rax
	movq	%rax, -120(%rbp)
	movslq	%ebx, %rax
	movq	%rax, %r14
	movl	$0, %r15d
	movl	-180(%rbp), %eax
	movslq	%eax, %rdx
	subq	$1, %rdx
	movq	%rdx, -128(%rbp)
	cltq
	movq	%rax, %r10
	movl	$0, %r11d
	movq	-168(%rbp), %rax
	movq	%rax, -136(%rbp)
	movl	-172(%rbp), %eax
	imull	-180(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-136(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset
	movl	$0, -84(%rbp)
	jmp	.L20
.L25:
	movl	$0, -76(%rbp)
	jmp	.L21
.L24:
	movl	$0, -80(%rbp)
	jmp	.L22
.L23:
	movl	-84(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%r12d, %rax
	imulq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-56(%rbp), %rax
	addq	%rax, %rdx
	movl	-80(%rbp), %eax
	cltq
	movss	(%rdx,%rax,4), %xmm1
	movl	-80(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%r13d, %rax
	imulq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-112(%rbp), %rax
	addq	%rax, %rdx
	movl	-76(%rbp), %eax
	cltq
	movss	(%rdx,%rax,4), %xmm0
	mulss	%xmm0, %xmm1
	movl	-84(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-136(%rbp), %rax
	addq	%rax, %rdx
	movl	-76(%rbp), %eax
	cltq
	movss	(%rdx,%rax,4), %xmm0
	movl	-84(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-136(%rbp), %rax
	addq	%rax, %rdx
	addss	%xmm1, %xmm0
	movl	-76(%rbp), %eax
	cltq
	movss	%xmm0, (%rdx,%rax,4)
	addl	$1, -80(%rbp)
.L22:
	movl	-80(%rbp), %eax
	cmpl	-176(%rbp), %eax
	jl	.L23
	addl	$1, -76(%rbp)
.L21:
	movl	-76(%rbp), %eax
	cmpl	-180(%rbp), %eax
	jl	.L24
	addl	$1, -84(%rbp)
.L20:
	movl	-84(%rbp), %eax
	cmpl	-172(%rbp), %eax
	jl	.L25
	nop
	addq	$216, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	matrix_mul, .-matrix_mul
	.section	.rodata
.LC8:
	.string	"%fs\n"
.LC9:
	.string	"answer wrong!"
	.text
	.globl	main
	.type	main, @function
main:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movl	$1024, -4(%rbp)
	movl	$1024, -8(%rbp)
	movl	$1024, -12(%rbp)
	movl	-4(%rbp), %eax
	imull	-8(%rbp), %eax
	cltq
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -24(%rbp)
	movl	-8(%rbp), %eax
	imull	-12(%rbp), %eax
	cltq
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -32(%rbp)
	movl	-4(%rbp), %eax
	imull	-12(%rbp), %eax
	cltq
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -40(%rbp)
	movl	-4(%rbp), %eax
	imull	-12(%rbp), %eax
	cltq
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -48(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	read_csv
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	read_csv
	movq	-48(%rbp), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	call	read_csv
	call	clock
	movq	%rax, -56(%rbp)
	movl	-12(%rbp), %r8d
	movl	-8(%rbp), %edi
	movl	-4(%rbp), %ecx
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rax
	movl	%r8d, %r9d
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	matrix_mul
	call	clock
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	movl	%eax, %edx
	movq	-56(%rbp), %rax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -68(%rbp)
	cvtsi2ss	-68(%rbp), %xmm0
	movss	.LC7(%rip), %xmm1
	divss	%xmm1, %xmm0
	movss	%xmm0, -72(%rbp)
	movl	-4(%rbp), %eax
	imull	-12(%rbp), %eax
	movl	%eax, %edx
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	test_result
	testl	%eax, %eax
	je	.L27
	cvtss2sd	-72(%rbp), %xmm0
	movl	$.LC8, %edi
	movl	$1, %eax
	call	printf
	jmp	.L28
.L27:
	movl	$.LC9, %edi
	call	puts
.L28:
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	main, .-main
	.section	.rodata
	.align 8
	.type	__PRETTY_FUNCTION__.3182, @object
	.size	__PRETTY_FUNCTION__.3182, 9
__PRETTY_FUNCTION__.3182:
	.string	"read_csv"
	.align 4
.LC7:
	.long	1232348160
	.ident	"GCC: (Uos 8.3.0.3-3+rebuild) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
