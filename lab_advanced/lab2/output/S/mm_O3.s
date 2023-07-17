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
	movl	$4, %r9d
	leaq	4(,%rax,4), %rcx
	movq	%rcx, %rdx
	subq	%r9, %rdx
	shrq	$2, %rdx
	andl	$7, %edx
	je	.L25
	movss	4(%rdi), %xmm1
	movl	$8, %r9d
	ucomiss	-4(%rsi,%r9), %xmm1
	jp	.L29
	jne	.L29
	cmpq	$1, %rdx
	je	.L25
	cmpq	$2, %rdx
	je	.L51
	cmpq	$3, %rdx
	je	.L52
	cmpq	$4, %rdx
	je	.L53
	cmpq	$5, %rdx
	je	.L54
	cmpq	$6, %rdx
	je	.L55
	movss	(%rdi,%r9), %xmm2
	addq	$4, %r9
	ucomiss	-4(%rsi,%r9), %xmm2
	jp	.L29
	jne	.L29
.L55:
	movss	(%rdi,%r9), %xmm3
	addq	$4, %r9
	ucomiss	-4(%rsi,%r9), %xmm3
	jp	.L29
	jne	.L29
.L54:
	movss	(%rdi,%r9), %xmm4
	addq	$4, %r9
	ucomiss	-4(%rsi,%r9), %xmm4
	jp	.L29
	jne	.L29
.L53:
	movss	(%rdi,%r9), %xmm5
	addq	$4, %r9
	ucomiss	-4(%rsi,%r9), %xmm5
	jp	.L29
	jne	.L29
.L52:
	movss	(%rdi,%r9), %xmm6
	addq	$4, %r9
	ucomiss	-4(%rsi,%r9), %xmm6
	jp	.L29
	jne	.L29
.L51:
	movss	(%rdi,%r9), %xmm7
	addq	$4, %r9
	ucomiss	-4(%rsi,%r9), %xmm7
	jp	.L29
.L66:
	jne	.L29
.L25:
	cmpq	%rcx, %r9
	je	.L27
	leaq	4(%r9), %r8
	movss	(%rdi,%r9), %xmm8
	ucomiss	-4(%rsi,%r8), %xmm8
	jp	.L29
	jne	.L29
	movss	(%rdi,%r8), %xmm9
	ucomiss	4(%rsi,%r9), %xmm9
	jp	.L29
	jne	.L29
	movss	8(%rdi,%r9), %xmm10
	ucomiss	8(%rsi,%r9), %xmm10
	jp	.L29
	jne	.L29
	movss	12(%rdi,%r9), %xmm11
	ucomiss	12(%rsi,%r9), %xmm11
	jp	.L29
	jne	.L29
	movss	16(%rdi,%r9), %xmm12
	addq	$20, %r9
	ucomiss	-4(%rsi,%r9), %xmm12
	jp	.L29
	jne	.L29
	movss	(%rdi,%r9), %xmm13
	ucomiss	16(%rsi,%r8), %xmm13
	jp	.L29
	jne	.L29
	movss	20(%rdi,%r8), %xmm14
	ucomiss	20(%rsi,%r8), %xmm14
	jp	.L29
	jne	.L29
	leaq	28(%r8), %r9
	movss	24(%rdi,%r8), %xmm15
	ucomiss	-4(%rsi,%r9), %xmm15
	jnp	.L66
.L29:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L27:
	movl	$1, %eax
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
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rdx, %r15
	movl	%r9d, %edx
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
	movl	%ecx, %r12d
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %r13
	movq	%rsi, %rbp
	movslq	%edx, %rdx
	xorl	%esi, %esi
	movq	%r15, %rdi
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	salq	$2, %rdx
	movslq	%r8d, %r14
	movl	%r8d, 12(%rsp)
	movslq	%r9d, %rbx
	movl	%r9d, 8(%rsp)
	call	memset@PLT
	testl	%r12d, %r12d
	jle	.L67
	movl	8(%rsp), %r9d
	leaq	0(,%r14,4), %r11
	leaq	0(,%rbx,4), %r10
	testl	%r9d, %r9d
	jle	.L67
	movl	12(%rsp), %r8d
	testl	%r8d, %r8d
	jle	.L67
	leal	-1(%r9), %eax
	leal	-1(%r8), %ecx
	movq	%r13, %rdi
	xorl	%ebx, %ebx
	leaq	4(%r15,%rax,4), %r9
	negq	%rax
	leaq	4(%r13,%rcx,4), %r8
	leaq	-4(,%rax,4), %r13
	.p2align 4,,10
	.p2align 3
.L70:
	leaq	0(%r13,%r9), %rsi
	movq	%rbp, %r15
	.p2align 4,,10
	.p2align 3
