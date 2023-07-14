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
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$10064, %rsp
	movl	%edi, -10052(%rbp)
	movq	%rsi, -10064(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -10040(%rbp)
	movl	$0, -10044(%rbp)
	cmpl	$0, -10052(%rbp)
	jne	.L2
	leaq	.LC0(%rip), %rsi
	leaq	.LC1(%rip), %rdi
	call	fopen@PLT
	movq	%rax, -10040(%rbp)
	jmp	.L3
.L2:
	cmpl	$1, -10052(%rbp)
	jne	.L4
	leaq	.LC0(%rip), %rsi
	leaq	.LC2(%rip), %rdi
	call	fopen@PLT
	movq	%rax, -10040(%rbp)
	jmp	.L3
.L4:
	cmpl	$2, -10052(%rbp)
	jne	.L5
	leaq	.LC0(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	call	fopen@PLT
	movq	%rax, -10040(%rbp)
	jmp	.L3
.L5:
	leaq	__PRETTY_FUNCTION__.3075(%rip), %rcx
	movl	$24, %edx
	leaq	.LC4(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	call	__assert_fail@PLT
.L3:
	cmpq	$0, -10040(%rbp)
	jne	.L7
	leaq	__PRETTY_FUNCTION__.3075(%rip), %rcx
	movl	$27, %edx
	leaq	.LC4(%rip), %rsi
	leaq	.LC5(%rip), %rdi
	call	__assert_fail@PLT
.L10:
	movq	-10024(%rbp), %rax
	leaq	.LC6(%rip), %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	movq	%rax, -10032(%rbp)
	jmp	.L8
.L9:
	movq	-10032(%rbp), %rax
	movl	$10, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	strtol@PLT
	movq	%rax, %rcx
	movl	-10044(%rbp), %eax
	leal	1(%rax), %edx
	movl	%edx, -10044(%rbp)
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-10064(%rbp), %rax
	addq	%rdx, %rax
	cvtsi2ssq	%rcx, %xmm0
	movss	%xmm0, (%rax)
	leaq	.LC6(%rip), %rsi
	movl	$0, %edi
	call	strtok@PLT
	movq	%rax, -10032(%rbp)
.L8:
	cmpq	$0, -10032(%rbp)
	jne	.L9
.L7:
	movq	-10040(%rbp), %rdx
	leaq	-10016(%rbp), %rax
	movl	$10000, %esi
	movq	%rax, %rdi
	call	fgets@PLT
	movq	%rax, -10024(%rbp)
	cmpq	$0, -10024(%rbp)
	jne	.L10
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L11
	call	__stack_chk_fail@PLT
.L11:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	read_csv, .-read_csv
	.globl	test_result
	.type	test_result, @function
test_result:
.LFB6:
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
	jmp	.L13
.L17:
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
	jp	.L18
	ucomiss	%xmm1, %xmm0
	je	.L19
.L18:
	movl	$0, %eax
	jmp	.L16
.L19:
	addl	$1, -4(%rbp)
.L13:
	movl	-4(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.L17
	movl	$1, %eax
.L16:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	test_result, .-test_result
	.globl	matrix_mul
	.type	matrix_mul, @function
matrix_mul:
.LFB7:
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
	subq	$136, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rdi, -120(%rbp)
	movq	%rsi, -128(%rbp)
	movq	%rdx, -136(%rbp)
	movl	%ecx, -140(%rbp)
	movl	%r8d, -144(%rbp)
	movl	%r9d, -148(%rbp)
	movl	-144(%rbp), %r12d
	movslq	%r12d, %rax
	subq	$1, %rax
	movq	%rax, -96(%rbp)
	movslq	%r12d, %rax
	movq	%rax, -176(%rbp)
	movq	$0, -168(%rbp)
	movq	-120(%rbp), %rax
	movq	%rax, -88(%rbp)
	movl	-148(%rbp), %r13d
	movslq	%r13d, %rax
	subq	$1, %rax
	movq	%rax, -80(%rbp)
	movslq	%r13d, %rax
	movq	%rax, %r14
	movl	$0, %r15d
	movq	-128(%rbp), %rax
	movq	%rax, -72(%rbp)
	movl	-148(%rbp), %ebx
	movslq	%ebx, %rax
	subq	$1, %rax
	movq	%rax, -64(%rbp)
	movslq	%ebx, %rax
	movq	%rax, %r10
	movl	$0, %r11d
	movq	-136(%rbp), %rax
	movq	%rax, -56(%rbp)
	movl	-140(%rbp), %eax
	imull	-148(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-56(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	movl	$0, -100(%rbp)
	jmp	.L21
.L26:
	movl	$0, -108(%rbp)
	jmp	.L22
.L25:
	movl	$0, -104(%rbp)
	jmp	.L23
.L24:
	movl	-100(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%r12d, %rax
	imulq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-88(%rbp), %rax
	addq	%rax, %rdx
	movl	-104(%rbp), %eax
	cltq
	movss	(%rdx,%rax,4), %xmm1
	movl	-104(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%r13d, %rax
	imulq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-72(%rbp), %rax
	addq	%rax, %rdx
	movl	-108(%rbp), %eax
	cltq
	movss	(%rdx,%rax,4), %xmm0
	mulss	%xmm1, %xmm0
	movl	-100(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-56(%rbp), %rax
	addq	%rax, %rdx
	movl	-108(%rbp), %eax
	cltq
	movss	(%rdx,%rax,4), %xmm1
	movl	-100(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-56(%rbp), %rax
	addq	%rax, %rdx
	addss	%xmm1, %xmm0
	movl	-108(%rbp), %eax
	cltq
	movss	%xmm0, (%rdx,%rax,4)
	addl	$1, -104(%rbp)
.L23:
	movl	-104(%rbp), %eax
	cmpl	-144(%rbp), %eax
	jl	.L24
	addl	$1, -108(%rbp)
.L22:
	movl	-108(%rbp), %eax
	cmpl	-148(%rbp), %eax
	jl	.L25
	addl	$1, -100(%rbp)
.L21:
	movl	-100(%rbp), %eax
	cmpl	-140(%rbp), %eax
	jl	.L26
	nop
	addq	$136, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	matrix_mul, .-matrix_mul
	.section	.rodata
.LC8:
	.string	"check pass! %fs\n"
.LC9:
	.string	"answer wrong!"
	.text
	.globl	main
	.type	main, @function
main:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movl	$1024, -68(%rbp)
	movl	$1024, -64(%rbp)
	movl	$1024, -60(%rbp)
	movl	-68(%rbp), %eax
	imull	-64(%rbp), %eax
	cltq
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -48(%rbp)
	movl	-64(%rbp), %eax
	imull	-60(%rbp), %eax
	cltq
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -40(%rbp)
	movl	-68(%rbp), %eax
	imull	-60(%rbp), %eax
	cltq
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -32(%rbp)
	movl	-68(%rbp), %eax
	imull	-60(%rbp), %eax
	cltq
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -24(%rbp)
	movq	-48(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	read_csv
	movq	-40(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	read_csv
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	call	read_csv
	call	clock@PLT
	movq	%rax, -16(%rbp)
	movl	-60(%rbp), %r8d
	movl	-64(%rbp), %edi
	movl	-68(%rbp), %ecx
	movq	-32(%rbp), %rdx
	movq	-40(%rbp), %rsi
	movq	-48(%rbp), %rax
	movl	%r8d, %r9d
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	matrix_mul
	call	clock@PLT
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	%eax, %edx
	movq	-16(%rbp), %rax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -56(%rbp)
	cvtsi2ss	-56(%rbp), %xmm0
	movss	.LC7(%rip), %xmm1
	divss	%xmm1, %xmm0
	movss	%xmm0, -52(%rbp)
	movl	-68(%rbp), %eax
	imull	-60(%rbp), %eax
	movl	%eax, %edx
	movq	-24(%rbp), %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	test_result
	testl	%eax, %eax
	je	.L28
	cvtss2sd	-52(%rbp), %xmm0
	leaq	.LC8(%rip), %rdi
	movl	$1, %eax
	call	printf@PLT
	jmp	.L29
.L28:
	leaq	.LC9(%rip), %rdi
	call	puts@PLT
.L29:
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	main, .-main
	.section	.rodata
	.align 8
	.type	__PRETTY_FUNCTION__.3075, @object
	.size	__PRETTY_FUNCTION__.3075, 9
__PRETTY_FUNCTION__.3075:
	.string	"read_csv"
	.align 4
.LC7:
	.long	1232348160
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
