; ModuleID = '/data/hls-dev/tem/trace-timeline/matrix_mul_row_col_hls/top.host.bc'
source_filename = "/data/hls-dev/toy-test-cases/matrix_mul_row_col_hls/matmul_row_col.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define void @_Z14matmul_row_colPKiS0_Pi(i32* %a, i32* %b, i32* %c) #0 {
entry:
  %a.addr = alloca i32*, align 8
  %b.addr = alloca i32*, align 8
  %c.addr = alloca i32*, align 8
  %A_row = alloca [16 x i32], align 16
  %B_col = alloca [16 x i32], align 16
  %row = alloca i32, align 4
  %col = alloca i32, align 4
  %k = alloca i32, align 4
  %sum = alloca i32, align 4
  %k15 = alloca i32, align 4
  store i32* %a, i32** %a.addr, align 8
  store i32* %b, i32** %b.addr, align 8
  store i32* %c, i32** %c.addr, align 8
  br label %row_loop

row_loop:                                         ; preds = %entry
  store i32 0, i32* %row, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc35, %row_loop
  %0 = load i32, i32* %row, align 4
  %cmp = icmp slt i32 %0, 16
  br i1 %cmp, label %for.body, label %for.end37

for.body:                                         ; preds = %for.cond
  br label %col_loop

col_loop:                                         ; preds = %for.body
  store i32 0, i32* %col, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc32, %col_loop
  %1 = load i32, i32* %col, align 4
  %cmp2 = icmp slt i32 %1, 16
  br i1 %cmp2, label %for.body3, label %for.end34

for.body3:                                        ; preds = %for.cond1
  br label %load_ab_loop

load_ab_loop:                                     ; preds = %for.body3
  store i32 0, i32* %k, align 4
  br label %for.cond4

for.cond4:                                        ; preds = %for.inc, %load_ab_loop
  %2 = load i32, i32* %k, align 4
  %cmp5 = icmp slt i32 %2, 16
  br i1 %cmp5, label %for.body6, label %for.end

for.body6:                                        ; preds = %for.cond4
  %3 = load i32*, i32** %a.addr, align 8
  %4 = load i32, i32* %row, align 4
  %mul = mul nsw i32 %4, 16
  %5 = load i32, i32* %k, align 4
  %add = add nsw i32 %mul, %5
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds i32, i32* %3, i64 %idxprom
  %6 = load i32, i32* %arrayidx, align 4
  %7 = load i32, i32* %k, align 4
  %idxprom7 = sext i32 %7 to i64
  %arrayidx8 = getelementptr inbounds [16 x i32], [16 x i32]* %A_row, i64 0, i64 %idxprom7
  store i32 %6, i32* %arrayidx8, align 4
  %8 = load i32*, i32** %b.addr, align 8
  %9 = load i32, i32* %k, align 4
  %mul9 = mul nsw i32 %9, 16
  %10 = load i32, i32* %col, align 4
  %add10 = add nsw i32 %mul9, %10
  %idxprom11 = sext i32 %add10 to i64
  %arrayidx12 = getelementptr inbounds i32, i32* %8, i64 %idxprom11
  %11 = load i32, i32* %arrayidx12, align 4
  %12 = load i32, i32* %k, align 4
  %idxprom13 = sext i32 %12 to i64
  %arrayidx14 = getelementptr inbounds [16 x i32], [16 x i32]* %B_col, i64 0, i64 %idxprom13
  store i32 %11, i32* %arrayidx14, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body6
  %13 = load i32, i32* %k, align 4
  %inc = add nsw i32 %13, 1
  store i32 %inc, i32* %k, align 4
  br label %for.cond4

for.end:                                          ; preds = %for.cond4
  store i32 0, i32* %sum, align 4
  br label %compute_element_loop

compute_element_loop:                             ; preds = %for.end
  store i32 0, i32* %k15, align 4
  br label %for.cond16

for.cond16:                                       ; preds = %for.inc25, %compute_element_loop
  %14 = load i32, i32* %k15, align 4
  %cmp17 = icmp slt i32 %14, 16
  br i1 %cmp17, label %for.body18, label %for.end27

for.body18:                                       ; preds = %for.cond16
  %15 = load i32, i32* %k15, align 4
  %idxprom19 = sext i32 %15 to i64
  %arrayidx20 = getelementptr inbounds [16 x i32], [16 x i32]* %A_row, i64 0, i64 %idxprom19
  %16 = load i32, i32* %arrayidx20, align 4
  %17 = load i32, i32* %k15, align 4
  %idxprom21 = sext i32 %17 to i64
  %arrayidx22 = getelementptr inbounds [16 x i32], [16 x i32]* %B_col, i64 0, i64 %idxprom21
  %18 = load i32, i32* %arrayidx22, align 4
  %mul23 = mul nsw i32 %16, %18
  %19 = load i32, i32* %sum, align 4
  %add24 = add nsw i32 %19, %mul23
  store i32 %add24, i32* %sum, align 4
  br label %for.inc25

for.inc25:                                        ; preds = %for.body18
  %20 = load i32, i32* %k15, align 4
  %inc26 = add nsw i32 %20, 1
  store i32 %inc26, i32* %k15, align 4
  br label %for.cond16

for.end27:                                        ; preds = %for.cond16
  br label %store_c_element

store_c_element:                                  ; preds = %for.end27
  %21 = load i32, i32* %sum, align 4
  %22 = load i32*, i32** %c.addr, align 8
  %23 = load i32, i32* %row, align 4
  %mul28 = mul nsw i32 %23, 16
  %24 = load i32, i32* %col, align 4
  %add29 = add nsw i32 %mul28, %24
  %idxprom30 = sext i32 %add29 to i64
  %arrayidx31 = getelementptr inbounds i32, i32* %22, i64 %idxprom30
  store i32 %21, i32* %arrayidx31, align 4
  br label %for.inc32

for.inc32:                                        ; preds = %store_c_element
  %25 = load i32, i32* %col, align 4
  %inc33 = add nsw i32 %25, 1
  store i32 %inc33, i32* %col, align 4
  br label %for.cond1

for.end34:                                        ; preds = %for.cond1
  br label %for.inc35

for.inc35:                                        ; preds = %for.end34
  %26 = load i32, i32* %row, align 4
  %inc36 = add nsw i32 %26, 1
  store i32 %inc36, i32* %row, align 4
  br label %for.cond

for.end37:                                        ; preds = %for.cond
  ret void
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 7.0.0 "}