.L73:
	movq	%r8, %r14
	movss	(%rsi), %xmm1
	subq	%rdi, %r14
	movq	%r15, %rax
	movq	%rdi, %rdx
	subq	$4, %r14
	shrq	$2, %r14
	addq	$1, %r14
	andl	$7, %r14d
	je	.L71
	cmpq	$1, %r14
	je	.L97
	cmpq	$2, %r14
	je	.L98
	cmpq	$3, %r14
	je	.L99
	cmpq	$4, %r14
	je	.L100
	cmpq	$5, %r14
	je	.L101
	cmpq	$6, %r14
	je	.L102
	movss	(%rdi), %xmm0
	leaq	4(%rdi), %rdx
	leaq	(%r15,%r10), %rax
	mulss	(%r15), %xmm0
	addss	%xmm0, %xmm1
	movss	%xmm1, (%rsi)
.L102:
	movss	(%rdx), %xmm2
	addq	$4, %rdx
	mulss	(%rax), %xmm2
	addq	%r10, %rax
	addss	%xmm2, %xmm1
	movss	%xmm1, (%rsi)
.L101:
	movss	(%rdx), %xmm3
	addq	$4, %rdx
	mulss	(%rax), %xmm3
	addq	%r10, %rax
	addss	%xmm3, %xmm1
	movss	%xmm1, (%rsi)
.L100:
	movss	(%rdx), %xmm4
	addq	$4, %rdx
	mulss	(%rax), %xmm4
	addq	%r10, %rax
	addss	%xmm4, %xmm1
	movss	%xmm1, (%rsi)
.L99:
	movss	(%rdx), %xmm5
	addq	$4, %rdx
	mulss	(%rax), %xmm5
	addq	%r10, %rax
	addss	%xmm5, %xmm1
	movss	%xmm1, (%rsi)
.L98:
	movss	(%rdx), %xmm6
	addq	$4, %rdx
	mulss	(%rax), %xmm6
	addq	%r10, %rax
	addss	%xmm6, %xmm1
	movss	%xmm1, (%rsi)
.L97:
	movss	(%rdx), %xmm7
	addq	$4, %rdx
	mulss	(%rax), %xmm7
	addq	%r10, %rax
	cmpq	%r8, %rdx
	addss	%xmm7, %xmm1
	movss	%xmm1, (%rsi)
	je	.L111
.L71:
	movss	(%rdx), %xmm8
	addq	$32, %rdx
	mulss	(%rax), %xmm8
	addq	%r10, %rax
	addss	%xmm1, %xmm8
	movss	%xmm8, (%rsi)
	movss	-28(%rdx), %xmm9
	mulss	(%rax), %xmm9
	addq	%r10, %rax
	addss	%xmm9, %xmm8
	movss	%xmm8, (%rsi)
	movss	-24(%rdx), %xmm10
	mulss	(%rax), %xmm10
	addq	%r10, %rax
	addss	%xmm10, %xmm8
	movss	%xmm8, (%rsi)
	movss	-20(%rdx), %xmm11
	mulss	(%rax), %xmm11
	addq	%r10, %rax
	addss	%xmm11, %xmm8
	movss	%xmm8, (%rsi)
	movss	-16(%rdx), %xmm12
	mulss	(%rax), %xmm12
	addq	%r10, %rax
	addss	%xmm12, %xmm8
	movss	%xmm8, (%rsi)
	movss	-12(%rdx), %xmm13
	mulss	(%rax), %xmm13
	addq	%r10, %rax
	addss	%xmm13, %xmm8
	movss	%xmm8, (%rsi)
	movss	-8(%rdx), %xmm14
	mulss	(%rax), %xmm14
	addq	%r10, %rax
	addss	%xmm14, %xmm8
	movss	%xmm8, (%rsi)
	movss	-4(%rdx), %xmm1
	mulss	(%rax), %xmm1
	addq	%r10, %rax
	cmpq	%r8, %rdx
	addss	%xmm8, %xmm1
	movss	%xmm1, (%rsi)
	jne	.L71
.L111:
	addq	$4, %rsi
	addq	$4, %r15
	cmpq	%r9, %rsi
	jne	.L73
	addl	$1, %ebx
	addq	%r10, %r9
	addq	%r11, %rdi
	addq	%r11, %r8
	cmpl	%ebx, %r12d
	jne	.L70
.L67:
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
	movq	%rax, %r13
	movq	%rax, 16(%rsp)
	call	malloc@PLT
	movl	$4194304, %edi
	movq	%rax, %rbp
	movq	%rax, 24(%rsp)
	call	malloc@PLT
	movl	$4194304, %edi
	movq	%rax, %r14
	call	malloc@PLT
	movq	%r13, %rsi
	xorl	%edi, %edi
	movq	%rax, %r15
	call	read_csv
	movq	%rbp, %rsi
	movl	$1, %edi
	call	read_csv
	movq	%r15, %rsi
	movl	$2, %edi
	call	read_csv
	call	clock@PLT
	movl	$1024, %r9d
	movl	$1024, %r8d
	movl	$1024, %ecx
	movq	%r14, %rdx
	movq	%rbp, %rsi
	movq	%r13, %rdi
	movq	%rax, %rbx
	call	matrix_mul
	call	clock@PLT
	pxor	%xmm0, %xmm0
	subl	%ebx, %eax
	cvtsi2ss	%eax, %xmm0
	xorl	%eax, %eax
	divss	.LC7(%rip), %xmm0
.L115:
	movss	(%r14,%rax), %xmm1
	ucomiss	(%r15,%rax), %xmm1
	jp	.L114
	jne	.L114
	movss	4(%r14,%rax), %xmm2
	leaq	4(%rax), %rdx
	ucomiss	4(%r15,%rax), %xmm2
	jp	.L114
	jne	.L114
	movss	8(%r14,%rax), %xmm3
	ucomiss	8(%r15,%rax), %xmm3
	jp	.L114
	jne	.L114
	movss	12(%r14,%rax), %xmm4
	ucomiss	12(%r15,%rax), %xmm4
	jp	.L114
	jne	.L114
	movss	16(%r14,%rax), %xmm5
	ucomiss	16(%r15,%rax), %xmm5
	jp	.L114
	jne	.L114
	movss	16(%r14,%rdx), %xmm6
	ucomiss	16(%r15,%rdx), %xmm6
	jp	.L114
	jne	.L114
	movss	20(%r14,%rdx), %xmm7
	ucomiss	20(%r15,%rdx), %xmm7
	jp	.L114
	jne	.L114
	movss	24(%r14,%rdx), %xmm8
	ucomiss	24(%r15,%rdx), %xmm8
	jp	.L114
	jne	.L114
	leaq	28(%rdx), %rax
	cmpq	$4194304, %rax
	jne	.L115
	cvtss2sd	%xmm0, %xmm0
	leaq	.LC14(%rip), %rsi
	movl	$1, %edi
	movl	$1, %eax
	movsd	%xmm0, 8(%rsp)
	call	__printf_chk@PLT
	jmp	.L120
.L114:
	leaq	.LC15(%rip), %rdi
	movss	%xmm0, (%rsp)
	call	puts@PLT
	pxor	%xmm10, %xmm10
	movss	(%rsp), %xmm9
	cvtss2sd	%xmm9, %xmm10
	movsd	%xmm10, 8(%rsp)
.L120:
	leaq	.LC8(%rip), %rsi
	leaq	.LC9(%rip), %rdi
	leaq	.LC11(%rip), %r12
	movq	%r14, %rbx
	call	fopen@PLT
	movq	%rax, %rdi
	call	fclose@PLT
	leaq	.LC10(%rip), %rsi
	leaq	.LC9(%rip), %rdi
	call	fopen@PLT
	leaq	4194304(%r14), %rcx
	movq	%rax, %rbp
	movq	%rcx, (%rsp)
	.p2align 4,,10
	.p2align 3
.L117:
	leaq	4096(%rbx), %r13
	.p2align 4,,10
	.p2align 3
.L118:
	movq	%r12, %rdx
	movl	$1, %esi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	cvttss2si	(%rbx), %ecx
	addq	$32, %rbx
	call	__fprintf_chk@PLT
	cvttss2si	-28(%rbx), %ecx
	movq	%r12, %rdx
	movl	$1, %esi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	cvttss2si	-24(%rbx), %ecx
	movq	%r12, %rdx
	movl	$1, %esi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	cvttss2si	-20(%rbx), %ecx
	movq	%r12, %rdx
	movl	$1, %esi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	cvttss2si	-16(%rbx), %ecx
	movq	%r12, %rdx
	movl	$1, %esi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	cvttss2si	-12(%rbx), %ecx
	movq	%r12, %rdx
	movl	$1, %esi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	cvttss2si	-8(%rbx), %ecx
	movq	%r12, %rdx
	movl	$1, %esi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	cvttss2si	-4(%rbx), %ecx
	xorl	%eax, %eax
	movq	%r12, %rdx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	__fprintf_chk@PLT
	cmpq	%rbx, %r13
	jne	.L118
	movq	%rbp, %rsi
	movl	$10, %edi
	call	fputc@PLT
	cmpq	%r13, (%rsp)
	jne	.L117
	movq	%rbp, %rdi
	call	fclose@PLT
	leaq	.LC10(%rip), %rsi
	leaq	.LC12(%rip), %rdi
	call	fopen@PLT
	movsd	8(%rsp), %xmm0
	leaq	.LC13(%rip), %rdx
	movl	$1, %esi
	movq	%rax, %r13
	movq	%rax, %rdi
	movl	$1, %eax
	call	__fprintf_chk@PLT
	movq	%r13, %rdi
	call	fclose@PLT
	movq	16(%rsp), %rdi
	call	free@PLT
	movq	24(%rsp), %rdi
	call	free@PLT
	movq	%r14, %rdi
	call	free@PLT
	movq	%r15, %rdi
	call	free@PLT
	addq	$40, %rsp
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
